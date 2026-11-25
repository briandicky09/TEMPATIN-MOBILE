import 'dart:io';
import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'offline_demo_database.dart';
import 'offline_demo_pdf_builder.dart';

/// In-process Dio interceptor routing `/api/v1/*` requests to local SQLite when
/// [isOfflineDemo] returns `true`. When `false`, requests pass straight through
/// to the configured Laravel REST backend without modification.
class OfflineDemoInterceptor extends Interceptor {
  OfflineDemoInterceptor({
    required this.db,
    required this.isOfflineDemo,
  });

  final OfflineDemoDatabase db;
  final bool Function() isOfflineDemo;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!isOfflineDemo()) {
      handler.next(options);
      return;
    }

    try {
      final path = _normalizePath(options);
      final method = options.method.toUpperCase();
      final user = await _authenticateRequest(options);
      final response = await _dispatch(options, method, path, user);
      handler.resolve(response);
    } on _HttpDemoError catch (e) {
      handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.badResponse,
          response: Response<dynamic>(
            requestOptions: options,
            statusCode: e.statusCode,
            data: {
              'success': false,
              'message': e.message,
            },
          ),
        ),
      );
    } catch (e) {
      handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.unknown,
          error: e,
        ),
      );
    }
  }

  String _normalizePath(RequestOptions options) {
    var path = options.path;
    final apiIdx = path.indexOf('/api/v1');
    if (apiIdx >= 0) {
      path = path.substring(apiIdx + '/api/v1'.length);
    }
    if (!path.startsWith('/')) path = '/$path';
    if (path.length > 1 && path.endsWith('/')) {
      path = path.substring(0, path.length - 1);
    }
    return path;
  }

  Future<Map<String, dynamic>?> _authenticateRequest(
    RequestOptions options,
  ) async {
    final auth =
        options.headers['Authorization']?.toString() ??
        options.headers['authorization']?.toString();
    if (auth == null || !auth.toLowerCase().startsWith('bearer ')) {
      return null;
    }
    final token = auth.substring(7).trim();
    return db.findUserByToken(token);
  }

  String? _bearerToken(RequestOptions options) {
    final auth =
        options.headers['Authorization']?.toString() ??
        options.headers['authorization']?.toString();
    if (auth == null || !auth.toLowerCase().startsWith('bearer ')) return null;
    return auth.substring(7).trim();
  }

  Map<String, dynamic> _requireUser(Map<String, dynamic>? user) {
    if (user == null) {
      throw const _HttpDemoError(
        401,
        'Sesi Anda telah berakhir. Silakan masuk kembali.',
      );
    }
    return user;
  }

  Map<String, dynamic> _requireOwner(Map<String, dynamic>? user) {
    final u = _requireUser(user);
    if (u['role'] != 'owner') {
      throw const _HttpDemoError(
        403,
        'Akses khusus akun Pemilik Kos.',
      );
    }
    return u;
  }

  Response<dynamic> _ok(
    RequestOptions options,
    dynamic data, {
    int statusCode = 200,
    String message = 'OK',
    Map<String, dynamic>? extra,
  }) {
    return Response<Map<String, dynamic>>(
      requestOptions: options,
      statusCode: statusCode,
      data: <String, dynamic>{
        'success': true,
        'message': message,
        'data': data,
        ...?extra,
      },
    );
  }

  Response<dynamic> _pdfResponse(RequestOptions options, List<int> bytes) {
    return Response<List<int>>(
      requestOptions: options,
      statusCode: 200,
      headers: Headers.fromMap({
        Headers.contentTypeHeader: ['application/pdf'],
      }),
      data: bytes,
    );
  }

  Future<Response<dynamic>> _dispatch(
    RequestOptions options,
    String method,
    String path,
    Map<String, dynamic>? user,
  ) async {
    // 1. Auth routes
    if (path.startsWith('/auth/')) {
      return _handleAuth(options, method, path, user);
    }

    // 2. Profile & Notifications
    if (path == '/profile' || path.startsWith('/notifications')) {
      return _handleProfileAndNotifications(options, method, path, user);
    }

    // 3. Owner management
    if (path.startsWith('/owner/')) {
      return _handleOwner(options, method, path, user);
    }

    // 4. Discovery & Favorites
    if (path == '/home' ||
        path == '/facilities' ||
        path == '/kos' ||
        path.startsWith('/kos/') && !path.endsWith('/surveys') && !path.endsWith('/conversations') ||
        path.startsWith('/favorites')) {
      return _handleDiscovery(options, method, path, user);
    }

    // 5. Chat
    if (path.startsWith('/conversations') || path.endsWith('/conversations')) {
      return _handleChat(options, method, path, user);
    }

    // 6. Bookings, Payments, Contracts, Invoices, Surveys, Maintenance
    return _handleTransactions(options, method, path, user);
  }

  // ---- AUTH ----

  Future<Response<dynamic>> _handleAuth(
    RequestOptions options,
    String method,
    String path,
    Map<String, dynamic>? user,
  ) async {
    final db = await this.db.database;
    final body = await _readBody(options.data);

    if (path == '/auth/login' && method == 'POST') {
      final email = (body['email'] as String? ?? '').trim().toLowerCase();
      final password = body['password'] as String? ?? '';
      if (email.isEmpty || password.isEmpty) {
        throw const _HttpDemoError(422, 'Email dan kata sandi wajib diisi.');
      }
      final rows = await db.query(
        'users',
        where: 'LOWER(email) = ?',
        whereArgs: [email],
        limit: 1,
      );
      if (rows.isEmpty || rows.first['password'] != password) {
        throw const _HttpDemoError(
          422,
          'Email atau kata sandi tidak sesuai.',
        );
      }
      final u = rows.first;
      final token =
          'demo-token-${u['id']}-${DateTime.now().millisecondsSinceEpoch}';
      await db.insert('sessions', {
        'token': token,
        'user_id': u['id'],
        'created_at': DateTime.now().toIso8601String(),
      });
      return _ok(options, {
        'token': token,
        'user': {
          'id': u['id'],
          'name': u['name'],
          'email': u['email'],
          'role': u['role'],
          'phone': u['phone'],
          'avatar_url': u['avatar_url'],
        },
      }, message: 'Berhasil masuk dalam Mode Demo Offline.');
    }

    if (path == '/auth/register' && method == 'POST') {
      final name = (body['name'] as String? ?? '').trim();
      final email = (body['email'] as String? ?? '').trim().toLowerCase();
      final phone = (body['phone'] as String? ?? '').trim();
      final role = (body['role'] as String? ?? 'customer').toLowerCase() ==
              'owner'
          ? 'owner'
          : 'customer';
      final password = body['password'] as String? ?? '';
      final confirm = body['password_confirmation'] as String? ?? '';

      if (name.isEmpty || email.isEmpty || password.length < 8) {
        throw const _HttpDemoError(
          422,
          'Nama, email valid, dan kata sandi min. 8 karakter wajib diisi.',
        );
      }
      if (password != confirm) {
        throw const _HttpDemoError(
          422,
          'Konfirmasi kata sandi tidak cocok.',
        );
      }
      final existing = await db.query(
        'users',
        where: 'LOWER(email) = ?',
        whereArgs: [email],
        limit: 1,
      );
      if (existing.isNotEmpty) {
        throw const _HttpDemoError(422, 'Email sudah terdaftar di akun demo.');
      }

      final now = DateTime.now().toIso8601String();
      final newId = await db.insert('users', {
        'name': name,
        'email': email,
        'password': password,
        'role': role,
        'phone': phone,
        'avatar_url': null,
        'created_at': now,
      });
      final token = 'demo-token-$newId-${DateTime.now().millisecondsSinceEpoch}';
      await db.insert('sessions', {
        'token': token,
        'user_id': newId,
        'created_at': now,
      });
      return _ok(options, {
        'token': token,
        'user': {
          'id': newId,
          'name': name,
          'email': email,
          'role': role,
          'phone': phone,
          'avatar_url': null,
        },
      }, statusCode: 201);
    }

    if (path == '/auth/forgot-password' && method == 'POST') {
      return _ok(
        options,
        const <String, dynamic>{},
        message:
            'Simulasi offline: instruksi reset kata sandi telah dicatat secara lokal.',
      );
    }

    if (path == '/auth/reset-password' && method == 'POST') {
      final email = (body['email'] as String? ?? '').trim().toLowerCase();
      final password = body['password'] as String? ?? '';
      if (email.isNotEmpty && password.length >= 8) {
        await db.update(
          'users',
          {'password': password},
          where: 'LOWER(email) = ?',
          whereArgs: [email],
        );
      }
      return _ok(
        options,
        const <String, dynamic>{},
        message: 'Kata sandi akun demo berhasil diperbarui secara lokal.',
      );
    }

    if (path == '/auth/me' && method == 'GET') {
      final u = _requireUser(user);
      final userId = u['id'] as int;
      final unreadNotif = Sqflite.firstIntValue(
            await db.rawQuery(
              'SELECT COUNT(*) FROM notifications WHERE user_id = ? AND read_at IS NULL',
              [userId],
            ),
          ) ??
          0;
      final unreadChat = Sqflite.firstIntValue(
            await db.rawQuery(
              '''
              SELECT COUNT(*) FROM messages m
              INNER JOIN conversations c ON c.id = m.conversation_id
              WHERE (c.customer_id = ? OR c.owner_id = ?)
                AND m.sender_id != ? AND m.is_read = 0
              ''',
              [userId, userId, userId],
            ),
          ) ??
          0;
      return _ok(options, {
        'user': u,
        'unread_notifications_count': unreadNotif,
        'unread_messages_count': unreadChat,
      });
    }

    if (path == '/auth/logout' && method == 'POST') {
      final token = _bearerToken(options);
      if (token != null) {
        await db.delete('sessions', where: 'token = ?', whereArgs: [token]);
      }
      return _ok(options, const <String, dynamic>{}, message: 'Berhasil keluar.');
    }

    throw const _HttpDemoError(404, 'Endpoint autentikasi tidak ditemukan.');
  }

  // ---- PROFILE & NOTIFICATIONS ----

  Future<Response<dynamic>> _handleProfileAndNotifications(
    RequestOptions options,
    String method,
    String path,
    Map<String, dynamic>? user,
  ) async {
    final db = await this.db.database;
    final u = _requireUser(user);
    final userId = u['id'] as int;

    if (path == '/profile' && method == 'GET') {
      return _ok(options, {'user': u});
    }

    if (path == '/profile' && method == 'POST') {
      final body = await _readBody(options.data);
      final name = (body['name'] as String? ?? u['name'] as String).trim();
      final phone = body['phone'] as String? ?? u['phone'] as String?;
      var avatarUrl = u['avatar_url'] as String?;
      final uploadedAvatar = body['_file_avatar'] as _SavedDemoFile?;
      if (uploadedAvatar != null) {
        avatarUrl = uploadedAvatar.localPath;
      }

      final updates = <String, Object?>{
        'name': name,
        'phone': phone,
        'avatar_url': avatarUrl,
      };
      final newPassword = body['password'] as String?;
      if (newPassword != null && newPassword.isNotEmpty) {
        updates['password'] = newPassword;
      }

      await db.update('users', updates, where: 'id = ?', whereArgs: [userId]);
      final refreshed = (await db.query(
        'users',
        where: 'id = ?',
        whereArgs: [userId],
        limit: 1,
      )).first;

      return _ok(options, {
        'user': {
          'id': refreshed['id'],
          'name': refreshed['name'],
          'email': refreshed['email'],
          'role': refreshed['role'],
          'phone': refreshed['phone'],
          'avatar_url': refreshed['avatar_url'],
        },
      });
    }

    if (path == '/notifications' && method == 'GET') {
      final page = _queryInt(options, 'page', 1);
      final perPage = _queryInt(options, 'per_page', 20);
      final allRows = await db.query(
        'notifications',
        where: 'user_id = ?',
        whereArgs: [userId],
        orderBy: 'created_at DESC',
      );
      final unreadCount = allRows.where((r) => r['read_at'] == null).length;
      final paged = _paginate(allRows, page, perPage);
      final items = paged.map(this.db.buildNotificationJson).toList();
      final meta = await this.db.buildPaginationMeta(
        page: page,
        perPage: perPage,
        total: allRows.length,
      );
      return _ok(
        options,
        {'items': items, 'unread_count': unreadCount},
        extra: {'meta': meta},
      );
    }

    if (path == '/notifications/read-all' && method == 'POST') {
      await db.update(
        'notifications',
        {'read_at': DateTime.now().toIso8601String()},
        where: 'user_id = ? AND read_at IS NULL',
        whereArgs: [userId],
      );
      return _ok(options, const <String, dynamic>{});
    }

    final notifMatch = RegExp(r'^/notifications/([^/]+)/read$').firstMatch(path);
    if (notifMatch != null && method == 'POST') {
      final id = notifMatch.group(1)!;
      await db.update(
        'notifications',
        {'read_at': DateTime.now().toIso8601String()},
        where: 'id = ? AND user_id = ?',
        whereArgs: [id, userId],
      );
      return _ok(options, const <String, dynamic>{});
    }

    throw const _HttpDemoError(404, 'Endpoint tidak ditemukan.');
  }

  // ---- DISCOVERY & FAVORITES ----

  Future<Response<dynamic>> _handleDiscovery(
    RequestOptions options,
    String method,
    String path,
    Map<String, dynamic>? user,
  ) async {
    final db = await this.db.database;
    final userId = user?['id'] as int?;

    if (path == '/facilities' && method == 'GET') {
      return _ok(options, await this.db.fetchFacilitiesList());
    }

    if (path == '/home' && method == 'GET') {
      final rows = await db.query(
        'kos',
        where: "status = 'active'",
        orderBy: 'id ASC',
        limit: 6,
      );
      final featured = <Map<String, dynamic>>[];
      for (final row in rows) {
        featured.add(
          await this.db.buildKosSummaryJson(db, row, currentUserId: userId),
        );
      }

      final cityRows = await db.rawQuery('''
        SELECT city, COUNT(*) AS kos_count
        FROM kos
        WHERE status = 'active'
        GROUP BY city
        ORDER BY kos_count DESC, city ASC
      ''');
      final cities = cityRows
          .map(
            (r) => {
              'city': r['city'],
              'kos_count': r['kos_count'],
            },
          )
          .toList();

      return _ok(options, {
        'featured_kos': featured,
        'popular_cities': cities,
        'facilities': await this.db.fetchFacilitiesList(),
      });
    }

    if (path == '/kos' && method == 'GET') {
      final qp = options.queryParameters;
      final page = _queryInt(options, 'page', 1);
      final perPage = _queryInt(options, 'per_page', 10);
      final keyword = (qp['keyword'] as String? ?? '').trim().toLowerCase();
      final type = (qp['type'] as String? ?? '').trim().toLowerCase();
      final city = (qp['city'] as String? ?? '').trim().toLowerCase();
      final minPrice = double.tryParse('${qp['min_price'] ?? ''}');
      final maxPrice = double.tryParse('${qp['max_price'] ?? ''}');
      final sort = (qp['sort'] as String? ?? 'newest').trim();
      final rawFacs = qp['facilities[]'] ?? qp['facilities'];
      final facilityFilter = <int>[];
      if (rawFacs is List) {
        for (final f in rawFacs) {
          final parsed = int.tryParse('$f');
          if (parsed != null) facilityFilter.add(parsed);
        }
      } else if (rawFacs != null) {
        final parsed = int.tryParse('$rawFacs');
        if (parsed != null) facilityFilter.add(parsed);
      }

      final allRows = await db.query('kos', where: "status = 'active'");
      final built = <Map<String, dynamic>>[];
      for (final row in allRows) {
        final summary = await this.db.buildKosSummaryJson(
          db,
          row,
          currentUserId: userId,
        );
        final titleStr = (summary['title'] as String).toLowerCase();
        final cityStr = (summary['city'] as String).toLowerCase();
        final addrStr = ((summary['address'] as String?) ?? '').toLowerCase();
        if (keyword.isNotEmpty &&
            !titleStr.contains(keyword) &&
            !cityStr.contains(keyword) &&
            !addrStr.contains(keyword)) {
          continue;
        }
        if (type.isNotEmpty &&
            (summary['type'] as String).toLowerCase() != type) {
          continue;
        }
        if (city.isNotEmpty &&
            !(summary['city'] as String).toLowerCase().contains(city)) {
          continue;
        }
        final price = (summary['price'] as num).toDouble();
        if (minPrice != null && price < minPrice) continue;
        if (maxPrice != null && price > maxPrice) continue;
        if (facilityFilter.isNotEmpty) {
          final ownedIds = (summary['facilities'] as List<dynamic>)
              .map((e) => (e as Map<String, dynamic>)['id'] as int)
              .toSet();
          if (!facilityFilter.every(ownedIds.contains)) continue;
        }
        built.add(summary);
      }

      switch (sort) {
        case 'price_asc':
          built.sort(
            (a, b) => (a['price'] as num).compareTo(b['price'] as num),
          );
        case 'price_desc':
          built.sort(
            (a, b) => (b['price'] as num).compareTo(a['price'] as num),
          );
        case 'rating_desc':
          built.sort(
            (a, b) => (b['rating'] as num).compareTo(a['rating'] as num),
          );
        default:
          built.sort((a, b) => (b['id'] as int).compareTo(a['id'] as int));
      }

      final paged = _paginate(built, page, perPage);
      final meta = await this.db.buildPaginationMeta(
        page: page,
        perPage: perPage,
        total: built.length,
      );
      return _ok(options, paged, extra: {'meta': meta});
    }

    final reviewMatch = RegExp(r'^/kos/([^/]+)/reviews$').firstMatch(path);
    if (reviewMatch != null) {
      final slug = reviewMatch.group(1)!;
      final kosRows = await db.query(
        'kos',
        where: 'slug = ?',
        whereArgs: [slug],
        limit: 1,
      );
      if (kosRows.isEmpty) {
        throw const _HttpDemoError(404, 'Properti kos tidak ditemukan.');
      }
      final kosId = kosRows.first['id'] as int;

      if (method == 'GET') {
        final page = _queryInt(options, 'page', 1);
        final perPage = _queryInt(options, 'per_page', 10);
        final rating = int.tryParse('${options.queryParameters['rating'] ?? ''}');
        final rows = await db.query(
          'reviews',
          where: rating != null ? 'kos_id = ? AND rating = ?' : 'kos_id = ?',
          whereArgs: rating != null ? [kosId, rating] : [kosId],
          orderBy: 'id DESC',
        );
        final paged = _paginate(rows, page, perPage);
        final meta = await this.db.buildPaginationMeta(
          page: page,
          perPage: perPage,
          total: rows.length,
        );
        return _ok(
          options,
          paged.map(this.db.buildReviewJson).toList(),
          extra: {'meta': meta},
        );
      }

      if (method == 'POST') {
        final u = _requireUser(user);
        final body = await _readBody(options.data);
        final rating = (body['rating'] as num?)?.toInt() ?? 5;
        final comment = (body['comment'] as String? ?? '').trim();
        if (comment.isEmpty) {
          throw const _HttpDemoError(422, 'Komentar ulasan tidak boleh kosong.');
        }
        final now = DateTime.now().toIso8601String();
        final id = await db.insert('reviews', {
          'kos_id': kosId,
          'user_id': u['id'],
          'reviewer_name': u['name'],
          'is_verified_tenant': 1,
          'rating': rating.clamp(1, 5),
          'comment': comment,
          'reply': null,
          'user_avatar_url': u['avatar_url'],
          'created_at': now,
        });
        final created = (await db.query(
          'reviews',
          where: 'id = ?',
          whereArgs: [id],
          limit: 1,
        )).first;
        return _ok(options, this.db.buildReviewJson(created), statusCode: 201);
      }
    }

    final detailMatch = RegExp(r'^/kos/([^/]+)$').firstMatch(path);
    if (detailMatch != null && method == 'GET') {
      final detail = await this.db.buildKosDetailJson(
        detailMatch.group(1)!,
        currentUserId: userId,
      );
      if (detail == null) {
        throw const _HttpDemoError(404, 'Properti kos tidak ditemukan.');
      }
      return _ok(options, detail);
    }

    if (path == '/favorites' && method == 'GET') {
      final u = _requireUser(user);
      final page = _queryInt(options, 'page', 1);
      final perPage = _queryInt(options, 'per_page', 10);
      final favRows = await db.rawQuery(
        '''
        SELECT k.* FROM kos k
        INNER JOIN favorites f ON f.kos_id = k.id
        WHERE f.user_id = ?
        ORDER BY f.created_at DESC
        ''',
        [u['id']],
      );
      final paged = _paginate(favRows, page, perPage);
      final built = <Map<String, dynamic>>[];
      for (final row in paged) {
        built.add(
          await this.db.buildKosSummaryJson(
            db,
            row,
            currentUserId: u['id'] as int,
          ),
        );
      }
      final meta = await this.db.buildPaginationMeta(
        page: page,
        perPage: perPage,
        total: favRows.length,
      );
      return _ok(options, built, extra: {'meta': meta});
    }

    if (path == '/favorites/toggle' && method == 'POST') {
      final u = _requireUser(user);
      final uid = u['id'] as int;
      final body = await _readBody(options.data);
      final slug = (body['kos_slug'] as String? ?? '').trim();
      final kosRows = await db.query(
        'kos',
        where: 'slug = ?',
        whereArgs: [slug],
        limit: 1,
      );
      if (kosRows.isEmpty) {
        throw const _HttpDemoError(404, 'Properti kos tidak ditemukan.');
      }
      final kosId = kosRows.first['id'] as int;
      final existing = await db.query(
        'favorites',
        where: 'user_id = ? AND kos_id = ?',
        whereArgs: [uid, kosId],
        limit: 1,
      );
      late final bool isFavorite;
      if (existing.isNotEmpty) {
        await db.delete(
          'favorites',
          where: 'user_id = ? AND kos_id = ?',
          whereArgs: [uid, kosId],
        );
        isFavorite = false;
      } else {
        await db.insert('favorites', {
          'user_id': uid,
          'kos_id': kosId,
          'created_at': DateTime.now().toIso8601String(),
        });
        isFavorite = true;
      }
      final count = Sqflite.firstIntValue(
            await db.rawQuery(
              'SELECT COUNT(*) FROM favorites WHERE kos_id = ?',
              [kosId],
            ),
          ) ??
          0;
      return _ok(options, {
        'is_favorite': isFavorite,
        'favorites_count': count,
      });
    }

    throw const _HttpDemoError(404, 'Endpoint penemuan kos tidak ditemukan.');
  }

  // ---- CUSTOMER TRANSACTIONS ----

  Future<Response<dynamic>> _handleTransactions(
    RequestOptions options,
    String method,
    String path,
    Map<String, dynamic>? user,
  ) async {
    final db = await this.db.database;
    final u = _requireUser(user);
    final userId = u['id'] as int;

    // Bookings list & create
    if (path == '/bookings' && method == 'GET') {
      final status = (options.queryParameters['status'] as String? ?? '').trim();
      final page = _queryInt(options, 'page', 1);
      final perPage = _queryInt(options, 'per_page', 10);
      final rows = await db.query(
        'bookings',
        where: status.isNotEmpty ? 'customer_id = ? AND status = ?' : 'customer_id = ?',
        whereArgs: status.isNotEmpty ? [userId, status] : [userId],
        orderBy: 'id DESC',
      );
      final paged = _paginate(rows, page, perPage);
      final items = <Map<String, dynamic>>[];
      for (final r in paged) {
        final b = await this.db.buildBookingJson(db, r);
        if (b != null) items.add(b);
      }
      final meta = await this.db.buildPaginationMeta(
        page: page,
        perPage: perPage,
        total: rows.length,
      );
      return _ok(options, items, extra: {'meta': meta});
    }

    if (path == '/bookings' && method == 'POST') {
      final body = await _readBody(options.data);
      final slug = (body['kos_slug'] as String? ?? '').trim();
      final kosRows = await db.query(
        'kos',
        where: 'slug = ?',
        whereArgs: [slug],
        limit: 1,
      );
      if (kosRows.isEmpty) {
        throw const _HttpDemoError(404, 'Properti kos tidak ditemukan.');
      }
      final kos = kosRows.first;
      final kosId = kos['id'] as int;
      final roomId = (body['room_id'] as num?)?.toInt();

      var effectivePrice = (kos['price'] as num).toDouble();
      if (roomId != null) {
        final roomRows = await db.query(
          'rooms',
          where: 'id = ? AND kos_id = ?',
          whereArgs: [roomId, kosId],
          limit: 1,
        );
        if (roomRows.isNotEmpty) {
          final override = (roomRows.first['price_override'] as num?)?.toDouble();
          if (override != null) effectivePrice = override;
        }
      }

      final duration = math.max(
        1,
        (body['duration_months'] as num?)?.toInt() ?? 1,
      );
      final startDateStr = (body['start_date'] as String? ?? '').trim();
      final startDate = DateTime.tryParse(startDateStr) ?? DateTime.now();
      final endDate = DateTime(
        startDate.year,
        startDate.month + duration,
        startDate.day,
      );
      final endDateStr =
          '${endDate.year.toString().padLeft(4, '0')}-'
          '${endDate.month.toString().padLeft(2, '0')}-'
          '${endDate.day.toString().padLeft(2, '0')}';

      final subtotal = effectivePrice * duration;
      const adminFee = 25000.0;
      final totalAmount = subtotal + adminFee;
      final nowIso = DateTime.now().toIso8601String();

      final maxIdRow = (await db.rawQuery(
        'SELECT COALESCE(MAX(id), 0) AS m FROM bookings',
      )).first;
      final nextSeq = ((maxIdRow['m'] as num?)?.toInt() ?? 0) + 1;
      final code = 'BOOK-${DateTime.now().year}-${nextSeq.toString().padLeft(4, '0')}';

      final id = await db.insert('bookings', {
        'booking_code': code,
        'kos_id': kosId,
        'room_id': roomId,
        'customer_id': userId,
        'tenant_name': (body['tenant_name'] as String? ?? u['name'] as String)
            .trim(),
        'tenant_phone':
            (body['tenant_phone'] as String? ?? u['phone'] as String? ?? '')
                .trim(),
        'tenant_email':
            (body['tenant_email'] as String? ?? u['email'] as String).trim(),
        'start_date': startDateStr.isEmpty ? nowIso.substring(0, 10) : startDateStr,
        'end_date': endDateStr,
        'duration_months': duration,
        'kos_price': effectivePrice,
        'subtotal': subtotal,
        'admin_fee': adminFee,
        'total_amount': totalAmount,
        'notes': body['notes'],
        'status': 'pending',
        'rejection_reason': null,
        'created_at': nowIso,
      });

      await _addNotification(
        db,
        userId: kos['owner_id'] as int,
        title: 'Pengajuan Sewa Baru ($code)',
        message:
            '${u['name']} mengajukan sewa kamar di ${kos['title']} selama $duration bulan.',
        category: 'booking',
        actionType: 'owner_booking',
        actionId: code,
        actionUrl: '/owner/bookings/$code',
      );

      final created = (await db.query(
        'bookings',
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      )).first;
      return _ok(options, await this.db.buildBookingJson(db, created), statusCode: 201);
    }

    // Booking detail, cancel, pay, nota-pdf, contract
    final bookingDetailMatch = RegExp(r'^/bookings/([^/]+)$').firstMatch(path);
    if (bookingDetailMatch != null && method == 'GET') {
      final code = bookingDetailMatch.group(1)!;
      final rows = await db.query(
        'bookings',
        where: 'booking_code = ?',
        whereArgs: [code],
        limit: 1,
      );
      if (rows.isEmpty) {
        throw const _HttpDemoError(404, 'Booking tidak ditemukan.');
      }
      return _ok(options, await this.db.buildBookingJson(db, rows.first));
    }

    final cancelMatch = RegExp(r'^/bookings/([^/]+)/cancel$').firstMatch(path);
    if (cancelMatch != null && method == 'PATCH') {
      final code = cancelMatch.group(1)!;
      final rows = await db.query(
        'bookings',
        where: 'booking_code = ? AND customer_id = ?',
        whereArgs: [code, userId],
        limit: 1,
      );
      if (rows.isEmpty) {
        throw const _HttpDemoError(404, 'Booking tidak ditemukan.');
      }
      final b = rows.first;
      await db.update(
        'bookings',
        {'status': 'cancelled'},
        where: 'id = ?',
        whereArgs: [b['id']],
      );
      await db.update(
        'invoices',
        {'status': 'cancelled'},
        where: "booking_id = ? AND status = 'unpaid'",
        whereArgs: [b['id']],
      );
      final updated = (await db.query(
        'bookings',
        where: 'id = ?',
        whereArgs: [b['id']],
        limit: 1,
      )).first;
      return _ok(options, await this.db.buildBookingJson(db, updated));
    }

    final payMatch = RegExp(r'^/bookings/([^/]+)/pay$').firstMatch(path);
    if (payMatch != null && method == 'POST') {
      final code = payMatch.group(1)!;
      final rows = await db.query(
        'bookings',
        where: 'booking_code = ?',
        whereArgs: [code],
        limit: 1,
      );
      if (rows.isEmpty) {
        throw const _HttpDemoError(404, 'Booking tidak ditemukan.');
      }
      final b = rows.first;
      final status = b['status'] as String;
      if (status != 'approved' && status != 'confirmed') {
        throw const _HttpDemoError(
          422,
          'Pembayaran hanya tersedia setelah booking disetujui pemilik kos.',
        );
      }
      final invRows = await db.query(
        'invoices',
        where: 'booking_id = ?',
        whereArgs: [b['id']],
        limit: 1,
      );
      final invoiceId = invRows.isNotEmpty
          ? invRows.first['id'] as int
          : await _ensureInvoiceForBooking(db, b);
      final amount = (b['total_amount'] as num).toDouble();
      final ts = DateTime.now().millisecondsSinceEpoch;
      final payCode = 'PAY-DEMO-${ts.toString().substring(ts.toString().length - 6)}';
      final orderId = 'ORD-DEMO-$code';

      await db.insert('payments', {
        'payment_code': payCode,
        'invoice_id': invoiceId,
        'order_id': orderId,
        'payment_method': 'demo_virtual_account',
        'payment_channel': 'Simulasi Offline TEMPATIN',
        'transaction_id': 'TRX-SIM-$ts',
        'amount': amount,
        'status': 'pending',
        'paid_at': null,
        'created_at': DateTime.now().toIso8601String(),
      });

      return _ok(options, {
        'payment_code': payCode,
        'order_id': orderId,
        'amount': amount,
        'snap_token': 'OFFLINE-DEMO-SNAP',
        'snap_redirect_url': '',
        'is_production': false,
        'client_key': 'OFFLINE-DEMO',
      });
    }

    final syncMatch = RegExp(r'^/payments/([^/]+)/sync$').firstMatch(path);
    if (syncMatch != null && method == 'GET') {
      final payCode = syncMatch.group(1)!;
      final payRows = await db.query(
        'payments',
        where: 'payment_code = ?',
        whereArgs: [payCode],
        limit: 1,
      );
      if (payRows.isEmpty) {
        throw const _HttpDemoError(404, 'Transaksi pembayaran tidak ditemukan.');
      }
      final pay = payRows.first;
      final nowIso = DateTime.now().toIso8601String();
      await db.update(
        'payments',
        {'status': 'success', 'paid_at': nowIso},
        where: 'id = ?',
        whereArgs: [pay['id']],
      );
      await db.update(
        'invoices',
        {'status': 'paid', 'paid_at': nowIso},
        where: 'id = ?',
        whereArgs: [pay['invoice_id']],
      );
      final invRow = (await db.query(
        'invoices',
        where: 'id = ?',
        whereArgs: [pay['invoice_id']],
        limit: 1,
      )).first;
      final bookingId = invRow['booking_id'] as int;
      final bookingRow = (await db.query(
        'bookings',
        where: 'id = ?',
        whereArgs: [bookingId],
        limit: 1,
      )).first;
      await db.update(
        'bookings',
        {'status': 'confirmed'},
        where: 'id = ?',
        whereArgs: [bookingId],
      );
      final roomId = bookingRow['room_id'] as int?;
      if (roomId != null) {
        await db.update(
          'rooms',
          {'status': 'occupied'},
          where: 'id = ?',
          whereArgs: [roomId],
        );
      }
      await _ensureContractForBooking(db, bookingRow);

      return _ok(
        options,
        {
          'payment_status': 'success',
          'invoice_status': 'paid',
          'booking_status': 'confirmed',
          'paid_at': nowIso,
        },
        message: 'Pembayaran simulasi offline berhasil dikonfirmasi.',
      );
    }

    final notaMatch = RegExp(r'^/bookings/([^/]+)/nota-pdf$').firstMatch(path);
    if (notaMatch != null && method == 'GET') {
      final code = notaMatch.group(1)!;
      final rows = await db.query(
        'bookings',
        where: 'booking_code = ?',
        whereArgs: [code],
        limit: 1,
      );
      if (rows.isEmpty) {
        throw const _HttpDemoError(404, 'Booking tidak ditemukan.');
      }
      final bookingJson = (await this.db.buildBookingJson(db, rows.first))!;
      final bytes = await OfflineDemoPdfBuilder.buildBookingNotaPdf(bookingJson);
      return _pdfResponse(options, bytes);
    }

    final contractMatch = RegExp(r'^/bookings/([^/]+)/contract$').firstMatch(path);
    if (contractMatch != null && method == 'GET') {
      final code = contractMatch.group(1)!;
      final rows = await db.query(
        'bookings',
        where: 'booking_code = ?',
        whereArgs: [code],
        limit: 1,
      );
      if (rows.isEmpty) {
        throw const _HttpDemoError(404, 'Booking tidak ditemukan.');
      }
      final b = rows.first;
      await _ensureContractForBooking(db, b);
      final cRow = (await db.query(
        'rental_contracts',
        where: 'booking_id = ?',
        whereArgs: [b['id']],
        limit: 1,
      )).first;
      return _ok(options, this.db.buildContractJson(cRow, code));
    }

    final signMatch = RegExp(r'^/contracts/([^/]+)/sign$').firstMatch(path);
    if (signMatch != null && method == 'POST') {
      final number = signMatch.group(1)!;
      final rows = await db.query(
        'rental_contracts',
        where: 'contract_number = ?',
        whereArgs: [number],
        limit: 1,
      );
      if (rows.isEmpty) {
        throw const _HttpDemoError(404, 'Kontrak tidak ditemukan.');
      }
      final c = rows.first;
      final nowIso = DateTime.now().toIso8601String();
      await db.update(
        'rental_contracts',
        {
          'status': 'signed',
          'is_signed': 1,
          'signed_at': nowIso,
          'signer_ip': '127.0.0.1 (Offline Demo)',
        },
        where: 'id = ?',
        whereArgs: [c['id']],
      );
      final bRow = (await db.query(
        'bookings',
        where: 'id = ?',
        whereArgs: [c['booking_id']],
        limit: 1,
      )).first;
      final updated = (await db.query(
        'rental_contracts',
        where: 'id = ?',
        whereArgs: [c['id']],
        limit: 1,
      )).first;
      return _ok(
        options,
        this.db.buildContractJson(updated, bRow['booking_code'] as String?),
      );
    }

    final contractPdfMatch = RegExp(r'^/contracts/([^/]+)/pdf$').firstMatch(path);
    if (contractPdfMatch != null && method == 'GET') {
      final number = contractPdfMatch.group(1)!;
      final rows = await db.query(
        'rental_contracts',
        where: 'contract_number = ?',
        whereArgs: [number],
        limit: 1,
      );
      if (rows.isEmpty) {
        throw const _HttpDemoError(404, 'Kontrak tidak ditemukan.');
      }
      final c = rows.first;
      final bRow = (await db.query(
        'bookings',
        where: 'id = ?',
        whereArgs: [c['booking_id']],
        limit: 1,
      )).first;
      final bookingJson = (await this.db.buildBookingJson(db, bRow))!;
      final contractJson = this.db.buildContractJson(
        c,
        bRow['booking_code'] as String?,
      );
      final bytes = await OfflineDemoPdfBuilder.buildContractPdf(
        contractJson,
        bookingJson,
      );
      return _pdfResponse(options, bytes);
    }

    // Invoices
    if (path == '/invoices' && method == 'GET') {
      final page = _queryInt(options, 'page', 1);
      final perPage = _queryInt(options, 'per_page', 10);
      final rows = await db.rawQuery(
        '''
        SELECT i.*, b.booking_code, k.title AS kos_title, k.slug AS kos_slug
        FROM invoices i
        INNER JOIN bookings b ON b.id = i.booking_id
        INNER JOIN kos k ON k.id = b.kos_id
        WHERE b.customer_id = ?
        ORDER BY i.id DESC
        ''',
        [userId],
      );
      final paged = _paginate(rows, page, perPage);
      final items = <Map<String, dynamic>>[];
      for (final row in paged) {
        items.add(
          await this.db.buildInvoiceJson(
            db,
            row,
            bookingCode: row['booking_code'] as String?,
            kosTitle: row['kos_title'] as String?,
            kosSlug: row['kos_slug'] as String?,
          ),
        );
      }
      final meta = await this.db.buildPaginationMeta(
        page: page,
        perPage: perPage,
        total: rows.length,
      );
      return _ok(options, items, extra: {'meta': meta});
    }

    final invoiceMatch = RegExp(r'^/invoices/([^/]+)$').firstMatch(path);
    if (invoiceMatch != null && method == 'GET') {
      final rows = await db.query(
        'invoices',
        where: 'invoice_number = ?',
        whereArgs: [invoiceMatch.group(1)!],
        limit: 1,
      );
      if (rows.isEmpty) {
        throw const _HttpDemoError(404, 'Invoice tidak ditemukan.');
      }
      return _ok(options, await this.db.buildInvoiceJson(db, rows.first));
    }

    // Surveys
    if (path == '/surveys' && method == 'GET') {
      final status = (options.queryParameters['status'] as String? ?? '').trim();
      final page = _queryInt(options, 'page', 1);
      final perPage = _queryInt(options, 'per_page', 10);
      final rows = await db.query(
        'surveys',
        where: status.isNotEmpty ? 'customer_id = ? AND status = ?' : 'customer_id = ?',
        whereArgs: status.isNotEmpty ? [userId, status] : [userId],
        orderBy: 'id DESC',
      );
      final paged = _paginate(rows, page, perPage);
      final items = <Map<String, dynamic>>[];
      for (final r in paged) {
        items.add(await this.db.buildSurveyJson(db, r));
      }
      final meta = await this.db.buildPaginationMeta(
        page: page,
        perPage: perPage,
        total: rows.length,
      );
      return _ok(options, items, extra: {'meta': meta});
    }

    final schedMatch = RegExp(r'^/kos/([^/]+)/surveys$').firstMatch(path);
    if (schedMatch != null && method == 'POST') {
      final slug = schedMatch.group(1)!;
      final kosRows = await db.query(
        'kos',
        where: 'slug = ?',
        whereArgs: [slug],
        limit: 1,
      );
      if (kosRows.isEmpty) {
        throw const _HttpDemoError(404, 'Properti kos tidak ditemukan.');
      }
      final kos = kosRows.first;
      final body = await _readBody(options.data);
      final id = await db.insert('surveys', {
        'kos_id': kos['id'],
        'customer_id': userId,
        'survey_date': body['survey_date'] as String? ?? '',
        'survey_time': body['survey_time'] as String? ?? '',
        'notes': body['notes'],
        'status': 'pending',
        'rejection_reason': null,
        'created_at': DateTime.now().toIso8601String(),
      });
      final created = (await db.query(
        'surveys',
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      )).first;
      return _ok(options, await this.db.buildSurveyJson(db, created), statusCode: 201);
    }

    final cancelSurveyMatch = RegExp(r'^/surveys/(\d+)/cancel$').firstMatch(path);
    if (cancelSurveyMatch != null && method == 'PATCH') {
      final id = int.parse(cancelSurveyMatch.group(1)!);
      await db.update(
        'surveys',
        {'status': 'cancelled'},
        where: 'id = ? AND customer_id = ?',
        whereArgs: [id, userId],
      );
      final updated = (await db.query(
        'surveys',
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      )).first;
      return _ok(options, await this.db.buildSurveyJson(db, updated));
    }

    // Maintenance reports
    if (path == '/maintenance-reports' && method == 'GET') {
      final status = (options.queryParameters['status'] as String? ?? '').trim();
      final page = _queryInt(options, 'page', 1);
      final perPage = _queryInt(options, 'per_page', 10);
      final rows = await db.query(
        'maintenance_reports',
        where: status.isNotEmpty ? 'customer_id = ? AND status = ?' : 'customer_id = ?',
        whereArgs: status.isNotEmpty ? [userId, status] : [userId],
        orderBy: 'id DESC',
      );
      final paged = _paginate(rows, page, perPage);
      final items = <Map<String, dynamic>>[];
      for (final r in paged) {
        items.add(await this.db.buildMaintenanceJson(db, r));
      }
      final meta = await this.db.buildPaginationMeta(
        page: page,
        perPage: perPage,
        total: rows.length,
      );
      return _ok(options, items, extra: {'meta': meta});
    }

    if (path == '/maintenance-reports' && method == 'POST') {
      final body = await _readBody(options.data);
      final bookingId = int.tryParse('${body['booking_id'] ?? ''}') ?? 0;
      final title = (body['title'] as String? ?? '').trim();
      final description = (body['description'] as String? ?? '').trim();
      final photoFile = body['_file_photo'] as _SavedDemoFile?;
      if (bookingId <= 0 || title.isEmpty || description.isEmpty) {
        throw const _HttpDemoError(
          422,
          'Judul dan deskripsi laporan kerusakan wajib diisi.',
        );
      }
      final id = await db.insert('maintenance_reports', {
        'booking_id': bookingId,
        'customer_id': userId,
        'title': title,
        'description': description,
        'photo_url': photoFile?.localPath,
        'status': 'open',
        'owner_notes': null,
        'created_at': DateTime.now().toIso8601String(),
      });
      final created = (await db.query(
        'maintenance_reports',
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      )).first;
      return _ok(
        options,
        await this.db.buildMaintenanceJson(db, created),
        statusCode: 201,
      );
    }

    throw _HttpDemoError(404, 'Endpoint tidak ditemukan ($method $path).');
  }

  // ---- CHAT ----

  Future<Response<dynamic>> _handleChat(
    RequestOptions options,
    String method,
    String path,
    Map<String, dynamic>? user,
  ) async {
    final db = await this.db.database;
    final u = _requireUser(user);
    final userId = u['id'] as int;

    if (path == '/conversations' && method == 'GET') {
      final page = _queryInt(options, 'page', 1);
      final perPage = _queryInt(options, 'per_page', 25);
      final rows = await db.query(
        'conversations',
        where: 'customer_id = ? OR owner_id = ?',
        whereArgs: [userId, userId],
        orderBy: 'updated_at DESC',
      );
      final paged = _paginate(rows, page, perPage);
      final items = <Map<String, dynamic>>[];
      for (final c in paged) {
        items.add(
          await this.db.buildConversationJson(db, c, viewerUserId: userId),
        );
      }
      final meta = await this.db.buildPaginationMeta(
        page: page,
        perPage: perPage,
        total: rows.length,
      );
      return _ok(options, items, extra: {'meta': meta});
    }

    final startMatch = RegExp(r'^/kos/([^/]+)/conversations$').firstMatch(path);
    if (startMatch != null && method == 'POST') {
      final slug = startMatch.group(1)!;
      final kosRows = await db.query(
        'kos',
        where: 'slug = ?',
        whereArgs: [slug],
        limit: 1,
      );
      if (kosRows.isEmpty) {
        throw const _HttpDemoError(404, 'Properti kos tidak ditemukan.');
      }
      final kos = kosRows.first;
      final kosId = kos['id'] as int;
      final ownerId = kos['owner_id'] as int;
      final body = await _readBody(options.data);
      final initialMsg = (body['message'] as String? ?? '').trim();
      final nowIso = DateTime.now().toIso8601String();

      var existing = await db.query(
        'conversations',
        where: 'kos_id = ? AND customer_id = ?',
        whereArgs: [kosId, userId],
        limit: 1,
      );
      late int convId;
      if (existing.isEmpty) {
        convId = await db.insert('conversations', {
          'kos_id': kosId,
          'customer_id': userId,
          'owner_id': ownerId,
          'updated_at': nowIso,
        });
      } else {
        convId = existing.first['id'] as int;
        await db.update(
          'conversations',
          {'updated_at': nowIso},
          where: 'id = ?',
          whereArgs: [convId],
        );
      }

      if (initialMsg.isNotEmpty) {
        await db.insert('messages', {
          'conversation_id': convId,
          'sender_id': userId,
          'message': initialMsg,
          'is_read': 0,
          'created_at': nowIso,
        });
      }

      final conv = (await db.query(
        'conversations',
        where: 'id = ?',
        whereArgs: [convId],
        limit: 1,
      )).first;
      return _ok(
        options,
        await this.db.buildConversationJson(db, conv, viewerUserId: userId),
      );
    }

    final msgMatch = RegExp(r'^/conversations/(\d+)/messages$').firstMatch(path);
    if (msgMatch != null) {
      final convId = int.parse(msgMatch.group(1)!);
      if (method == 'GET') {
        final afterId = int.tryParse(
          '${options.queryParameters['after_id'] ?? ''}',
        );
        // Mark counterpart messages read when viewer loads chat
        await db.update(
          'messages',
          {'is_read': 1},
          where: 'conversation_id = ? AND sender_id != ? AND is_read = 0',
          whereArgs: [convId, userId],
        );
        final rows = await db.query(
          'messages',
          where: afterId != null
              ? 'conversation_id = ? AND id > ?'
              : 'conversation_id = ?',
          whereArgs: afterId != null ? [convId, afterId] : [convId],
          orderBy: 'id ASC',
        );
        return _ok(options, rows.map(this.db.buildMessageJson).toList());
      }

      if (method == 'POST') {
        final body = await _readBody(options.data);
        final text = (body['message'] as String? ?? '').trim();
        if (text.isEmpty) {
          throw const _HttpDemoError(422, 'Pesan tidak boleh kosong.');
        }
        final nowIso = DateTime.now().toIso8601String();
        final id = await db.insert('messages', {
          'conversation_id': convId,
          'sender_id': userId,
          'message': text,
          'is_read': 0,
          'created_at': nowIso,
        });
        await db.update(
          'conversations',
          {'updated_at': nowIso},
          where: 'id = ?',
          whereArgs: [convId],
        );
        final created = (await db.query(
          'messages',
          where: 'id = ?',
          whereArgs: [id],
          limit: 1,
        )).first;
        return _ok(options, this.db.buildMessageJson(created), statusCode: 201);
      }
    }

    throw const _HttpDemoError(404, 'Endpoint percakapan tidak ditemukan.');
  }

  // ---- OWNER PORTAL ----

  Future<Response<dynamic>> _handleOwner(
    RequestOptions options,
    String method,
    String path,
    Map<String, dynamic>? user,
  ) async {
    final db = await this.db.database;
    final owner = _requireOwner(user);
    final ownerId = owner['id'] as int;

    if (path == '/owner/dashboard' && method == 'GET') {
      final allKos = await db.query(
        'kos',
        where: 'owner_id = ?',
        whereArgs: [ownerId],
        orderBy: 'id DESC',
      );
      final activeCount = allKos.where((k) => k['status'] == 'active').length;
      final inactiveCount = allKos.length - activeCount;
      final avgPrice = allKos.isEmpty
          ? 0.0
          : allKos
                    .map((k) => (k['price'] as num).toDouble())
                    .reduce((a, b) => a + b) /
                allKos.length;

      final pendingBookings = Sqflite.firstIntValue(
            await db.rawQuery(
              '''
              SELECT COUNT(*) FROM bookings b
              INNER JOIN kos k ON k.id = b.kos_id
              WHERE k.owner_id = ? AND b.status = 'pending'
              ''',
              [ownerId],
            ),
          ) ??
          0;
      final pendingSurveys = Sqflite.firstIntValue(
            await db.rawQuery(
              '''
              SELECT COUNT(*) FROM surveys s
              INNER JOIN kos k ON k.id = s.kos_id
              WHERE k.owner_id = ? AND s.status = 'pending'
              ''',
              [ownerId],
            ),
          ) ??
          0;
      final openMaintenance = Sqflite.firstIntValue(
            await db.rawQuery(
              '''
              SELECT COUNT(*) FROM maintenance_reports m
              INNER JOIN bookings b ON b.id = m.booking_id
              INNER JOIN kos k ON k.id = b.kos_id
              WHERE k.owner_id = ? AND m.status IN ('open', 'in_progress')
              ''',
              [ownerId],
            ),
          ) ??
          0;

      final recentKos = <Map<String, dynamic>>[];
      for (final row in allKos.take(4)) {
        recentKos.add(await this.db.buildKosSummaryJson(db, row));
      }

      return _ok(options, {
        'total_kos': allKos.length,
        'active_kos': activeCount,
        'inactive_kos': inactiveCount,
        'avg_price': avgPrice.roundToDouble(),
        'pending_bookings_count': pendingBookings,
        'pending_surveys_count': pendingSurveys,
        'open_maintenance_count': openMaintenance,
        'recent_kos': recentKos,
      });
    }

    if (path == '/owner/kos' && method == 'GET') {
      final page = _queryInt(options, 'page', 1);
      final perPage = _queryInt(options, 'per_page', 15);
      final status = (options.queryParameters['status'] as String? ?? '').trim();
      final search = (options.queryParameters['search'] as String? ?? '')
          .trim()
          .toLowerCase();

      final rows = await db.query(
        'kos',
        where: status.isNotEmpty ? 'owner_id = ? AND status = ?' : 'owner_id = ?',
        whereArgs: status.isNotEmpty ? [ownerId, status] : [ownerId],
        orderBy: 'id DESC',
      );
      final filtered = rows.where((r) {
        if (search.isEmpty) return true;
        final t = (r['title'] as String).toLowerCase();
        final c = (r['city'] as String).toLowerCase();
        return t.contains(search) || c.contains(search);
      }).toList();

      final paged = _paginate(filtered, page, perPage);
      final items = <Map<String, dynamic>>[];
      for (final r in paged) {
        items.add(await this.db.buildKosSummaryJson(db, r));
      }
      final meta = await this.db.buildPaginationMeta(
        page: page,
        perPage: perPage,
        total: filtered.length,
      );
      return _ok(options, items, extra: {'meta': meta});
    }

    // Create new kos
    if (path == '/owner/kos' && method == 'POST') {
      final body = await _readBody(options.data);
      return _saveOwnerKos(options, db, ownerId, null, body);
    }

    // Rooms CRUD
    final roomsMatch = RegExp(r'^/owner/kos/([^/]+)/rooms$').firstMatch(path);
    if (roomsMatch != null) {
      final slug = roomsMatch.group(1)!;
      final kosRows = await db.query(
        'kos',
        where: 'slug = ? AND owner_id = ?',
        whereArgs: [slug, ownerId],
        limit: 1,
      );
      if (kosRows.isEmpty) {
        throw const _HttpDemoError(404, 'Properti kos tidak ditemukan.');
      }
      final kos = kosRows.first;
      final kosId = kos['id'] as int;
      final basePrice = (kos['price'] as num).toDouble();

      if (method == 'GET') {
        final roomRows = await db.query(
          'rooms',
          where: 'kos_id = ?',
          whereArgs: [kosId],
          orderBy: 'id ASC',
        );
        return _ok(
          options,
          roomRows.map((r) => this.db.buildRoomJson(r, basePrice)).toList(),
        );
      }

      if (method == 'POST') {
        final body = await _readBody(options.data);
        final id = await db.insert('rooms', {
          'kos_id': kosId,
          'room_number': (body['room_number'] as String? ?? 'A-01').trim(),
          'floor': body['floor'],
          'room_type': body['room_type'],
          'price_override': (body['price_override'] as num?)?.toDouble(),
          'status': body['status'] as String? ?? 'available',
          'notes': body['notes'],
        });
        final created = (await db.query(
          'rooms',
          where: 'id = ?',
          whereArgs: [id],
          limit: 1,
        )).first;
        return _ok(
          options,
          this.db.buildRoomJson(created, basePrice),
          statusCode: 201,
        );
      }
    }

    final roomItemMatch = RegExp(
      r'^/owner/kos/([^/]+)/rooms/(\d+)$',
    ).firstMatch(path);
    if (roomItemMatch != null) {
      final slug = roomItemMatch.group(1)!;
      final roomId = int.parse(roomItemMatch.group(2)!);
      final kosRows = await db.query(
        'kos',
        where: 'slug = ? AND owner_id = ?',
        whereArgs: [slug, ownerId],
        limit: 1,
      );
      if (kosRows.isEmpty) {
        throw const _HttpDemoError(404, 'Properti kos tidak ditemukan.');
      }
      final kos = kosRows.first;
      final basePrice = (kos['price'] as num).toDouble();

      if (method == 'PUT') {
        final body = await _readBody(options.data);
        await db.update(
          'rooms',
          {
            'room_number': body['room_number'],
            'floor': body['floor'],
            'room_type': body['room_type'],
            'price_override': (body['price_override'] as num?)?.toDouble(),
            'status': body['status'],
            'notes': body['notes'],
          },
          where: 'id = ? AND kos_id = ?',
          whereArgs: [roomId, kos['id']],
        );
        final updated = (await db.query(
          'rooms',
          where: 'id = ?',
          whereArgs: [roomId],
          limit: 1,
        )).first;
        return _ok(options, this.db.buildRoomJson(updated, basePrice));
      }

      if (method == 'DELETE') {
        await db.delete(
          'rooms',
          where: 'id = ? AND kos_id = ?',
          whereArgs: [roomId, kos['id']],
        );
        return _ok(options, const <String, dynamic>{});
      }
    }

    // Owner single kos detail / update / delete
    final kosDetailMatch = RegExp(r'^/owner/kos/([^/]+)$').firstMatch(path);
    if (kosDetailMatch != null) {
      final slug = kosDetailMatch.group(1)!;
      if (method == 'GET') {
        final detail = await this.db.buildKosDetailJson(slug);
        if (detail == null) {
          throw const _HttpDemoError(404, 'Properti kos tidak ditemukan.');
        }
        return _ok(options, detail);
      }
      if (method == 'POST') {
        final body = await _readBody(options.data);
        return _saveOwnerKos(options, db, ownerId, slug, body);
      }
      if (method == 'DELETE') {
        await db.delete(
          'kos',
          where: 'slug = ? AND owner_id = ?',
          whereArgs: [slug, ownerId],
        );
        return _ok(options, const <String, dynamic>{});
      }
    }

    // Owner bookings
    if (path == '/owner/bookings' && method == 'GET') {
      final page = _queryInt(options, 'page', 1);
      final perPage = _queryInt(options, 'per_page', 15);
      final status = (options.queryParameters['status'] as String? ?? '').trim();
      final search = (options.queryParameters['search'] as String? ?? '')
          .trim()
          .toLowerCase();

      final allRows = await db.rawQuery(
        '''
        SELECT b.* FROM bookings b
        INNER JOIN kos k ON k.id = b.kos_id
        WHERE k.owner_id = ?
        ORDER BY b.id DESC
        ''',
        [ownerId],
      );

      final counts = {
        'all': allRows.length,
        'pending': allRows.where((r) => r['status'] == 'pending').length,
        'approved': allRows.where((r) => r['status'] == 'approved').length,
        'confirmed': allRows.where((r) => r['status'] == 'confirmed').length,
        'active': allRows.where((r) => r['status'] == 'active').length,
        'rejected': allRows.where((r) => r['status'] == 'rejected').length,
      };

      final filtered = allRows.where((r) {
        if (status.isNotEmpty && r['status'] != status) return false;
        if (search.isNotEmpty) {
          final code = (r['booking_code'] as String).toLowerCase();
          final tenant = (r['tenant_name'] as String).toLowerCase();
          return code.contains(search) || tenant.contains(search);
        }
        return true;
      }).toList();

      final paged = _paginate(filtered, page, perPage);
      final items = <Map<String, dynamic>>[];
      for (final r in paged) {
        final b = await this.db.buildBookingJson(db, r);
        if (b != null) items.add(b);
      }
      final meta = await this.db.buildPaginationMeta(
        page: page,
        perPage: perPage,
        total: filtered.length,
      );
      return _ok(
        options,
        items,
        extra: {'counts': counts, 'meta': meta},
      );
    }

    final ownerBookingMatch = RegExp(
      r'^/owner/bookings/([^/]+)$',
    ).firstMatch(path);
    if (ownerBookingMatch != null && method == 'GET') {
      final code = ownerBookingMatch.group(1)!;
      final rows = await db.query(
        'bookings',
        where: 'booking_code = ?',
        whereArgs: [code],
        limit: 1,
      );
      if (rows.isEmpty) {
        throw const _HttpDemoError(404, 'Booking tidak ditemukan.');
      }
      final b = rows.first;
      final kosRow = (await db.query(
        'kos',
        where: 'id = ?',
        whereArgs: [b['kos_id']],
        limit: 1,
      )).first;
      final basePrice = (kosRow['price'] as num).toDouble();
      final roomRows = await db.query(
        'rooms',
        where: "kos_id = ? AND status = 'available'",
        whereArgs: [b['kos_id']],
        orderBy: 'id ASC',
      );
      return _ok(options, {
        'booking': await this.db.buildBookingJson(db, b),
        'available_rooms': roomRows
            .map((r) => this.db.buildRoomJson(r, basePrice))
            .toList(),
      });
    }

    final bookingActionMatch = RegExp(
      r'^/owner/bookings/([^/]+)/(approve|reject|checkin|checkout)$',
    ).firstMatch(path);
    if (bookingActionMatch != null && method == 'POST') {
      final code = bookingActionMatch.group(1)!;
      final action = bookingActionMatch.group(2)!;
      final rows = await db.query(
        'bookings',
        where: 'booking_code = ?',
        whereArgs: [code],
        limit: 1,
      );
      if (rows.isEmpty) {
        throw const _HttpDemoError(404, 'Booking tidak ditemukan.');
      }
      final b = rows.first;
      final body = await _readBody(options.data);

      switch (action) {
        case 'approve':
          final roomId =
              (body['room_id'] as num?)?.toInt() ?? (b['room_id'] as int?);
          await db.update(
            'bookings',
            {'status': 'approved', 'room_id': roomId},
            where: 'id = ?',
            whereArgs: [b['id']],
          );
          final updatedForInv = (await db.query(
            'bookings',
            where: 'id = ?',
            whereArgs: [b['id']],
            limit: 1,
          )).first;
          await _ensureInvoiceForBooking(db, updatedForInv);
          await _addNotification(
            db,
            userId: b['customer_id'] as int,
            title: 'Booking Disetujui ($code)',
            message:
                'Pengajuan sewa Anda disetujui pemilik. Silakan lanjutkan ke pembayaran.',
            category: 'booking',
            actionType: 'booking',
            actionId: code,
            actionUrl: '/bookings/$code',
          );
        case 'reject':
          final reason =
              (body['rejection_reason'] as String? ?? 'Kamar tidak tersedia')
                  .trim();
          await db.update(
            'bookings',
            {'status': 'rejected', 'rejection_reason': reason},
            where: 'id = ?',
            whereArgs: [b['id']],
          );
        case 'checkin':
          await db.update(
            'bookings',
            {'status': 'active'},
            where: 'id = ?',
            whereArgs: [b['id']],
          );
          final roomId = b['room_id'] as int?;
          if (roomId != null) {
            await db.update(
              'rooms',
              {'status': 'occupied'},
              where: 'id = ?',
              whereArgs: [roomId],
            );
          }
        case 'checkout':
          await db.update(
            'bookings',
            {'status': 'completed'},
            where: 'id = ?',
            whereArgs: [b['id']],
          );
          final roomId = b['room_id'] as int?;
          if (roomId != null) {
            await db.update(
              'rooms',
              {'status': 'available'},
              where: 'id = ?',
              whereArgs: [roomId],
            );
          }
      }

      final updated = (await db.query(
        'bookings',
        where: 'id = ?',
        whereArgs: [b['id']],
        limit: 1,
      )).first;
      return _ok(options, await this.db.buildBookingJson(db, updated));
    }

    // Owner tenants
    if (path == '/owner/tenants' && method == 'GET') {
      final status = (options.queryParameters['status'] as String? ?? 'active')
          .trim();
      final page = _queryInt(options, 'page', 1);
      final perPage = _queryInt(options, 'per_page', 15);
      final rows = await db.rawQuery(
        '''
        SELECT b.* FROM bookings b
        INNER JOIN kos k ON k.id = b.kos_id
        WHERE k.owner_id = ? AND b.status = ?
        ORDER BY b.id DESC
        ''',
        [ownerId, status],
      );
      final paged = _paginate(rows, page, perPage);
      final items = <Map<String, dynamic>>[];
      for (final r in paged) {
        final b = await this.db.buildBookingJson(db, r);
        if (b != null) items.add(b);
      }
      final meta = await this.db.buildPaginationMeta(
        page: page,
        perPage: perPage,
        total: rows.length,
      );
      return _ok(options, items, extra: {'meta': meta});
    }

    // Owner surveys
    if (path == '/owner/surveys' && method == 'GET') {
      final status = (options.queryParameters['status'] as String? ?? '').trim();
      final page = _queryInt(options, 'page', 1);
      final perPage = _queryInt(options, 'per_page', 20);
      final rows = await db.rawQuery(
        status.isNotEmpty
            ? '''
              SELECT s.* FROM surveys s
              INNER JOIN kos k ON k.id = s.kos_id
              WHERE k.owner_id = ? AND s.status = ?
              ORDER BY s.id DESC
              '''
            : '''
              SELECT s.* FROM surveys s
              INNER JOIN kos k ON k.id = s.kos_id
              WHERE k.owner_id = ?
              ORDER BY s.id DESC
              ''',
        status.isNotEmpty ? [ownerId, status] : [ownerId],
      );
      final paged = _paginate(rows, page, perPage);
      final items = <Map<String, dynamic>>[];
      for (final r in paged) {
        items.add(await this.db.buildSurveyJson(db, r));
      }
      final meta = await this.db.buildPaginationMeta(
        page: page,
        perPage: perPage,
        total: rows.length,
      );
      return _ok(options, items, extra: {'meta': meta});
    }

    final surveyStatusMatch = RegExp(
      r'^/owner/surveys/(\d+)/status$',
    ).firstMatch(path);
    if (surveyStatusMatch != null && method == 'PATCH') {
      final id = int.parse(surveyStatusMatch.group(1)!);
      final body = await _readBody(options.data);
      await db.update(
        'surveys',
        {
          'status': body['status'],
          'rejection_reason': body['rejection_reason'],
        },
        where: 'id = ?',
        whereArgs: [id],
      );
      final updated = (await db.query(
        'surveys',
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      )).first;
      return _ok(options, await this.db.buildSurveyJson(db, updated));
    }

    // Owner maintenance
    if (path == '/owner/maintenance-reports' && method == 'GET') {
      final status = (options.queryParameters['status'] as String? ?? '').trim();
      final page = _queryInt(options, 'page', 1);
      final perPage = _queryInt(options, 'per_page', 20);
      final rows = await db.rawQuery(
        status.isNotEmpty
            ? '''
              SELECT m.* FROM maintenance_reports m
              INNER JOIN bookings b ON b.id = m.booking_id
              INNER JOIN kos k ON k.id = b.kos_id
              WHERE k.owner_id = ? AND m.status = ?
              ORDER BY m.id DESC
              '''
            : '''
              SELECT m.* FROM maintenance_reports m
              INNER JOIN bookings b ON b.id = m.booking_id
              INNER JOIN kos k ON k.id = b.kos_id
              WHERE k.owner_id = ?
              ORDER BY m.id DESC
              ''',
        status.isNotEmpty ? [ownerId, status] : [ownerId],
      );
      final paged = _paginate(rows, page, perPage);
      final items = <Map<String, dynamic>>[];
      for (final r in paged) {
        items.add(await this.db.buildMaintenanceJson(db, r));
      }
      final meta = await this.db.buildPaginationMeta(
        page: page,
        perPage: perPage,
        total: rows.length,
      );
      return _ok(options, items, extra: {'meta': meta});
    }

    final maintStatusMatch = RegExp(
      r'^/owner/maintenance-reports/(\d+)/status$',
    ).firstMatch(path);
    if (maintStatusMatch != null && method == 'PATCH') {
      final id = int.parse(maintStatusMatch.group(1)!);
      final body = await _readBody(options.data);
      await db.update(
        'maintenance_reports',
        {
          'status': body['status'],
          'owner_notes': body['owner_notes'],
        },
        where: 'id = ?',
        whereArgs: [id],
      );
      final updated = (await db.query(
        'maintenance_reports',
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      )).first;
      return _ok(options, await this.db.buildMaintenanceJson(db, updated));
    }

    // Owner reviews
    if (path == '/owner/reviews' && method == 'GET') {
      final page = _queryInt(options, 'page', 1);
      final perPage = _queryInt(options, 'per_page', 20);
      final kosId = int.tryParse('${options.queryParameters['kos_id'] ?? ''}');
      final rows = await db.rawQuery(
        kosId != null
            ? '''
              SELECT r.* FROM reviews r
              INNER JOIN kos k ON k.id = r.kos_id
              WHERE k.owner_id = ? AND r.kos_id = ?
              ORDER BY r.id DESC
              '''
            : '''
              SELECT r.* FROM reviews r
              INNER JOIN kos k ON k.id = r.kos_id
              WHERE k.owner_id = ?
              ORDER BY r.id DESC
              ''',
        kosId != null ? [ownerId, kosId] : [ownerId],
      );
      final avg = rows.isEmpty
          ? 0.0
          : rows.map((r) => (r['rating'] as num).toDouble()).reduce((a, b) => a + b) /
                rows.length;
      final paged = _paginate(rows, page, perPage);
      final meta = await this.db.buildPaginationMeta(
        page: page,
        perPage: perPage,
        total: rows.length,
      );
      return _ok(
        options,
        paged.map(this.db.buildReviewJson).toList(),
        extra: {
          'rating_summary': {
            'total_reviews': rows.length,
            'average_rating': double.parse(avg.toStringAsFixed(1)),
          },
          'meta': meta,
        },
      );
    }

    final replyMatch = RegExp(r'^/owner/reviews/(\d+)/reply$').firstMatch(path);
    if (replyMatch != null && method == 'POST') {
      final id = int.parse(replyMatch.group(1)!);
      final body = await _readBody(options.data);
      await db.update(
        'reviews',
        {'reply': (body['reply'] as String? ?? '').trim()},
        where: 'id = ?',
        whereArgs: [id],
      );
      final updated = (await db.query(
        'reviews',
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      )).first;
      return _ok(options, this.db.buildReviewJson(updated));
    }

    // Owner analytics
    if (path == '/owner/analytics' && method == 'GET') {
      final paidRow = (await db.rawQuery(
        '''
        SELECT COALESCE(SUM(i.total_amount), 0) AS rev
        FROM invoices i
        INNER JOIN bookings b ON b.id = i.booking_id
        INNER JOIN kos k ON k.id = b.kos_id
        WHERE k.owner_id = ? AND i.status = 'paid'
        ''',
        [ownerId],
      )).first;
      final totalRev = (paidRow['rev'] as num?)?.toDouble() ?? 0.0;
      final bookingCount = Sqflite.firstIntValue(
            await db.rawQuery(
              '''
              SELECT COUNT(*) FROM bookings b
              INNER JOIN kos k ON k.id = b.kos_id
              WHERE k.owner_id = ?
              ''',
              [ownerId],
            ),
          ) ??
          0;
      final totalRooms = Sqflite.firstIntValue(
            await db.rawQuery(
              '''
              SELECT COUNT(*) FROM rooms r
              INNER JOIN kos k ON k.id = r.kos_id
              WHERE k.owner_id = ?
              ''',
              [ownerId],
            ),
          ) ??
          1;
      final occupiedRooms = Sqflite.firstIntValue(
            await db.rawQuery(
              '''
              SELECT COUNT(*) FROM rooms r
              INNER JOIN kos k ON k.id = r.kos_id
              WHERE k.owner_id = ? AND r.status = 'occupied'
              ''',
              [ownerId],
            ),
          ) ??
          0;
      final occupancyPct = totalRooms == 0
          ? 0
          : ((occupiedRooms / totalRooms) * 100).round();

      final kosRows = await db.query(
        'kos',
        where: 'owner_id = ?',
        whereArgs: [ownerId],
        orderBy: 'id ASC',
      );
      final kosPerf = <Map<String, dynamic>>[];
      for (final k in kosRows) {
        final kId = k['id'] as int;
        final kRooms = Sqflite.firstIntValue(
              await db.rawQuery(
                'SELECT COUNT(*) FROM rooms WHERE kos_id = ?',
                [kId],
              ),
            ) ??
            1;
        final kOcc = Sqflite.firstIntValue(
              await db.rawQuery(
                "SELECT COUNT(*) FROM rooms WHERE kos_id = ? AND status = 'occupied'",
                [kId],
              ),
            ) ??
            0;
        final kBk = Sqflite.firstIntValue(
              await db.rawQuery(
                'SELECT COUNT(*) FROM bookings WHERE kos_id = ?',
                [kId],
              ),
            ) ??
            0;
        final kRevRow = (await db.rawQuery(
          '''
          SELECT COALESCE(SUM(i.total_amount), 0) AS rev
          FROM invoices i
          INNER JOIN bookings b ON b.id = i.booking_id
          WHERE b.kos_id = ? AND i.status = 'paid'
          ''',
          [kId],
        )).first;
        kosPerf.add({
          'title': k['title'],
          'occupancy': kRooms == 0 ? 0 : ((kOcc / kRooms) * 100).round(),
          'booking': kBk,
          'revenue': (kRevRow['rev'] as num?)?.toDouble() ?? 0.0,
        });
      }

      return _ok(options, {
        'total_revenue': totalRev,
        'total_bookings': bookingCount,
        'occupancy_rate': occupancyPct,
        'revenue_growth_pct': 14.5,
        'monthly_revenue': [
          {'month': 'Jul', 'value': 5400000},
          {'month': 'Agu', 'value': 7200000},
          {'month': 'Sep', 'value': 8900000},
          {'month': 'Okt', 'value': 9400000},
          {'month': 'Nov', 'value': totalRev > 0 ? totalRev : 11125000},
        ],
        'kos_performance': kosPerf,
      });
    }

    throw _HttpDemoError(404, 'Endpoint owner tidak ditemukan ($method $path).');
  }

  Future<Response<dynamic>> _saveOwnerKos(
    RequestOptions options,
    Database db,
    int ownerId,
    String? existingSlug,
    Map<String, dynamic> body,
  ) async {
    final title = (body['title'] as String? ?? '').trim();
    final type = (body['type'] as String? ?? 'Campur').trim();
    final city = (body['city'] as String? ?? '').trim();
    final price = double.tryParse('${body['price'] ?? ''}') ?? 0;
    if (title.isEmpty || city.isEmpty || price <= 0) {
      throw const _HttpDemoError(
        422,
        'Judul kos, kota, dan harga bulanan wajib diisi.',
      );
    }

    final uploadedThumb = body['_file_thumbnail'] as _SavedDemoFile?;
    final uploadedPhotos =
        (body['_files_photos[]'] as List<_SavedDemoFile>?) ?? const [];
    final facIds = _parseIntList(body['facilities[]']);
    final deletePhotoIds = _parseIntList(body['delete_photos[]']);

    late String slug;
    late int kosId;

    if (existingSlug == null) {
      final baseSlug = _slugify(title);
      slug = '$baseSlug-${DateTime.now().millisecondsSinceEpoch % 10000}';
      final thumb = uploadedThumb?.localPath ?? 'assets/images/kos/kos_001.png';
      kosId = await db.insert('kos', {
        'owner_id': ownerId,
        'title': title,
        'slug': slug,
        'description': body['description'],
        'price': price,
        'type': type,
        'city': city,
        'address': body['address'],
        'thumbnail_url': thumb,
        'status': body['status'] as String? ?? 'active',
        'area': body['area'],
        'rooms_summary': body['rooms'],
        'bathrooms': body['bathrooms'],
        'bedrooms': body['bedrooms'],
        'garages': body['garages'],
        'latitude': double.tryParse('${body['latitude'] ?? ''}'),
        'longitude': double.tryParse('${body['longitude'] ?? ''}'),
        'created_at': DateTime.now().toIso8601String(),
      });
      await db.insert('kos_photos', {
        'kos_id': kosId,
        'photo_url': thumb,
        'sort_order': 0,
      });
      await db.insert('rooms', {
        'kos_id': kosId,
        'room_number': 'A-101',
        'floor': 'Lantai 1',
        'room_type': 'Standard',
        'price_override': null,
        'status': 'available',
        'notes': 'Kamar default',
      });
    } else {
      slug = existingSlug;
      final existing = await db.query(
        'kos',
        where: 'slug = ? AND owner_id = ?',
        whereArgs: [existingSlug, ownerId],
        limit: 1,
      );
      if (existing.isEmpty) {
        throw const _HttpDemoError(404, 'Properti kos tidak ditemukan.');
      }
      kosId = existing.first['id'] as int;
      final updates = <String, Object?>{
        'title': title,
        'type': type,
        'city': city,
        'price': price,
        if (body.containsKey('address')) 'address': body['address'],
        if (body.containsKey('area')) 'area': body['area'],
        if (body.containsKey('rooms')) 'rooms_summary': body['rooms'],
        if (body.containsKey('bathrooms')) 'bathrooms': body['bathrooms'],
        if (body.containsKey('bedrooms')) 'bedrooms': body['bedrooms'],
        if (body.containsKey('garages')) 'garages': body['garages'],
        if (body.containsKey('description')) 'description': body['description'],
        if (body.containsKey('status') && body['status'] != null)
          'status': body['status'],
        if (body.containsKey('latitude'))
          'latitude': double.tryParse('${body['latitude'] ?? ''}'),
        if (body.containsKey('longitude'))
          'longitude': double.tryParse('${body['longitude'] ?? ''}'),
        if (uploadedThumb != null) 'thumbnail_url': uploadedThumb.localPath,
      };
      await db.update('kos', updates, where: 'id = ?', whereArgs: [kosId]);
    }

    if (body.containsKey('facilities[]')) {
      await db.delete(
        'kos_facilities',
        where: 'kos_id = ?',
        whereArgs: [kosId],
      );
      for (final fid in facIds) {
        await db.insert('kos_facilities', {
          'kos_id': kosId,
          'facility_id': fid,
        });
      }
    }

    for (final delId in deletePhotoIds) {
      await db.delete(
        'kos_photos',
        where: 'id = ? AND kos_id = ?',
        whereArgs: [delId, kosId],
      );
    }

    for (final file in uploadedPhotos) {
      await db.insert('kos_photos', {
        'kos_id': kosId,
        'photo_url': file.localPath,
        'sort_order': 10,
      });
    }

    final detail = await this.db.buildKosDetailJson(slug);
    return _ok(
      options,
      detail,
      statusCode: existingSlug == null ? 201 : 200,
    );
  }

  // ---- HELPERS ----

  Future<int> _ensureInvoiceForBooking(
    Database db,
    Map<String, Object?> booking,
  ) async {
    final existing = await db.query(
      'invoices',
      where: 'booking_id = ?',
      whereArgs: [booking['id']],
      limit: 1,
    );
    if (existing.isNotEmpty) return existing.first['id'] as int;

    final maxRow = (await db.rawQuery(
      'SELECT COALESCE(MAX(id), 0) AS m FROM invoices',
    )).first;
    final seq = ((maxRow['m'] as num?)?.toInt() ?? 0) + 1;
    final invNumber =
        'INV-${DateTime.now().year}-${seq.toString().padLeft(4, '0')}';

    return db.insert('invoices', {
      'invoice_number': invNumber,
      'booking_id': booking['id'],
      'amount': booking['subtotal'],
      'admin_fee': booking['admin_fee'],
      'tax': 0.0,
      'total_amount': booking['total_amount'],
      'due_date': DateTime.now()
          .add(const Duration(days: 3))
          .toIso8601String()
          .substring(0, 10),
      'paid_at': null,
      'status': 'unpaid',
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<void> _ensureContractForBooking(
    Database db,
    Map<String, Object?> booking,
  ) async {
    final existing = await db.query(
      'rental_contracts',
      where: 'booking_id = ?',
      whereArgs: [booking['id']],
      limit: 1,
    );
    if (existing.isNotEmpty) return;

    final kosRows = await db.query(
      'kos',
      where: 'id = ?',
      whereArgs: [booking['kos_id']],
      limit: 1,
    );
    final kosTitle = kosRows.isNotEmpty
        ? kosRows.first['title'] as String
        : 'Properti TEMPATIN';

    String roomNo = 'Kamar Pilihan';
    final roomId = booking['room_id'] as int?;
    if (roomId != null) {
      final rRows = await db.query(
        'rooms',
        where: 'id = ?',
        whereArgs: [roomId],
        limit: 1,
      );
      if (rRows.isNotEmpty) roomNo = rRows.first['room_number'] as String;
    }

    final maxRow = (await db.rawQuery(
      'SELECT COALESCE(MAX(id), 0) AS m FROM rental_contracts',
    )).first;
    final seq = ((maxRow['m'] as num?)?.toInt() ?? 0) + 1;
    final number =
        'CTR-${DateTime.now().year}-${seq.toString().padLeft(4, '0')}';

    await db.insert('rental_contracts', {
      'contract_number': number,
      'booking_id': booking['id'],
      'terms':
          'PASAL 1 - OBJEK SEWA\n'
          'Pemilik menyewakan kamar $roomNo pada $kosTitle kepada ${booking['tenant_name']}.\n\n'
          'PASAL 2 - MASA SEWA\n'
          'Berlaku mulai ${booking['start_date']} hingga ${booking['end_date']}.\n\n'
          'PASAL 3 - KETENTUAN UMUM\n'
          'Penyewa menjaga kebersihan, keamanan, dan ketertiban lingkungan kos.',
      'status': 'pending',
      'is_signed': 0,
      'signed_at': null,
      'signer_ip': null,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<void> _addNotification(
    Database db, {
    required int userId,
    required String title,
    required String message,
    required String category,
    String? actionType,
    String? actionId,
    String? actionUrl,
  }) async {
    await db.insert('notifications', {
      'id': 'notif-${DateTime.now().microsecondsSinceEpoch}',
      'user_id': userId,
      'title': title,
      'message': message,
      'category': category,
      'action_type': actionType,
      'action_id': actionId,
      'action_url': actionUrl,
      'read_at': null,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<Map<String, dynamic>> _readBody(dynamic raw) async {
    if (raw == null) return const {};
    if (raw is Map<String, dynamic>) return raw;
    if (raw is FormData) {
      final result = <String, dynamic>{};
      final multiFields = <String, List<String>>{};
      for (final entry in raw.fields) {
        if (entry.key.endsWith('[]')) {
          multiFields.putIfAbsent(entry.key, () => []).add(entry.value);
        } else {
          result[entry.key] = entry.value;
        }
      }
      result.addAll(multiFields);

      for (final entry in raw.files) {
        final saved = await _persistUploadedFile(entry.value);
        if (entry.key.endsWith('[]')) {
          final list =
              (result['_files_${entry.key}'] as List<_SavedDemoFile>?) ?? [];
          list.add(saved);
          result['_files_${entry.key}'] = list;
        } else {
          result['_file_${entry.key}'] = saved;
        }
      }
      return result;
    }
    return const {};
  }

  Future<_SavedDemoFile> _persistUploadedFile(MultipartFile file) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final uploadDir = Directory(p.join(dir.path, 'demo_uploads'));
      if (!uploadDir.existsSync()) {
        uploadDir.createSync(recursive: true);
      }
      final ext = p.extension(file.filename ?? 'upload.jpg');
      final safeExt = ext.isEmpty ? '.jpg' : ext;
      final dest = File(
        p.join(
          uploadDir.path,
          'img_${DateTime.now().microsecondsSinceEpoch}$safeExt',
        ),
      );
      final chunks = await file.finalize().toList();
      final bytes = chunks.expand((c) => c).toList();
      await dest.writeAsBytes(bytes, flush: true);
      return _SavedDemoFile(dest.path);
    } catch (_) {
      return const _SavedDemoFile('assets/images/kos/placeholder.jpg');
    }
  }

  List<int> _parseIntList(dynamic raw) {
    if (raw is! List) return const [];
    return raw.map((e) => int.tryParse('$e')).whereType<int>().toList();
  }

  int _queryInt(RequestOptions options, String key, int fallback) {
    final val = options.queryParameters[key];
    return int.tryParse('${val ?? ''}') ?? fallback;
  }

  List<T> _paginate<T>(List<T> items, int page, int perPage) {
    final start = math.max(0, (page - 1) * perPage);
    if (start >= items.length) return const [];
    final end = math.min(items.length, start + perPage);
    return items.sublist(start, end);
  }

  String _slugify(String input) {
    return input
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
        .replaceAll(RegExp(r'^-+|-+$'), '');
  }
}

class _SavedDemoFile {
  const _SavedDemoFile(this.localPath);
  final String localPath;
}

class _HttpDemoError implements Exception {
  const _HttpDemoError(this.statusCode, this.message);

  final int statusCode;
  final String message;
}
