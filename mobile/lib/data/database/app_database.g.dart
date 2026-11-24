// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _passwordHashMeta = const VerificationMeta(
    'passwordHash',
  );
  @override
  late final GeneratedColumn<String> passwordHash = GeneratedColumn<String>(
    'password_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _passwordSaltMeta = const VerificationMeta(
    'passwordSalt',
  );
  @override
  late final GeneratedColumn<String> passwordSalt = GeneratedColumn<String>(
    'password_salt',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('member'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    email,
    passwordHash,
    passwordSalt,
    role,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('password_hash')) {
      context.handle(
        _passwordHashMeta,
        passwordHash.isAcceptableOrUnknown(
          data['password_hash']!,
          _passwordHashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_passwordHashMeta);
    }
    if (data.containsKey('password_salt')) {
      context.handle(
        _passwordSaltMeta,
        passwordSalt.isAcceptableOrUnknown(
          data['password_salt']!,
          _passwordSaltMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_passwordSaltMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      passwordHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password_hash'],
      )!,
      passwordSalt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password_salt'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String name;
  final String email;
  final String passwordHash;
  final String passwordSalt;
  final String role;
  final DateTime createdAt;
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.passwordHash,
    required this.passwordSalt,
    required this.role,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['email'] = Variable<String>(email);
    map['password_hash'] = Variable<String>(passwordHash);
    map['password_salt'] = Variable<String>(passwordSalt);
    map['role'] = Variable<String>(role);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      name: Value(name),
      email: Value(email),
      passwordHash: Value(passwordHash),
      passwordSalt: Value(passwordSalt),
      role: Value(role),
      createdAt: Value(createdAt),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String>(json['email']),
      passwordHash: serializer.fromJson<String>(json['passwordHash']),
      passwordSalt: serializer.fromJson<String>(json['passwordSalt']),
      role: serializer.fromJson<String>(json['role']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String>(email),
      'passwordHash': serializer.toJson<String>(passwordHash),
      'passwordSalt': serializer.toJson<String>(passwordSalt),
      'role': serializer.toJson<String>(role),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? passwordHash,
    String? passwordSalt,
    String? role,
    DateTime? createdAt,
  }) => User(
    id: id ?? this.id,
    name: name ?? this.name,
    email: email ?? this.email,
    passwordHash: passwordHash ?? this.passwordHash,
    passwordSalt: passwordSalt ?? this.passwordSalt,
    role: role ?? this.role,
    createdAt: createdAt ?? this.createdAt,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      passwordHash: data.passwordHash.present
          ? data.passwordHash.value
          : this.passwordHash,
      passwordSalt: data.passwordSalt.present
          ? data.passwordSalt.value
          : this.passwordSalt,
      role: data.role.present ? data.role.value : this.role,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('passwordSalt: $passwordSalt, ')
          ..write('role: $role, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, email, passwordHash, passwordSalt, role, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.name == this.name &&
          other.email == this.email &&
          other.passwordHash == this.passwordHash &&
          other.passwordSalt == this.passwordSalt &&
          other.role == this.role &&
          other.createdAt == this.createdAt);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> email;
  final Value<String> passwordHash;
  final Value<String> passwordSalt;
  final Value<String> role;
  final Value<DateTime> createdAt;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.passwordSalt = const Value.absent(),
    this.role = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String email,
    required String passwordHash,
    required String passwordSalt,
    this.role = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name),
       email = Value(email),
       passwordHash = Value(passwordHash),
       passwordSalt = Value(passwordSalt);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? passwordHash,
    Expression<String>? passwordSalt,
    Expression<String>? role,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (passwordHash != null) 'password_hash': passwordHash,
      if (passwordSalt != null) 'password_salt': passwordSalt,
      if (role != null) 'role': role,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  UsersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? email,
    Value<String>? passwordHash,
    Value<String>? passwordSalt,
    Value<String>? role,
    Value<DateTime>? createdAt,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
      passwordSalt: passwordSalt ?? this.passwordSalt,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (passwordHash.present) {
      map['password_hash'] = Variable<String>(passwordHash.value);
    }
    if (passwordSalt.present) {
      map['password_salt'] = Variable<String>(passwordSalt.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('passwordSalt: $passwordSalt, ')
          ..write('role: $role, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $UserProfilesTable extends UserProfiles
    with TableInfo<$UserProfilesTable, UserProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES users (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bioMeta = const VerificationMeta('bio');
  @override
  late final GeneratedColumn<String> bio = GeneratedColumn<String>(
    'bio',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _avatarAssetMeta = const VerificationMeta(
    'avatarAsset',
  );
  @override
  late final GeneratedColumn<String> avatarAsset = GeneratedColumn<String>(
    'avatar_asset',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    phone,
    address,
    bio,
    avatarAsset,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('bio')) {
      context.handle(
        _bioMeta,
        bio.isAcceptableOrUnknown(data['bio']!, _bioMeta),
      );
    }
    if (data.containsKey('avatar_asset')) {
      context.handle(
        _avatarAssetMeta,
        avatarAsset.isAcceptableOrUnknown(
          data['avatar_asset']!,
          _avatarAssetMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      bio: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bio'],
      ),
      avatarAsset: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_asset'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UserProfilesTable createAlias(String alias) {
    return $UserProfilesTable(attachedDatabase, alias);
  }
}

class UserProfile extends DataClass implements Insertable<UserProfile> {
  final int id;
  final int userId;
  final String? phone;
  final String? address;
  final String? bio;
  final String? avatarAsset;
  final DateTime updatedAt;
  const UserProfile({
    required this.id,
    required this.userId,
    this.phone,
    this.address,
    this.bio,
    this.avatarAsset,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || bio != null) {
      map['bio'] = Variable<String>(bio);
    }
    if (!nullToAbsent || avatarAsset != null) {
      map['avatar_asset'] = Variable<String>(avatarAsset);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserProfilesCompanion toCompanion(bool nullToAbsent) {
    return UserProfilesCompanion(
      id: Value(id),
      userId: Value(userId),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      bio: bio == null && nullToAbsent ? const Value.absent() : Value(bio),
      avatarAsset: avatarAsset == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarAsset),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfile(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      phone: serializer.fromJson<String?>(json['phone']),
      address: serializer.fromJson<String?>(json['address']),
      bio: serializer.fromJson<String?>(json['bio']),
      avatarAsset: serializer.fromJson<String?>(json['avatarAsset']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'phone': serializer.toJson<String?>(phone),
      'address': serializer.toJson<String?>(address),
      'bio': serializer.toJson<String?>(bio),
      'avatarAsset': serializer.toJson<String?>(avatarAsset),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserProfile copyWith({
    int? id,
    int? userId,
    Value<String?> phone = const Value.absent(),
    Value<String?> address = const Value.absent(),
    Value<String?> bio = const Value.absent(),
    Value<String?> avatarAsset = const Value.absent(),
    DateTime? updatedAt,
  }) => UserProfile(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    phone: phone.present ? phone.value : this.phone,
    address: address.present ? address.value : this.address,
    bio: bio.present ? bio.value : this.bio,
    avatarAsset: avatarAsset.present ? avatarAsset.value : this.avatarAsset,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserProfile copyWithCompanion(UserProfilesCompanion data) {
    return UserProfile(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      phone: data.phone.present ? data.phone.value : this.phone,
      address: data.address.present ? data.address.value : this.address,
      bio: data.bio.present ? data.bio.value : this.bio,
      avatarAsset: data.avatarAsset.present
          ? data.avatarAsset.value
          : this.avatarAsset,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfile(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('bio: $bio, ')
          ..write('avatarAsset: $avatarAsset, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, phone, address, bio, avatarAsset, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfile &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.phone == this.phone &&
          other.address == this.address &&
          other.bio == this.bio &&
          other.avatarAsset == this.avatarAsset &&
          other.updatedAt == this.updatedAt);
}

class UserProfilesCompanion extends UpdateCompanion<UserProfile> {
  final Value<int> id;
  final Value<int> userId;
  final Value<String?> phone;
  final Value<String?> address;
  final Value<String?> bio;
  final Value<String?> avatarAsset;
  final Value<DateTime> updatedAt;
  const UserProfilesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.bio = const Value.absent(),
    this.avatarAsset = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UserProfilesCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.bio = const Value.absent(),
    this.avatarAsset = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : userId = Value(userId);
  static Insertable<UserProfile> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<String>? phone,
    Expression<String>? address,
    Expression<String>? bio,
    Expression<String>? avatarAsset,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (bio != null) 'bio': bio,
      if (avatarAsset != null) 'avatar_asset': avatarAsset,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UserProfilesCompanion copyWith({
    Value<int>? id,
    Value<int>? userId,
    Value<String?>? phone,
    Value<String?>? address,
    Value<String?>? bio,
    Value<String?>? avatarAsset,
    Value<DateTime>? updatedAt,
  }) {
    return UserProfilesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      bio: bio ?? this.bio,
      avatarAsset: avatarAsset ?? this.avatarAsset,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (bio.present) {
      map['bio'] = Variable<String>(bio.value);
    }
    if (avatarAsset.present) {
      map['avatar_asset'] = Variable<String>(avatarAsset.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfilesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('bio: $bio, ')
          ..write('avatarAsset: $avatarAsset, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $KosPropertiesTable extends KosProperties
    with TableInfo<$KosPropertiesTable, KosProperty> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KosPropertiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _ownerIdMeta = const VerificationMeta(
    'ownerId',
  );
  @override
  late final GeneratedColumn<int> ownerId = GeneratedColumn<int>(
    'owner_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
    'city',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _thumbnailAssetMeta = const VerificationMeta(
    'thumbnailAsset',
  );
  @override
  late final GeneratedColumn<String> thumbnailAsset = GeneratedColumn<String>(
    'thumbnail_asset',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('active'),
  );
  static const VerificationMeta _areaMeta = const VerificationMeta('area');
  @override
  late final GeneratedColumn<String> area = GeneratedColumn<String>(
    'area',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _roomsCountMeta = const VerificationMeta(
    'roomsCount',
  );
  @override
  late final GeneratedColumn<String> roomsCount = GeneratedColumn<String>(
    'rooms_count',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bathroomsMeta = const VerificationMeta(
    'bathrooms',
  );
  @override
  late final GeneratedColumn<String> bathrooms = GeneratedColumn<String>(
    'bathrooms',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _garagesMeta = const VerificationMeta(
    'garages',
  );
  @override
  late final GeneratedColumn<String> garages = GeneratedColumn<String>(
    'garages',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isFeaturedMeta = const VerificationMeta(
    'isFeatured',
  );
  @override
  late final GeneratedColumn<bool> isFeatured = GeneratedColumn<bool>(
    'is_featured',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_featured" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ownerId,
    slug,
    title,
    description,
    price,
    type,
    city,
    address,
    thumbnailAsset,
    status,
    area,
    roomsCount,
    bathrooms,
    garages,
    isFeatured,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kos';
  @override
  VerificationContext validateIntegrity(
    Insertable<KosProperty> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
    }
    if (data.containsKey('slug')) {
      context.handle(
        _slugMeta,
        slug.isAcceptableOrUnknown(data['slug']!, _slugMeta),
      );
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('city')) {
      context.handle(
        _cityMeta,
        city.isAcceptableOrUnknown(data['city']!, _cityMeta),
      );
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('thumbnail_asset')) {
      context.handle(
        _thumbnailAssetMeta,
        thumbnailAsset.isAcceptableOrUnknown(
          data['thumbnail_asset']!,
          _thumbnailAssetMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_thumbnailAssetMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('area')) {
      context.handle(
        _areaMeta,
        area.isAcceptableOrUnknown(data['area']!, _areaMeta),
      );
    }
    if (data.containsKey('rooms_count')) {
      context.handle(
        _roomsCountMeta,
        roomsCount.isAcceptableOrUnknown(data['rooms_count']!, _roomsCountMeta),
      );
    }
    if (data.containsKey('bathrooms')) {
      context.handle(
        _bathroomsMeta,
        bathrooms.isAcceptableOrUnknown(data['bathrooms']!, _bathroomsMeta),
      );
    }
    if (data.containsKey('garages')) {
      context.handle(
        _garagesMeta,
        garages.isAcceptableOrUnknown(data['garages']!, _garagesMeta),
      );
    }
    if (data.containsKey('is_featured')) {
      context.handle(
        _isFeaturedMeta,
        isFeatured.isAcceptableOrUnknown(data['is_featured']!, _isFeaturedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KosProperty map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KosProperty(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}owner_id'],
      )!,
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      city: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
      thumbnailAsset: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}thumbnail_asset'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      area: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}area'],
      ),
      roomsCount: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rooms_count'],
      ),
      bathrooms: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bathrooms'],
      ),
      garages: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}garages'],
      ),
      isFeatured: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_featured'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $KosPropertiesTable createAlias(String alias) {
    return $KosPropertiesTable(attachedDatabase, alias);
  }
}

class KosProperty extends DataClass implements Insertable<KosProperty> {
  final int id;
  final int ownerId;
  final String slug;
  final String title;
  final String description;
  final double price;
  final String type;
  final String city;
  final String address;
  final String thumbnailAsset;
  final String status;
  final String? area;
  final String? roomsCount;
  final String? bathrooms;
  final String? garages;
  final bool isFeatured;
  final DateTime createdAt;
  final DateTime updatedAt;
  const KosProperty({
    required this.id,
    required this.ownerId,
    required this.slug,
    required this.title,
    required this.description,
    required this.price,
    required this.type,
    required this.city,
    required this.address,
    required this.thumbnailAsset,
    required this.status,
    this.area,
    this.roomsCount,
    this.bathrooms,
    this.garages,
    required this.isFeatured,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['owner_id'] = Variable<int>(ownerId);
    map['slug'] = Variable<String>(slug);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['price'] = Variable<double>(price);
    map['type'] = Variable<String>(type);
    map['city'] = Variable<String>(city);
    map['address'] = Variable<String>(address);
    map['thumbnail_asset'] = Variable<String>(thumbnailAsset);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || area != null) {
      map['area'] = Variable<String>(area);
    }
    if (!nullToAbsent || roomsCount != null) {
      map['rooms_count'] = Variable<String>(roomsCount);
    }
    if (!nullToAbsent || bathrooms != null) {
      map['bathrooms'] = Variable<String>(bathrooms);
    }
    if (!nullToAbsent || garages != null) {
      map['garages'] = Variable<String>(garages);
    }
    map['is_featured'] = Variable<bool>(isFeatured);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  KosPropertiesCompanion toCompanion(bool nullToAbsent) {
    return KosPropertiesCompanion(
      id: Value(id),
      ownerId: Value(ownerId),
      slug: Value(slug),
      title: Value(title),
      description: Value(description),
      price: Value(price),
      type: Value(type),
      city: Value(city),
      address: Value(address),
      thumbnailAsset: Value(thumbnailAsset),
      status: Value(status),
      area: area == null && nullToAbsent ? const Value.absent() : Value(area),
      roomsCount: roomsCount == null && nullToAbsent
          ? const Value.absent()
          : Value(roomsCount),
      bathrooms: bathrooms == null && nullToAbsent
          ? const Value.absent()
          : Value(bathrooms),
      garages: garages == null && nullToAbsent
          ? const Value.absent()
          : Value(garages),
      isFeatured: Value(isFeatured),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory KosProperty.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KosProperty(
      id: serializer.fromJson<int>(json['id']),
      ownerId: serializer.fromJson<int>(json['ownerId']),
      slug: serializer.fromJson<String>(json['slug']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      price: serializer.fromJson<double>(json['price']),
      type: serializer.fromJson<String>(json['type']),
      city: serializer.fromJson<String>(json['city']),
      address: serializer.fromJson<String>(json['address']),
      thumbnailAsset: serializer.fromJson<String>(json['thumbnailAsset']),
      status: serializer.fromJson<String>(json['status']),
      area: serializer.fromJson<String?>(json['area']),
      roomsCount: serializer.fromJson<String?>(json['roomsCount']),
      bathrooms: serializer.fromJson<String?>(json['bathrooms']),
      garages: serializer.fromJson<String?>(json['garages']),
      isFeatured: serializer.fromJson<bool>(json['isFeatured']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ownerId': serializer.toJson<int>(ownerId),
      'slug': serializer.toJson<String>(slug),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'price': serializer.toJson<double>(price),
      'type': serializer.toJson<String>(type),
      'city': serializer.toJson<String>(city),
      'address': serializer.toJson<String>(address),
      'thumbnailAsset': serializer.toJson<String>(thumbnailAsset),
      'status': serializer.toJson<String>(status),
      'area': serializer.toJson<String?>(area),
      'roomsCount': serializer.toJson<String?>(roomsCount),
      'bathrooms': serializer.toJson<String?>(bathrooms),
      'garages': serializer.toJson<String?>(garages),
      'isFeatured': serializer.toJson<bool>(isFeatured),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  KosProperty copyWith({
    int? id,
    int? ownerId,
    String? slug,
    String? title,
    String? description,
    double? price,
    String? type,
    String? city,
    String? address,
    String? thumbnailAsset,
    String? status,
    Value<String?> area = const Value.absent(),
    Value<String?> roomsCount = const Value.absent(),
    Value<String?> bathrooms = const Value.absent(),
    Value<String?> garages = const Value.absent(),
    bool? isFeatured,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => KosProperty(
    id: id ?? this.id,
    ownerId: ownerId ?? this.ownerId,
    slug: slug ?? this.slug,
    title: title ?? this.title,
    description: description ?? this.description,
    price: price ?? this.price,
    type: type ?? this.type,
    city: city ?? this.city,
    address: address ?? this.address,
    thumbnailAsset: thumbnailAsset ?? this.thumbnailAsset,
    status: status ?? this.status,
    area: area.present ? area.value : this.area,
    roomsCount: roomsCount.present ? roomsCount.value : this.roomsCount,
    bathrooms: bathrooms.present ? bathrooms.value : this.bathrooms,
    garages: garages.present ? garages.value : this.garages,
    isFeatured: isFeatured ?? this.isFeatured,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  KosProperty copyWithCompanion(KosPropertiesCompanion data) {
    return KosProperty(
      id: data.id.present ? data.id.value : this.id,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      slug: data.slug.present ? data.slug.value : this.slug,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      price: data.price.present ? data.price.value : this.price,
      type: data.type.present ? data.type.value : this.type,
      city: data.city.present ? data.city.value : this.city,
      address: data.address.present ? data.address.value : this.address,
      thumbnailAsset: data.thumbnailAsset.present
          ? data.thumbnailAsset.value
          : this.thumbnailAsset,
      status: data.status.present ? data.status.value : this.status,
      area: data.area.present ? data.area.value : this.area,
      roomsCount: data.roomsCount.present
          ? data.roomsCount.value
          : this.roomsCount,
      bathrooms: data.bathrooms.present ? data.bathrooms.value : this.bathrooms,
      garages: data.garages.present ? data.garages.value : this.garages,
      isFeatured: data.isFeatured.present
          ? data.isFeatured.value
          : this.isFeatured,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KosProperty(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('slug: $slug, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('price: $price, ')
          ..write('type: $type, ')
          ..write('city: $city, ')
          ..write('address: $address, ')
          ..write('thumbnailAsset: $thumbnailAsset, ')
          ..write('status: $status, ')
          ..write('area: $area, ')
          ..write('roomsCount: $roomsCount, ')
          ..write('bathrooms: $bathrooms, ')
          ..write('garages: $garages, ')
          ..write('isFeatured: $isFeatured, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    ownerId,
    slug,
    title,
    description,
    price,
    type,
    city,
    address,
    thumbnailAsset,
    status,
    area,
    roomsCount,
    bathrooms,
    garages,
    isFeatured,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KosProperty &&
          other.id == this.id &&
          other.ownerId == this.ownerId &&
          other.slug == this.slug &&
          other.title == this.title &&
          other.description == this.description &&
          other.price == this.price &&
          other.type == this.type &&
          other.city == this.city &&
          other.address == this.address &&
          other.thumbnailAsset == this.thumbnailAsset &&
          other.status == this.status &&
          other.area == this.area &&
          other.roomsCount == this.roomsCount &&
          other.bathrooms == this.bathrooms &&
          other.garages == this.garages &&
          other.isFeatured == this.isFeatured &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class KosPropertiesCompanion extends UpdateCompanion<KosProperty> {
  final Value<int> id;
  final Value<int> ownerId;
  final Value<String> slug;
  final Value<String> title;
  final Value<String> description;
  final Value<double> price;
  final Value<String> type;
  final Value<String> city;
  final Value<String> address;
  final Value<String> thumbnailAsset;
  final Value<String> status;
  final Value<String?> area;
  final Value<String?> roomsCount;
  final Value<String?> bathrooms;
  final Value<String?> garages;
  final Value<bool> isFeatured;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const KosPropertiesCompanion({
    this.id = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.slug = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.price = const Value.absent(),
    this.type = const Value.absent(),
    this.city = const Value.absent(),
    this.address = const Value.absent(),
    this.thumbnailAsset = const Value.absent(),
    this.status = const Value.absent(),
    this.area = const Value.absent(),
    this.roomsCount = const Value.absent(),
    this.bathrooms = const Value.absent(),
    this.garages = const Value.absent(),
    this.isFeatured = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  KosPropertiesCompanion.insert({
    this.id = const Value.absent(),
    required int ownerId,
    required String slug,
    required String title,
    required String description,
    required double price,
    required String type,
    required String city,
    required String address,
    required String thumbnailAsset,
    this.status = const Value.absent(),
    this.area = const Value.absent(),
    this.roomsCount = const Value.absent(),
    this.bathrooms = const Value.absent(),
    this.garages = const Value.absent(),
    this.isFeatured = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : ownerId = Value(ownerId),
       slug = Value(slug),
       title = Value(title),
       description = Value(description),
       price = Value(price),
       type = Value(type),
       city = Value(city),
       address = Value(address),
       thumbnailAsset = Value(thumbnailAsset);
  static Insertable<KosProperty> custom({
    Expression<int>? id,
    Expression<int>? ownerId,
    Expression<String>? slug,
    Expression<String>? title,
    Expression<String>? description,
    Expression<double>? price,
    Expression<String>? type,
    Expression<String>? city,
    Expression<String>? address,
    Expression<String>? thumbnailAsset,
    Expression<String>? status,
    Expression<String>? area,
    Expression<String>? roomsCount,
    Expression<String>? bathrooms,
    Expression<String>? garages,
    Expression<bool>? isFeatured,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ownerId != null) 'owner_id': ownerId,
      if (slug != null) 'slug': slug,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (price != null) 'price': price,
      if (type != null) 'type': type,
      if (city != null) 'city': city,
      if (address != null) 'address': address,
      if (thumbnailAsset != null) 'thumbnail_asset': thumbnailAsset,
      if (status != null) 'status': status,
      if (area != null) 'area': area,
      if (roomsCount != null) 'rooms_count': roomsCount,
      if (bathrooms != null) 'bathrooms': bathrooms,
      if (garages != null) 'garages': garages,
      if (isFeatured != null) 'is_featured': isFeatured,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  KosPropertiesCompanion copyWith({
    Value<int>? id,
    Value<int>? ownerId,
    Value<String>? slug,
    Value<String>? title,
    Value<String>? description,
    Value<double>? price,
    Value<String>? type,
    Value<String>? city,
    Value<String>? address,
    Value<String>? thumbnailAsset,
    Value<String>? status,
    Value<String?>? area,
    Value<String?>? roomsCount,
    Value<String?>? bathrooms,
    Value<String?>? garages,
    Value<bool>? isFeatured,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return KosPropertiesCompanion(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      slug: slug ?? this.slug,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      type: type ?? this.type,
      city: city ?? this.city,
      address: address ?? this.address,
      thumbnailAsset: thumbnailAsset ?? this.thumbnailAsset,
      status: status ?? this.status,
      area: area ?? this.area,
      roomsCount: roomsCount ?? this.roomsCount,
      bathrooms: bathrooms ?? this.bathrooms,
      garages: garages ?? this.garages,
      isFeatured: isFeatured ?? this.isFeatured,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<int>(ownerId.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (thumbnailAsset.present) {
      map['thumbnail_asset'] = Variable<String>(thumbnailAsset.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (area.present) {
      map['area'] = Variable<String>(area.value);
    }
    if (roomsCount.present) {
      map['rooms_count'] = Variable<String>(roomsCount.value);
    }
    if (bathrooms.present) {
      map['bathrooms'] = Variable<String>(bathrooms.value);
    }
    if (garages.present) {
      map['garages'] = Variable<String>(garages.value);
    }
    if (isFeatured.present) {
      map['is_featured'] = Variable<bool>(isFeatured.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KosPropertiesCompanion(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('slug: $slug, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('price: $price, ')
          ..write('type: $type, ')
          ..write('city: $city, ')
          ..write('address: $address, ')
          ..write('thumbnailAsset: $thumbnailAsset, ')
          ..write('status: $status, ')
          ..write('area: $area, ')
          ..write('roomsCount: $roomsCount, ')
          ..write('bathrooms: $bathrooms, ')
          ..write('garages: $garages, ')
          ..write('isFeatured: $isFeatured, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $KosImagesTable extends KosImages
    with TableInfo<$KosImagesTable, KosImage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KosImagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _kosIdMeta = const VerificationMeta('kosId');
  @override
  late final GeneratedColumn<int> kosId = GeneratedColumn<int>(
    'kos_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES kos (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, kosId, imagePath, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kos_images';
  @override
  VerificationContext validateIntegrity(
    Insertable<KosImage> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('kos_id')) {
      context.handle(
        _kosIdMeta,
        kosId.isAcceptableOrUnknown(data['kos_id']!, _kosIdMeta),
      );
    } else if (isInserting) {
      context.missing(_kosIdMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KosImage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KosImage(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      kosId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}kos_id'],
      )!,
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $KosImagesTable createAlias(String alias) {
    return $KosImagesTable(attachedDatabase, alias);
  }
}

class KosImage extends DataClass implements Insertable<KosImage> {
  final int id;
  final int kosId;
  final String imagePath;
  final int sortOrder;
  const KosImage({
    required this.id,
    required this.kosId,
    required this.imagePath,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['kos_id'] = Variable<int>(kosId);
    map['image_path'] = Variable<String>(imagePath);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  KosImagesCompanion toCompanion(bool nullToAbsent) {
    return KosImagesCompanion(
      id: Value(id),
      kosId: Value(kosId),
      imagePath: Value(imagePath),
      sortOrder: Value(sortOrder),
    );
  }

  factory KosImage.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KosImage(
      id: serializer.fromJson<int>(json['id']),
      kosId: serializer.fromJson<int>(json['kosId']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'kosId': serializer.toJson<int>(kosId),
      'imagePath': serializer.toJson<String>(imagePath),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  KosImage copyWith({int? id, int? kosId, String? imagePath, int? sortOrder}) =>
      KosImage(
        id: id ?? this.id,
        kosId: kosId ?? this.kosId,
        imagePath: imagePath ?? this.imagePath,
        sortOrder: sortOrder ?? this.sortOrder,
      );
  KosImage copyWithCompanion(KosImagesCompanion data) {
    return KosImage(
      id: data.id.present ? data.id.value : this.id,
      kosId: data.kosId.present ? data.kosId.value : this.kosId,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KosImage(')
          ..write('id: $id, ')
          ..write('kosId: $kosId, ')
          ..write('imagePath: $imagePath, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, kosId, imagePath, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KosImage &&
          other.id == this.id &&
          other.kosId == this.kosId &&
          other.imagePath == this.imagePath &&
          other.sortOrder == this.sortOrder);
}

class KosImagesCompanion extends UpdateCompanion<KosImage> {
  final Value<int> id;
  final Value<int> kosId;
  final Value<String> imagePath;
  final Value<int> sortOrder;
  const KosImagesCompanion({
    this.id = const Value.absent(),
    this.kosId = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  KosImagesCompanion.insert({
    this.id = const Value.absent(),
    required int kosId,
    required String imagePath,
    this.sortOrder = const Value.absent(),
  }) : kosId = Value(kosId),
       imagePath = Value(imagePath);
  static Insertable<KosImage> custom({
    Expression<int>? id,
    Expression<int>? kosId,
    Expression<String>? imagePath,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kosId != null) 'kos_id': kosId,
      if (imagePath != null) 'image_path': imagePath,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  KosImagesCompanion copyWith({
    Value<int>? id,
    Value<int>? kosId,
    Value<String>? imagePath,
    Value<int>? sortOrder,
  }) {
    return KosImagesCompanion(
      id: id ?? this.id,
      kosId: kosId ?? this.kosId,
      imagePath: imagePath ?? this.imagePath,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (kosId.present) {
      map['kos_id'] = Variable<int>(kosId.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KosImagesCompanion(')
          ..write('id: $id, ')
          ..write('kosId: $kosId, ')
          ..write('imagePath: $imagePath, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $FacilitiesTable extends Facilities
    with TableInfo<$FacilitiesTable, Facility> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FacilitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _iconKeyMeta = const VerificationMeta(
    'iconKey',
  );
  @override
  late final GeneratedColumn<String> iconKey = GeneratedColumn<String>(
    'icon_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('check'),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, slug, iconKey];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'facilities';
  @override
  VerificationContext validateIntegrity(
    Insertable<Facility> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('slug')) {
      context.handle(
        _slugMeta,
        slug.isAcceptableOrUnknown(data['slug']!, _slugMeta),
      );
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('icon_key')) {
      context.handle(
        _iconKeyMeta,
        iconKey.isAcceptableOrUnknown(data['icon_key']!, _iconKeyMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Facility map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Facility(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
      iconKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_key'],
      )!,
    );
  }

  @override
  $FacilitiesTable createAlias(String alias) {
    return $FacilitiesTable(attachedDatabase, alias);
  }
}

class Facility extends DataClass implements Insertable<Facility> {
  final int id;
  final String name;
  final String slug;
  final String iconKey;
  const Facility({
    required this.id,
    required this.name,
    required this.slug,
    required this.iconKey,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['slug'] = Variable<String>(slug);
    map['icon_key'] = Variable<String>(iconKey);
    return map;
  }

  FacilitiesCompanion toCompanion(bool nullToAbsent) {
    return FacilitiesCompanion(
      id: Value(id),
      name: Value(name),
      slug: Value(slug),
      iconKey: Value(iconKey),
    );
  }

  factory Facility.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Facility(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      slug: serializer.fromJson<String>(json['slug']),
      iconKey: serializer.fromJson<String>(json['iconKey']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'slug': serializer.toJson<String>(slug),
      'iconKey': serializer.toJson<String>(iconKey),
    };
  }

  Facility copyWith({int? id, String? name, String? slug, String? iconKey}) =>
      Facility(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        iconKey: iconKey ?? this.iconKey,
      );
  Facility copyWithCompanion(FacilitiesCompanion data) {
    return Facility(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      slug: data.slug.present ? data.slug.value : this.slug,
      iconKey: data.iconKey.present ? data.iconKey.value : this.iconKey,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Facility(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('slug: $slug, ')
          ..write('iconKey: $iconKey')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, slug, iconKey);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Facility &&
          other.id == this.id &&
          other.name == this.name &&
          other.slug == this.slug &&
          other.iconKey == this.iconKey);
}

class FacilitiesCompanion extends UpdateCompanion<Facility> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> slug;
  final Value<String> iconKey;
  const FacilitiesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.slug = const Value.absent(),
    this.iconKey = const Value.absent(),
  });
  FacilitiesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String slug,
    this.iconKey = const Value.absent(),
  }) : name = Value(name),
       slug = Value(slug);
  static Insertable<Facility> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? slug,
    Expression<String>? iconKey,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (slug != null) 'slug': slug,
      if (iconKey != null) 'icon_key': iconKey,
    });
  }

  FacilitiesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? slug,
    Value<String>? iconKey,
  }) {
    return FacilitiesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      iconKey: iconKey ?? this.iconKey,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (iconKey.present) {
      map['icon_key'] = Variable<String>(iconKey.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FacilitiesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('slug: $slug, ')
          ..write('iconKey: $iconKey')
          ..write(')'))
        .toString();
  }
}

class $KosFacilitiesTable extends KosFacilities
    with TableInfo<$KosFacilitiesTable, KosFacility> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KosFacilitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _kosIdMeta = const VerificationMeta('kosId');
  @override
  late final GeneratedColumn<int> kosId = GeneratedColumn<int>(
    'kos_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES kos (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _facilityIdMeta = const VerificationMeta(
    'facilityId',
  );
  @override
  late final GeneratedColumn<int> facilityId = GeneratedColumn<int>(
    'facility_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES facilities (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [kosId, facilityId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kos_facilities';
  @override
  VerificationContext validateIntegrity(
    Insertable<KosFacility> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('kos_id')) {
      context.handle(
        _kosIdMeta,
        kosId.isAcceptableOrUnknown(data['kos_id']!, _kosIdMeta),
      );
    } else if (isInserting) {
      context.missing(_kosIdMeta);
    }
    if (data.containsKey('facility_id')) {
      context.handle(
        _facilityIdMeta,
        facilityId.isAcceptableOrUnknown(data['facility_id']!, _facilityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_facilityIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {kosId, facilityId};
  @override
  KosFacility map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KosFacility(
      kosId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}kos_id'],
      )!,
      facilityId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}facility_id'],
      )!,
    );
  }

  @override
  $KosFacilitiesTable createAlias(String alias) {
    return $KosFacilitiesTable(attachedDatabase, alias);
  }
}

class KosFacility extends DataClass implements Insertable<KosFacility> {
  final int kosId;
  final int facilityId;
  const KosFacility({required this.kosId, required this.facilityId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['kos_id'] = Variable<int>(kosId);
    map['facility_id'] = Variable<int>(facilityId);
    return map;
  }

  KosFacilitiesCompanion toCompanion(bool nullToAbsent) {
    return KosFacilitiesCompanion(
      kosId: Value(kosId),
      facilityId: Value(facilityId),
    );
  }

  factory KosFacility.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KosFacility(
      kosId: serializer.fromJson<int>(json['kosId']),
      facilityId: serializer.fromJson<int>(json['facilityId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'kosId': serializer.toJson<int>(kosId),
      'facilityId': serializer.toJson<int>(facilityId),
    };
  }

  KosFacility copyWith({int? kosId, int? facilityId}) => KosFacility(
    kosId: kosId ?? this.kosId,
    facilityId: facilityId ?? this.facilityId,
  );
  KosFacility copyWithCompanion(KosFacilitiesCompanion data) {
    return KosFacility(
      kosId: data.kosId.present ? data.kosId.value : this.kosId,
      facilityId: data.facilityId.present
          ? data.facilityId.value
          : this.facilityId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KosFacility(')
          ..write('kosId: $kosId, ')
          ..write('facilityId: $facilityId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(kosId, facilityId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KosFacility &&
          other.kosId == this.kosId &&
          other.facilityId == this.facilityId);
}

class KosFacilitiesCompanion extends UpdateCompanion<KosFacility> {
  final Value<int> kosId;
  final Value<int> facilityId;
  final Value<int> rowid;
  const KosFacilitiesCompanion({
    this.kosId = const Value.absent(),
    this.facilityId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  KosFacilitiesCompanion.insert({
    required int kosId,
    required int facilityId,
    this.rowid = const Value.absent(),
  }) : kosId = Value(kosId),
       facilityId = Value(facilityId);
  static Insertable<KosFacility> custom({
    Expression<int>? kosId,
    Expression<int>? facilityId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (kosId != null) 'kos_id': kosId,
      if (facilityId != null) 'facility_id': facilityId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  KosFacilitiesCompanion copyWith({
    Value<int>? kosId,
    Value<int>? facilityId,
    Value<int>? rowid,
  }) {
    return KosFacilitiesCompanion(
      kosId: kosId ?? this.kosId,
      facilityId: facilityId ?? this.facilityId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (kosId.present) {
      map['kos_id'] = Variable<int>(kosId.value);
    }
    if (facilityId.present) {
      map['facility_id'] = Variable<int>(facilityId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KosFacilitiesCompanion(')
          ..write('kosId: $kosId, ')
          ..write('facilityId: $facilityId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BookingsTable extends Bookings with TableInfo<$BookingsTable, Booking> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _bookingCodeMeta = const VerificationMeta(
    'bookingCode',
  );
  @override
  late final GeneratedColumn<String> bookingCode = GeneratedColumn<String>(
    'booking_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _kosIdMeta = const VerificationMeta('kosId');
  @override
  late final GeneratedColumn<int> kosId = GeneratedColumn<int>(
    'kos_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES kos (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _memberIdMeta = const VerificationMeta(
    'memberId',
  );
  @override
  late final GeneratedColumn<int> memberId = GeneratedColumn<int>(
    'member_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _tenantNameMeta = const VerificationMeta(
    'tenantName',
  );
  @override
  late final GeneratedColumn<String> tenantName = GeneratedColumn<String>(
    'tenant_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tenantPhoneMeta = const VerificationMeta(
    'tenantPhone',
  );
  @override
  late final GeneratedColumn<String> tenantPhone = GeneratedColumn<String>(
    'tenant_phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tenantEmailMeta = const VerificationMeta(
    'tenantEmail',
  );
  @override
  late final GeneratedColumn<String> tenantEmail = GeneratedColumn<String>(
    'tenant_email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<String> startDate = GeneratedColumn<String>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<String> endDate = GeneratedColumn<String>(
    'end_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMonthsMeta = const VerificationMeta(
    'durationMonths',
  );
  @override
  late final GeneratedColumn<int> durationMonths = GeneratedColumn<int>(
    'duration_months',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kosPriceMeta = const VerificationMeta(
    'kosPrice',
  );
  @override
  late final GeneratedColumn<double> kosPrice = GeneratedColumn<double>(
    'kos_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subtotalMeta = const VerificationMeta(
    'subtotal',
  );
  @override
  late final GeneratedColumn<double> subtotal = GeneratedColumn<double>(
    'subtotal',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _adminFeeMeta = const VerificationMeta(
    'adminFee',
  );
  @override
  late final GeneratedColumn<double> adminFee = GeneratedColumn<double>(
    'admin_fee',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(25000.0),
  );
  static const VerificationMeta _totalAmountMeta = const VerificationMeta(
    'totalAmount',
  );
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
    'total_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _rejectionReasonMeta = const VerificationMeta(
    'rejectionReason',
  );
  @override
  late final GeneratedColumn<String> rejectionReason = GeneratedColumn<String>(
    'rejection_reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    bookingCode,
    kosId,
    memberId,
    tenantName,
    tenantPhone,
    tenantEmail,
    startDate,
    endDate,
    durationMonths,
    kosPrice,
    subtotal,
    adminFee,
    totalAmount,
    notes,
    status,
    rejectionReason,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bookings';
  @override
  VerificationContext validateIntegrity(
    Insertable<Booking> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('booking_code')) {
      context.handle(
        _bookingCodeMeta,
        bookingCode.isAcceptableOrUnknown(
          data['booking_code']!,
          _bookingCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_bookingCodeMeta);
    }
    if (data.containsKey('kos_id')) {
      context.handle(
        _kosIdMeta,
        kosId.isAcceptableOrUnknown(data['kos_id']!, _kosIdMeta),
      );
    } else if (isInserting) {
      context.missing(_kosIdMeta);
    }
    if (data.containsKey('member_id')) {
      context.handle(
        _memberIdMeta,
        memberId.isAcceptableOrUnknown(data['member_id']!, _memberIdMeta),
      );
    } else if (isInserting) {
      context.missing(_memberIdMeta);
    }
    if (data.containsKey('tenant_name')) {
      context.handle(
        _tenantNameMeta,
        tenantName.isAcceptableOrUnknown(data['tenant_name']!, _tenantNameMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantNameMeta);
    }
    if (data.containsKey('tenant_phone')) {
      context.handle(
        _tenantPhoneMeta,
        tenantPhone.isAcceptableOrUnknown(
          data['tenant_phone']!,
          _tenantPhoneMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_tenantPhoneMeta);
    }
    if (data.containsKey('tenant_email')) {
      context.handle(
        _tenantEmailMeta,
        tenantEmail.isAcceptableOrUnknown(
          data['tenant_email']!,
          _tenantEmailMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_tenantEmailMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    } else if (isInserting) {
      context.missing(_endDateMeta);
    }
    if (data.containsKey('duration_months')) {
      context.handle(
        _durationMonthsMeta,
        durationMonths.isAcceptableOrUnknown(
          data['duration_months']!,
          _durationMonthsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationMonthsMeta);
    }
    if (data.containsKey('kos_price')) {
      context.handle(
        _kosPriceMeta,
        kosPrice.isAcceptableOrUnknown(data['kos_price']!, _kosPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_kosPriceMeta);
    }
    if (data.containsKey('subtotal')) {
      context.handle(
        _subtotalMeta,
        subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta),
      );
    } else if (isInserting) {
      context.missing(_subtotalMeta);
    }
    if (data.containsKey('admin_fee')) {
      context.handle(
        _adminFeeMeta,
        adminFee.isAcceptableOrUnknown(data['admin_fee']!, _adminFeeMeta),
      );
    }
    if (data.containsKey('total_amount')) {
      context.handle(
        _totalAmountMeta,
        totalAmount.isAcceptableOrUnknown(
          data['total_amount']!,
          _totalAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalAmountMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('rejection_reason')) {
      context.handle(
        _rejectionReasonMeta,
        rejectionReason.isAcceptableOrUnknown(
          data['rejection_reason']!,
          _rejectionReasonMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Booking map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Booking(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      bookingCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}booking_code'],
      )!,
      kosId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}kos_id'],
      )!,
      memberId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}member_id'],
      )!,
      tenantName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tenant_name'],
      )!,
      tenantPhone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tenant_phone'],
      )!,
      tenantEmail: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tenant_email'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}start_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}end_date'],
      )!,
      durationMonths: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_months'],
      )!,
      kosPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}kos_price'],
      )!,
      subtotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}subtotal'],
      )!,
      adminFee: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}admin_fee'],
      )!,
      totalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_amount'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      rejectionReason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rejection_reason'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $BookingsTable createAlias(String alias) {
    return $BookingsTable(attachedDatabase, alias);
  }
}

class Booking extends DataClass implements Insertable<Booking> {
  final int id;
  final String bookingCode;
  final int kosId;
  final int memberId;
  final String tenantName;
  final String tenantPhone;
  final String tenantEmail;
  final String startDate;
  final String endDate;
  final int durationMonths;
  final double kosPrice;
  final double subtotal;
  final double adminFee;
  final double totalAmount;
  final String? notes;
  final String status;
  final String? rejectionReason;
  final DateTime createdAt;
  const Booking({
    required this.id,
    required this.bookingCode,
    required this.kosId,
    required this.memberId,
    required this.tenantName,
    required this.tenantPhone,
    required this.tenantEmail,
    required this.startDate,
    required this.endDate,
    required this.durationMonths,
    required this.kosPrice,
    required this.subtotal,
    required this.adminFee,
    required this.totalAmount,
    this.notes,
    required this.status,
    this.rejectionReason,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['booking_code'] = Variable<String>(bookingCode);
    map['kos_id'] = Variable<int>(kosId);
    map['member_id'] = Variable<int>(memberId);
    map['tenant_name'] = Variable<String>(tenantName);
    map['tenant_phone'] = Variable<String>(tenantPhone);
    map['tenant_email'] = Variable<String>(tenantEmail);
    map['start_date'] = Variable<String>(startDate);
    map['end_date'] = Variable<String>(endDate);
    map['duration_months'] = Variable<int>(durationMonths);
    map['kos_price'] = Variable<double>(kosPrice);
    map['subtotal'] = Variable<double>(subtotal);
    map['admin_fee'] = Variable<double>(adminFee);
    map['total_amount'] = Variable<double>(totalAmount);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || rejectionReason != null) {
      map['rejection_reason'] = Variable<String>(rejectionReason);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BookingsCompanion toCompanion(bool nullToAbsent) {
    return BookingsCompanion(
      id: Value(id),
      bookingCode: Value(bookingCode),
      kosId: Value(kosId),
      memberId: Value(memberId),
      tenantName: Value(tenantName),
      tenantPhone: Value(tenantPhone),
      tenantEmail: Value(tenantEmail),
      startDate: Value(startDate),
      endDate: Value(endDate),
      durationMonths: Value(durationMonths),
      kosPrice: Value(kosPrice),
      subtotal: Value(subtotal),
      adminFee: Value(adminFee),
      totalAmount: Value(totalAmount),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      status: Value(status),
      rejectionReason: rejectionReason == null && nullToAbsent
          ? const Value.absent()
          : Value(rejectionReason),
      createdAt: Value(createdAt),
    );
  }

  factory Booking.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Booking(
      id: serializer.fromJson<int>(json['id']),
      bookingCode: serializer.fromJson<String>(json['bookingCode']),
      kosId: serializer.fromJson<int>(json['kosId']),
      memberId: serializer.fromJson<int>(json['memberId']),
      tenantName: serializer.fromJson<String>(json['tenantName']),
      tenantPhone: serializer.fromJson<String>(json['tenantPhone']),
      tenantEmail: serializer.fromJson<String>(json['tenantEmail']),
      startDate: serializer.fromJson<String>(json['startDate']),
      endDate: serializer.fromJson<String>(json['endDate']),
      durationMonths: serializer.fromJson<int>(json['durationMonths']),
      kosPrice: serializer.fromJson<double>(json['kosPrice']),
      subtotal: serializer.fromJson<double>(json['subtotal']),
      adminFee: serializer.fromJson<double>(json['adminFee']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
      notes: serializer.fromJson<String?>(json['notes']),
      status: serializer.fromJson<String>(json['status']),
      rejectionReason: serializer.fromJson<String?>(json['rejectionReason']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bookingCode': serializer.toJson<String>(bookingCode),
      'kosId': serializer.toJson<int>(kosId),
      'memberId': serializer.toJson<int>(memberId),
      'tenantName': serializer.toJson<String>(tenantName),
      'tenantPhone': serializer.toJson<String>(tenantPhone),
      'tenantEmail': serializer.toJson<String>(tenantEmail),
      'startDate': serializer.toJson<String>(startDate),
      'endDate': serializer.toJson<String>(endDate),
      'durationMonths': serializer.toJson<int>(durationMonths),
      'kosPrice': serializer.toJson<double>(kosPrice),
      'subtotal': serializer.toJson<double>(subtotal),
      'adminFee': serializer.toJson<double>(adminFee),
      'totalAmount': serializer.toJson<double>(totalAmount),
      'notes': serializer.toJson<String?>(notes),
      'status': serializer.toJson<String>(status),
      'rejectionReason': serializer.toJson<String?>(rejectionReason),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Booking copyWith({
    int? id,
    String? bookingCode,
    int? kosId,
    int? memberId,
    String? tenantName,
    String? tenantPhone,
    String? tenantEmail,
    String? startDate,
    String? endDate,
    int? durationMonths,
    double? kosPrice,
    double? subtotal,
    double? adminFee,
    double? totalAmount,
    Value<String?> notes = const Value.absent(),
    String? status,
    Value<String?> rejectionReason = const Value.absent(),
    DateTime? createdAt,
  }) => Booking(
    id: id ?? this.id,
    bookingCode: bookingCode ?? this.bookingCode,
    kosId: kosId ?? this.kosId,
    memberId: memberId ?? this.memberId,
    tenantName: tenantName ?? this.tenantName,
    tenantPhone: tenantPhone ?? this.tenantPhone,
    tenantEmail: tenantEmail ?? this.tenantEmail,
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
    durationMonths: durationMonths ?? this.durationMonths,
    kosPrice: kosPrice ?? this.kosPrice,
    subtotal: subtotal ?? this.subtotal,
    adminFee: adminFee ?? this.adminFee,
    totalAmount: totalAmount ?? this.totalAmount,
    notes: notes.present ? notes.value : this.notes,
    status: status ?? this.status,
    rejectionReason: rejectionReason.present
        ? rejectionReason.value
        : this.rejectionReason,
    createdAt: createdAt ?? this.createdAt,
  );
  Booking copyWithCompanion(BookingsCompanion data) {
    return Booking(
      id: data.id.present ? data.id.value : this.id,
      bookingCode: data.bookingCode.present
          ? data.bookingCode.value
          : this.bookingCode,
      kosId: data.kosId.present ? data.kosId.value : this.kosId,
      memberId: data.memberId.present ? data.memberId.value : this.memberId,
      tenantName: data.tenantName.present
          ? data.tenantName.value
          : this.tenantName,
      tenantPhone: data.tenantPhone.present
          ? data.tenantPhone.value
          : this.tenantPhone,
      tenantEmail: data.tenantEmail.present
          ? data.tenantEmail.value
          : this.tenantEmail,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      durationMonths: data.durationMonths.present
          ? data.durationMonths.value
          : this.durationMonths,
      kosPrice: data.kosPrice.present ? data.kosPrice.value : this.kosPrice,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
      adminFee: data.adminFee.present ? data.adminFee.value : this.adminFee,
      totalAmount: data.totalAmount.present
          ? data.totalAmount.value
          : this.totalAmount,
      notes: data.notes.present ? data.notes.value : this.notes,
      status: data.status.present ? data.status.value : this.status,
      rejectionReason: data.rejectionReason.present
          ? data.rejectionReason.value
          : this.rejectionReason,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Booking(')
          ..write('id: $id, ')
          ..write('bookingCode: $bookingCode, ')
          ..write('kosId: $kosId, ')
          ..write('memberId: $memberId, ')
          ..write('tenantName: $tenantName, ')
          ..write('tenantPhone: $tenantPhone, ')
          ..write('tenantEmail: $tenantEmail, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('durationMonths: $durationMonths, ')
          ..write('kosPrice: $kosPrice, ')
          ..write('subtotal: $subtotal, ')
          ..write('adminFee: $adminFee, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('rejectionReason: $rejectionReason, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    bookingCode,
    kosId,
    memberId,
    tenantName,
    tenantPhone,
    tenantEmail,
    startDate,
    endDate,
    durationMonths,
    kosPrice,
    subtotal,
    adminFee,
    totalAmount,
    notes,
    status,
    rejectionReason,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Booking &&
          other.id == this.id &&
          other.bookingCode == this.bookingCode &&
          other.kosId == this.kosId &&
          other.memberId == this.memberId &&
          other.tenantName == this.tenantName &&
          other.tenantPhone == this.tenantPhone &&
          other.tenantEmail == this.tenantEmail &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.durationMonths == this.durationMonths &&
          other.kosPrice == this.kosPrice &&
          other.subtotal == this.subtotal &&
          other.adminFee == this.adminFee &&
          other.totalAmount == this.totalAmount &&
          other.notes == this.notes &&
          other.status == this.status &&
          other.rejectionReason == this.rejectionReason &&
          other.createdAt == this.createdAt);
}

class BookingsCompanion extends UpdateCompanion<Booking> {
  final Value<int> id;
  final Value<String> bookingCode;
  final Value<int> kosId;
  final Value<int> memberId;
  final Value<String> tenantName;
  final Value<String> tenantPhone;
  final Value<String> tenantEmail;
  final Value<String> startDate;
  final Value<String> endDate;
  final Value<int> durationMonths;
  final Value<double> kosPrice;
  final Value<double> subtotal;
  final Value<double> adminFee;
  final Value<double> totalAmount;
  final Value<String?> notes;
  final Value<String> status;
  final Value<String?> rejectionReason;
  final Value<DateTime> createdAt;
  const BookingsCompanion({
    this.id = const Value.absent(),
    this.bookingCode = const Value.absent(),
    this.kosId = const Value.absent(),
    this.memberId = const Value.absent(),
    this.tenantName = const Value.absent(),
    this.tenantPhone = const Value.absent(),
    this.tenantEmail = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.durationMonths = const Value.absent(),
    this.kosPrice = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.adminFee = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.rejectionReason = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  BookingsCompanion.insert({
    this.id = const Value.absent(),
    required String bookingCode,
    required int kosId,
    required int memberId,
    required String tenantName,
    required String tenantPhone,
    required String tenantEmail,
    required String startDate,
    required String endDate,
    required int durationMonths,
    required double kosPrice,
    required double subtotal,
    this.adminFee = const Value.absent(),
    required double totalAmount,
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.rejectionReason = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : bookingCode = Value(bookingCode),
       kosId = Value(kosId),
       memberId = Value(memberId),
       tenantName = Value(tenantName),
       tenantPhone = Value(tenantPhone),
       tenantEmail = Value(tenantEmail),
       startDate = Value(startDate),
       endDate = Value(endDate),
       durationMonths = Value(durationMonths),
       kosPrice = Value(kosPrice),
       subtotal = Value(subtotal),
       totalAmount = Value(totalAmount);
  static Insertable<Booking> custom({
    Expression<int>? id,
    Expression<String>? bookingCode,
    Expression<int>? kosId,
    Expression<int>? memberId,
    Expression<String>? tenantName,
    Expression<String>? tenantPhone,
    Expression<String>? tenantEmail,
    Expression<String>? startDate,
    Expression<String>? endDate,
    Expression<int>? durationMonths,
    Expression<double>? kosPrice,
    Expression<double>? subtotal,
    Expression<double>? adminFee,
    Expression<double>? totalAmount,
    Expression<String>? notes,
    Expression<String>? status,
    Expression<String>? rejectionReason,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bookingCode != null) 'booking_code': bookingCode,
      if (kosId != null) 'kos_id': kosId,
      if (memberId != null) 'member_id': memberId,
      if (tenantName != null) 'tenant_name': tenantName,
      if (tenantPhone != null) 'tenant_phone': tenantPhone,
      if (tenantEmail != null) 'tenant_email': tenantEmail,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (durationMonths != null) 'duration_months': durationMonths,
      if (kosPrice != null) 'kos_price': kosPrice,
      if (subtotal != null) 'subtotal': subtotal,
      if (adminFee != null) 'admin_fee': adminFee,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (notes != null) 'notes': notes,
      if (status != null) 'status': status,
      if (rejectionReason != null) 'rejection_reason': rejectionReason,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  BookingsCompanion copyWith({
    Value<int>? id,
    Value<String>? bookingCode,
    Value<int>? kosId,
    Value<int>? memberId,
    Value<String>? tenantName,
    Value<String>? tenantPhone,
    Value<String>? tenantEmail,
    Value<String>? startDate,
    Value<String>? endDate,
    Value<int>? durationMonths,
    Value<double>? kosPrice,
    Value<double>? subtotal,
    Value<double>? adminFee,
    Value<double>? totalAmount,
    Value<String?>? notes,
    Value<String>? status,
    Value<String?>? rejectionReason,
    Value<DateTime>? createdAt,
  }) {
    return BookingsCompanion(
      id: id ?? this.id,
      bookingCode: bookingCode ?? this.bookingCode,
      kosId: kosId ?? this.kosId,
      memberId: memberId ?? this.memberId,
      tenantName: tenantName ?? this.tenantName,
      tenantPhone: tenantPhone ?? this.tenantPhone,
      tenantEmail: tenantEmail ?? this.tenantEmail,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      durationMonths: durationMonths ?? this.durationMonths,
      kosPrice: kosPrice ?? this.kosPrice,
      subtotal: subtotal ?? this.subtotal,
      adminFee: adminFee ?? this.adminFee,
      totalAmount: totalAmount ?? this.totalAmount,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bookingCode.present) {
      map['booking_code'] = Variable<String>(bookingCode.value);
    }
    if (kosId.present) {
      map['kos_id'] = Variable<int>(kosId.value);
    }
    if (memberId.present) {
      map['member_id'] = Variable<int>(memberId.value);
    }
    if (tenantName.present) {
      map['tenant_name'] = Variable<String>(tenantName.value);
    }
    if (tenantPhone.present) {
      map['tenant_phone'] = Variable<String>(tenantPhone.value);
    }
    if (tenantEmail.present) {
      map['tenant_email'] = Variable<String>(tenantEmail.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<String>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<String>(endDate.value);
    }
    if (durationMonths.present) {
      map['duration_months'] = Variable<int>(durationMonths.value);
    }
    if (kosPrice.present) {
      map['kos_price'] = Variable<double>(kosPrice.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<double>(subtotal.value);
    }
    if (adminFee.present) {
      map['admin_fee'] = Variable<double>(adminFee.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (rejectionReason.present) {
      map['rejection_reason'] = Variable<String>(rejectionReason.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookingsCompanion(')
          ..write('id: $id, ')
          ..write('bookingCode: $bookingCode, ')
          ..write('kosId: $kosId, ')
          ..write('memberId: $memberId, ')
          ..write('tenantName: $tenantName, ')
          ..write('tenantPhone: $tenantPhone, ')
          ..write('tenantEmail: $tenantEmail, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('durationMonths: $durationMonths, ')
          ..write('kosPrice: $kosPrice, ')
          ..write('subtotal: $subtotal, ')
          ..write('adminFee: $adminFee, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('rejectionReason: $rejectionReason, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $InvoicesTable extends Invoices with TableInfo<$InvoicesTable, Invoice> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _invoiceNumberMeta = const VerificationMeta(
    'invoiceNumber',
  );
  @override
  late final GeneratedColumn<String> invoiceNumber = GeneratedColumn<String>(
    'invoice_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _bookingIdMeta = const VerificationMeta(
    'bookingId',
  );
  @override
  late final GeneratedColumn<int> bookingId = GeneratedColumn<int>(
    'booking_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES bookings (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _memberIdMeta = const VerificationMeta(
    'memberId',
  );
  @override
  late final GeneratedColumn<int> memberId = GeneratedColumn<int>(
    'member_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _kosIdMeta = const VerificationMeta('kosId');
  @override
  late final GeneratedColumn<int> kosId = GeneratedColumn<int>(
    'kos_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES kos (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _adminFeeMeta = const VerificationMeta(
    'adminFee',
  );
  @override
  late final GeneratedColumn<double> adminFee = GeneratedColumn<double>(
    'admin_fee',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(25000.0),
  );
  static const VerificationMeta _totalAmountMeta = const VerificationMeta(
    'totalAmount',
  );
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
    'total_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<String> dueDate = GeneratedColumn<String>(
    'due_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paidAtMeta = const VerificationMeta('paidAt');
  @override
  late final GeneratedColumn<DateTime> paidAt = GeneratedColumn<DateTime>(
    'paid_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('unpaid'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    invoiceNumber,
    bookingId,
    memberId,
    kosId,
    amount,
    adminFee,
    totalAmount,
    dueDate,
    paidAt,
    paymentMethod,
    status,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoices';
  @override
  VerificationContext validateIntegrity(
    Insertable<Invoice> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('invoice_number')) {
      context.handle(
        _invoiceNumberMeta,
        invoiceNumber.isAcceptableOrUnknown(
          data['invoice_number']!,
          _invoiceNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_invoiceNumberMeta);
    }
    if (data.containsKey('booking_id')) {
      context.handle(
        _bookingIdMeta,
        bookingId.isAcceptableOrUnknown(data['booking_id']!, _bookingIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bookingIdMeta);
    }
    if (data.containsKey('member_id')) {
      context.handle(
        _memberIdMeta,
        memberId.isAcceptableOrUnknown(data['member_id']!, _memberIdMeta),
      );
    } else if (isInserting) {
      context.missing(_memberIdMeta);
    }
    if (data.containsKey('kos_id')) {
      context.handle(
        _kosIdMeta,
        kosId.isAcceptableOrUnknown(data['kos_id']!, _kosIdMeta),
      );
    } else if (isInserting) {
      context.missing(_kosIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('admin_fee')) {
      context.handle(
        _adminFeeMeta,
        adminFee.isAcceptableOrUnknown(data['admin_fee']!, _adminFeeMeta),
      );
    }
    if (data.containsKey('total_amount')) {
      context.handle(
        _totalAmountMeta,
        totalAmount.isAcceptableOrUnknown(
          data['total_amount']!,
          _totalAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalAmountMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    } else if (isInserting) {
      context.missing(_dueDateMeta);
    }
    if (data.containsKey('paid_at')) {
      context.handle(
        _paidAtMeta,
        paidAt.isAcceptableOrUnknown(data['paid_at']!, _paidAtMeta),
      );
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Invoice map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Invoice(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      invoiceNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_number'],
      )!,
      bookingId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}booking_id'],
      )!,
      memberId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}member_id'],
      )!,
      kosId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}kos_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      adminFee: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}admin_fee'],
      )!,
      totalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_amount'],
      )!,
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}due_date'],
      )!,
      paidAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}paid_at'],
      ),
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $InvoicesTable createAlias(String alias) {
    return $InvoicesTable(attachedDatabase, alias);
  }
}

class Invoice extends DataClass implements Insertable<Invoice> {
  final int id;
  final String invoiceNumber;
  final int bookingId;
  final int memberId;
  final int kosId;
  final double amount;
  final double adminFee;
  final double totalAmount;
  final String dueDate;
  final DateTime? paidAt;
  final String? paymentMethod;
  final String status;
  final DateTime createdAt;
  const Invoice({
    required this.id,
    required this.invoiceNumber,
    required this.bookingId,
    required this.memberId,
    required this.kosId,
    required this.amount,
    required this.adminFee,
    required this.totalAmount,
    required this.dueDate,
    this.paidAt,
    this.paymentMethod,
    required this.status,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['invoice_number'] = Variable<String>(invoiceNumber);
    map['booking_id'] = Variable<int>(bookingId);
    map['member_id'] = Variable<int>(memberId);
    map['kos_id'] = Variable<int>(kosId);
    map['amount'] = Variable<double>(amount);
    map['admin_fee'] = Variable<double>(adminFee);
    map['total_amount'] = Variable<double>(totalAmount);
    map['due_date'] = Variable<String>(dueDate);
    if (!nullToAbsent || paidAt != null) {
      map['paid_at'] = Variable<DateTime>(paidAt);
    }
    if (!nullToAbsent || paymentMethod != null) {
      map['payment_method'] = Variable<String>(paymentMethod);
    }
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  InvoicesCompanion toCompanion(bool nullToAbsent) {
    return InvoicesCompanion(
      id: Value(id),
      invoiceNumber: Value(invoiceNumber),
      bookingId: Value(bookingId),
      memberId: Value(memberId),
      kosId: Value(kosId),
      amount: Value(amount),
      adminFee: Value(adminFee),
      totalAmount: Value(totalAmount),
      dueDate: Value(dueDate),
      paidAt: paidAt == null && nullToAbsent
          ? const Value.absent()
          : Value(paidAt),
      paymentMethod: paymentMethod == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentMethod),
      status: Value(status),
      createdAt: Value(createdAt),
    );
  }

  factory Invoice.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Invoice(
      id: serializer.fromJson<int>(json['id']),
      invoiceNumber: serializer.fromJson<String>(json['invoiceNumber']),
      bookingId: serializer.fromJson<int>(json['bookingId']),
      memberId: serializer.fromJson<int>(json['memberId']),
      kosId: serializer.fromJson<int>(json['kosId']),
      amount: serializer.fromJson<double>(json['amount']),
      adminFee: serializer.fromJson<double>(json['adminFee']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
      dueDate: serializer.fromJson<String>(json['dueDate']),
      paidAt: serializer.fromJson<DateTime?>(json['paidAt']),
      paymentMethod: serializer.fromJson<String?>(json['paymentMethod']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'invoiceNumber': serializer.toJson<String>(invoiceNumber),
      'bookingId': serializer.toJson<int>(bookingId),
      'memberId': serializer.toJson<int>(memberId),
      'kosId': serializer.toJson<int>(kosId),
      'amount': serializer.toJson<double>(amount),
      'adminFee': serializer.toJson<double>(adminFee),
      'totalAmount': serializer.toJson<double>(totalAmount),
      'dueDate': serializer.toJson<String>(dueDate),
      'paidAt': serializer.toJson<DateTime?>(paidAt),
      'paymentMethod': serializer.toJson<String?>(paymentMethod),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Invoice copyWith({
    int? id,
    String? invoiceNumber,
    int? bookingId,
    int? memberId,
    int? kosId,
    double? amount,
    double? adminFee,
    double? totalAmount,
    String? dueDate,
    Value<DateTime?> paidAt = const Value.absent(),
    Value<String?> paymentMethod = const Value.absent(),
    String? status,
    DateTime? createdAt,
  }) => Invoice(
    id: id ?? this.id,
    invoiceNumber: invoiceNumber ?? this.invoiceNumber,
    bookingId: bookingId ?? this.bookingId,
    memberId: memberId ?? this.memberId,
    kosId: kosId ?? this.kosId,
    amount: amount ?? this.amount,
    adminFee: adminFee ?? this.adminFee,
    totalAmount: totalAmount ?? this.totalAmount,
    dueDate: dueDate ?? this.dueDate,
    paidAt: paidAt.present ? paidAt.value : this.paidAt,
    paymentMethod: paymentMethod.present
        ? paymentMethod.value
        : this.paymentMethod,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
  );
  Invoice copyWithCompanion(InvoicesCompanion data) {
    return Invoice(
      id: data.id.present ? data.id.value : this.id,
      invoiceNumber: data.invoiceNumber.present
          ? data.invoiceNumber.value
          : this.invoiceNumber,
      bookingId: data.bookingId.present ? data.bookingId.value : this.bookingId,
      memberId: data.memberId.present ? data.memberId.value : this.memberId,
      kosId: data.kosId.present ? data.kosId.value : this.kosId,
      amount: data.amount.present ? data.amount.value : this.amount,
      adminFee: data.adminFee.present ? data.adminFee.value : this.adminFee,
      totalAmount: data.totalAmount.present
          ? data.totalAmount.value
          : this.totalAmount,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      paidAt: data.paidAt.present ? data.paidAt.value : this.paidAt,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Invoice(')
          ..write('id: $id, ')
          ..write('invoiceNumber: $invoiceNumber, ')
          ..write('bookingId: $bookingId, ')
          ..write('memberId: $memberId, ')
          ..write('kosId: $kosId, ')
          ..write('amount: $amount, ')
          ..write('adminFee: $adminFee, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('dueDate: $dueDate, ')
          ..write('paidAt: $paidAt, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    invoiceNumber,
    bookingId,
    memberId,
    kosId,
    amount,
    adminFee,
    totalAmount,
    dueDate,
    paidAt,
    paymentMethod,
    status,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Invoice &&
          other.id == this.id &&
          other.invoiceNumber == this.invoiceNumber &&
          other.bookingId == this.bookingId &&
          other.memberId == this.memberId &&
          other.kosId == this.kosId &&
          other.amount == this.amount &&
          other.adminFee == this.adminFee &&
          other.totalAmount == this.totalAmount &&
          other.dueDate == this.dueDate &&
          other.paidAt == this.paidAt &&
          other.paymentMethod == this.paymentMethod &&
          other.status == this.status &&
          other.createdAt == this.createdAt);
}

class InvoicesCompanion extends UpdateCompanion<Invoice> {
  final Value<int> id;
  final Value<String> invoiceNumber;
  final Value<int> bookingId;
  final Value<int> memberId;
  final Value<int> kosId;
  final Value<double> amount;
  final Value<double> adminFee;
  final Value<double> totalAmount;
  final Value<String> dueDate;
  final Value<DateTime?> paidAt;
  final Value<String?> paymentMethod;
  final Value<String> status;
  final Value<DateTime> createdAt;
  const InvoicesCompanion({
    this.id = const Value.absent(),
    this.invoiceNumber = const Value.absent(),
    this.bookingId = const Value.absent(),
    this.memberId = const Value.absent(),
    this.kosId = const Value.absent(),
    this.amount = const Value.absent(),
    this.adminFee = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.paidAt = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  InvoicesCompanion.insert({
    this.id = const Value.absent(),
    required String invoiceNumber,
    required int bookingId,
    required int memberId,
    required int kosId,
    required double amount,
    this.adminFee = const Value.absent(),
    required double totalAmount,
    required String dueDate,
    this.paidAt = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : invoiceNumber = Value(invoiceNumber),
       bookingId = Value(bookingId),
       memberId = Value(memberId),
       kosId = Value(kosId),
       amount = Value(amount),
       totalAmount = Value(totalAmount),
       dueDate = Value(dueDate);
  static Insertable<Invoice> custom({
    Expression<int>? id,
    Expression<String>? invoiceNumber,
    Expression<int>? bookingId,
    Expression<int>? memberId,
    Expression<int>? kosId,
    Expression<double>? amount,
    Expression<double>? adminFee,
    Expression<double>? totalAmount,
    Expression<String>? dueDate,
    Expression<DateTime>? paidAt,
    Expression<String>? paymentMethod,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoiceNumber != null) 'invoice_number': invoiceNumber,
      if (bookingId != null) 'booking_id': bookingId,
      if (memberId != null) 'member_id': memberId,
      if (kosId != null) 'kos_id': kosId,
      if (amount != null) 'amount': amount,
      if (adminFee != null) 'admin_fee': adminFee,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (dueDate != null) 'due_date': dueDate,
      if (paidAt != null) 'paid_at': paidAt,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  InvoicesCompanion copyWith({
    Value<int>? id,
    Value<String>? invoiceNumber,
    Value<int>? bookingId,
    Value<int>? memberId,
    Value<int>? kosId,
    Value<double>? amount,
    Value<double>? adminFee,
    Value<double>? totalAmount,
    Value<String>? dueDate,
    Value<DateTime?>? paidAt,
    Value<String?>? paymentMethod,
    Value<String>? status,
    Value<DateTime>? createdAt,
  }) {
    return InvoicesCompanion(
      id: id ?? this.id,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      bookingId: bookingId ?? this.bookingId,
      memberId: memberId ?? this.memberId,
      kosId: kosId ?? this.kosId,
      amount: amount ?? this.amount,
      adminFee: adminFee ?? this.adminFee,
      totalAmount: totalAmount ?? this.totalAmount,
      dueDate: dueDate ?? this.dueDate,
      paidAt: paidAt ?? this.paidAt,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (invoiceNumber.present) {
      map['invoice_number'] = Variable<String>(invoiceNumber.value);
    }
    if (bookingId.present) {
      map['booking_id'] = Variable<int>(bookingId.value);
    }
    if (memberId.present) {
      map['member_id'] = Variable<int>(memberId.value);
    }
    if (kosId.present) {
      map['kos_id'] = Variable<int>(kosId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (adminFee.present) {
      map['admin_fee'] = Variable<double>(adminFee.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<String>(dueDate.value);
    }
    if (paidAt.present) {
      map['paid_at'] = Variable<DateTime>(paidAt.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoicesCompanion(')
          ..write('id: $id, ')
          ..write('invoiceNumber: $invoiceNumber, ')
          ..write('bookingId: $bookingId, ')
          ..write('memberId: $memberId, ')
          ..write('kosId: $kosId, ')
          ..write('amount: $amount, ')
          ..write('adminFee: $adminFee, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('dueDate: $dueDate, ')
          ..write('paidAt: $paidAt, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ReviewsTable extends Reviews with TableInfo<$ReviewsTable, Review> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReviewsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _kosIdMeta = const VerificationMeta('kosId');
  @override
  late final GeneratedColumn<int> kosId = GeneratedColumn<int>(
    'kos_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES kos (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _memberIdMeta = const VerificationMeta(
    'memberId',
  );
  @override
  late final GeneratedColumn<int> memberId = GeneratedColumn<int>(
    'member_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _reviewerNameMeta = const VerificationMeta(
    'reviewerName',
  );
  @override
  late final GeneratedColumn<String> reviewerName = GeneratedColumn<String>(
    'reviewer_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<int> rating = GeneratedColumn<int>(
    'rating',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _commentMeta = const VerificationMeta(
    'comment',
  );
  @override
  late final GeneratedColumn<String> comment = GeneratedColumn<String>(
    'comment',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ownerReplyMeta = const VerificationMeta(
    'ownerReply',
  );
  @override
  late final GeneratedColumn<String> ownerReply = GeneratedColumn<String>(
    'owner_reply',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    kosId,
    memberId,
    reviewerName,
    rating,
    comment,
    ownerReply,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reviews';
  @override
  VerificationContext validateIntegrity(
    Insertable<Review> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('kos_id')) {
      context.handle(
        _kosIdMeta,
        kosId.isAcceptableOrUnknown(data['kos_id']!, _kosIdMeta),
      );
    } else if (isInserting) {
      context.missing(_kosIdMeta);
    }
    if (data.containsKey('member_id')) {
      context.handle(
        _memberIdMeta,
        memberId.isAcceptableOrUnknown(data['member_id']!, _memberIdMeta),
      );
    } else if (isInserting) {
      context.missing(_memberIdMeta);
    }
    if (data.containsKey('reviewer_name')) {
      context.handle(
        _reviewerNameMeta,
        reviewerName.isAcceptableOrUnknown(
          data['reviewer_name']!,
          _reviewerNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_reviewerNameMeta);
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    } else if (isInserting) {
      context.missing(_ratingMeta);
    }
    if (data.containsKey('comment')) {
      context.handle(
        _commentMeta,
        comment.isAcceptableOrUnknown(data['comment']!, _commentMeta),
      );
    } else if (isInserting) {
      context.missing(_commentMeta);
    }
    if (data.containsKey('owner_reply')) {
      context.handle(
        _ownerReplyMeta,
        ownerReply.isAcceptableOrUnknown(data['owner_reply']!, _ownerReplyMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {kosId, memberId},
  ];
  @override
  Review map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Review(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      kosId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}kos_id'],
      )!,
      memberId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}member_id'],
      )!,
      reviewerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reviewer_name'],
      )!,
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rating'],
      )!,
      comment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}comment'],
      )!,
      ownerReply: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_reply'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ReviewsTable createAlias(String alias) {
    return $ReviewsTable(attachedDatabase, alias);
  }
}

class Review extends DataClass implements Insertable<Review> {
  final int id;
  final int kosId;
  final int memberId;
  final String reviewerName;
  final int rating;
  final String comment;
  final String? ownerReply;
  final DateTime createdAt;
  const Review({
    required this.id,
    required this.kosId,
    required this.memberId,
    required this.reviewerName,
    required this.rating,
    required this.comment,
    this.ownerReply,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['kos_id'] = Variable<int>(kosId);
    map['member_id'] = Variable<int>(memberId);
    map['reviewer_name'] = Variable<String>(reviewerName);
    map['rating'] = Variable<int>(rating);
    map['comment'] = Variable<String>(comment);
    if (!nullToAbsent || ownerReply != null) {
      map['owner_reply'] = Variable<String>(ownerReply);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ReviewsCompanion toCompanion(bool nullToAbsent) {
    return ReviewsCompanion(
      id: Value(id),
      kosId: Value(kosId),
      memberId: Value(memberId),
      reviewerName: Value(reviewerName),
      rating: Value(rating),
      comment: Value(comment),
      ownerReply: ownerReply == null && nullToAbsent
          ? const Value.absent()
          : Value(ownerReply),
      createdAt: Value(createdAt),
    );
  }

  factory Review.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Review(
      id: serializer.fromJson<int>(json['id']),
      kosId: serializer.fromJson<int>(json['kosId']),
      memberId: serializer.fromJson<int>(json['memberId']),
      reviewerName: serializer.fromJson<String>(json['reviewerName']),
      rating: serializer.fromJson<int>(json['rating']),
      comment: serializer.fromJson<String>(json['comment']),
      ownerReply: serializer.fromJson<String?>(json['ownerReply']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'kosId': serializer.toJson<int>(kosId),
      'memberId': serializer.toJson<int>(memberId),
      'reviewerName': serializer.toJson<String>(reviewerName),
      'rating': serializer.toJson<int>(rating),
      'comment': serializer.toJson<String>(comment),
      'ownerReply': serializer.toJson<String?>(ownerReply),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Review copyWith({
    int? id,
    int? kosId,
    int? memberId,
    String? reviewerName,
    int? rating,
    String? comment,
    Value<String?> ownerReply = const Value.absent(),
    DateTime? createdAt,
  }) => Review(
    id: id ?? this.id,
    kosId: kosId ?? this.kosId,
    memberId: memberId ?? this.memberId,
    reviewerName: reviewerName ?? this.reviewerName,
    rating: rating ?? this.rating,
    comment: comment ?? this.comment,
    ownerReply: ownerReply.present ? ownerReply.value : this.ownerReply,
    createdAt: createdAt ?? this.createdAt,
  );
  Review copyWithCompanion(ReviewsCompanion data) {
    return Review(
      id: data.id.present ? data.id.value : this.id,
      kosId: data.kosId.present ? data.kosId.value : this.kosId,
      memberId: data.memberId.present ? data.memberId.value : this.memberId,
      reviewerName: data.reviewerName.present
          ? data.reviewerName.value
          : this.reviewerName,
      rating: data.rating.present ? data.rating.value : this.rating,
      comment: data.comment.present ? data.comment.value : this.comment,
      ownerReply: data.ownerReply.present
          ? data.ownerReply.value
          : this.ownerReply,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Review(')
          ..write('id: $id, ')
          ..write('kosId: $kosId, ')
          ..write('memberId: $memberId, ')
          ..write('reviewerName: $reviewerName, ')
          ..write('rating: $rating, ')
          ..write('comment: $comment, ')
          ..write('ownerReply: $ownerReply, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    kosId,
    memberId,
    reviewerName,
    rating,
    comment,
    ownerReply,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Review &&
          other.id == this.id &&
          other.kosId == this.kosId &&
          other.memberId == this.memberId &&
          other.reviewerName == this.reviewerName &&
          other.rating == this.rating &&
          other.comment == this.comment &&
          other.ownerReply == this.ownerReply &&
          other.createdAt == this.createdAt);
}

class ReviewsCompanion extends UpdateCompanion<Review> {
  final Value<int> id;
  final Value<int> kosId;
  final Value<int> memberId;
  final Value<String> reviewerName;
  final Value<int> rating;
  final Value<String> comment;
  final Value<String?> ownerReply;
  final Value<DateTime> createdAt;
  const ReviewsCompanion({
    this.id = const Value.absent(),
    this.kosId = const Value.absent(),
    this.memberId = const Value.absent(),
    this.reviewerName = const Value.absent(),
    this.rating = const Value.absent(),
    this.comment = const Value.absent(),
    this.ownerReply = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ReviewsCompanion.insert({
    this.id = const Value.absent(),
    required int kosId,
    required int memberId,
    required String reviewerName,
    required int rating,
    required String comment,
    this.ownerReply = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : kosId = Value(kosId),
       memberId = Value(memberId),
       reviewerName = Value(reviewerName),
       rating = Value(rating),
       comment = Value(comment);
  static Insertable<Review> custom({
    Expression<int>? id,
    Expression<int>? kosId,
    Expression<int>? memberId,
    Expression<String>? reviewerName,
    Expression<int>? rating,
    Expression<String>? comment,
    Expression<String>? ownerReply,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kosId != null) 'kos_id': kosId,
      if (memberId != null) 'member_id': memberId,
      if (reviewerName != null) 'reviewer_name': reviewerName,
      if (rating != null) 'rating': rating,
      if (comment != null) 'comment': comment,
      if (ownerReply != null) 'owner_reply': ownerReply,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ReviewsCompanion copyWith({
    Value<int>? id,
    Value<int>? kosId,
    Value<int>? memberId,
    Value<String>? reviewerName,
    Value<int>? rating,
    Value<String>? comment,
    Value<String?>? ownerReply,
    Value<DateTime>? createdAt,
  }) {
    return ReviewsCompanion(
      id: id ?? this.id,
      kosId: kosId ?? this.kosId,
      memberId: memberId ?? this.memberId,
      reviewerName: reviewerName ?? this.reviewerName,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      ownerReply: ownerReply ?? this.ownerReply,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (kosId.present) {
      map['kos_id'] = Variable<int>(kosId.value);
    }
    if (memberId.present) {
      map['member_id'] = Variable<int>(memberId.value);
    }
    if (reviewerName.present) {
      map['reviewer_name'] = Variable<String>(reviewerName.value);
    }
    if (rating.present) {
      map['rating'] = Variable<int>(rating.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
    }
    if (ownerReply.present) {
      map['owner_reply'] = Variable<String>(ownerReply.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviewsCompanion(')
          ..write('id: $id, ')
          ..write('kosId: $kosId, ')
          ..write('memberId: $memberId, ')
          ..write('reviewerName: $reviewerName, ')
          ..write('rating: $rating, ')
          ..write('comment: $comment, ')
          ..write('ownerReply: $ownerReply, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $AppNotificationsTable extends AppNotifications
    with TableInfo<$AppNotificationsTable, AppNotification> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppNotificationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _messageMeta = const VerificationMeta(
    'message',
  );
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
    'message',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('system'),
  );
  static const VerificationMeta _isReadMeta = const VerificationMeta('isRead');
  @override
  late final GeneratedColumn<bool> isRead = GeneratedColumn<bool>(
    'is_read',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_read" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    title,
    message,
    category,
    isRead,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notifications';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppNotification> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('message')) {
      context.handle(
        _messageMeta,
        message.isAcceptableOrUnknown(data['message']!, _messageMeta),
      );
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('is_read')) {
      context.handle(
        _isReadMeta,
        isRead.isAcceptableOrUnknown(data['is_read']!, _isReadMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppNotification map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppNotification(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      message: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      isRead: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_read'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AppNotificationsTable createAlias(String alias) {
    return $AppNotificationsTable(attachedDatabase, alias);
  }
}

class AppNotification extends DataClass implements Insertable<AppNotification> {
  final int id;
  final int userId;
  final String title;
  final String message;
  final String category;
  final bool isRead;
  final DateTime createdAt;
  const AppNotification({
    required this.id,
    required this.userId,
    required this.title,
    required this.message,
    required this.category,
    required this.isRead,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['title'] = Variable<String>(title);
    map['message'] = Variable<String>(message);
    map['category'] = Variable<String>(category);
    map['is_read'] = Variable<bool>(isRead);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AppNotificationsCompanion toCompanion(bool nullToAbsent) {
    return AppNotificationsCompanion(
      id: Value(id),
      userId: Value(userId),
      title: Value(title),
      message: Value(message),
      category: Value(category),
      isRead: Value(isRead),
      createdAt: Value(createdAt),
    );
  }

  factory AppNotification.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppNotification(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      title: serializer.fromJson<String>(json['title']),
      message: serializer.fromJson<String>(json['message']),
      category: serializer.fromJson<String>(json['category']),
      isRead: serializer.fromJson<bool>(json['isRead']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'title': serializer.toJson<String>(title),
      'message': serializer.toJson<String>(message),
      'category': serializer.toJson<String>(category),
      'isRead': serializer.toJson<bool>(isRead),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AppNotification copyWith({
    int? id,
    int? userId,
    String? title,
    String? message,
    String? category,
    bool? isRead,
    DateTime? createdAt,
  }) => AppNotification(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    title: title ?? this.title,
    message: message ?? this.message,
    category: category ?? this.category,
    isRead: isRead ?? this.isRead,
    createdAt: createdAt ?? this.createdAt,
  );
  AppNotification copyWithCompanion(AppNotificationsCompanion data) {
    return AppNotification(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      title: data.title.present ? data.title.value : this.title,
      message: data.message.present ? data.message.value : this.message,
      category: data.category.present ? data.category.value : this.category,
      isRead: data.isRead.present ? data.isRead.value : this.isRead,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppNotification(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('title: $title, ')
          ..write('message: $message, ')
          ..write('category: $category, ')
          ..write('isRead: $isRead, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, title, message, category, isRead, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppNotification &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.title == this.title &&
          other.message == this.message &&
          other.category == this.category &&
          other.isRead == this.isRead &&
          other.createdAt == this.createdAt);
}

class AppNotificationsCompanion extends UpdateCompanion<AppNotification> {
  final Value<int> id;
  final Value<int> userId;
  final Value<String> title;
  final Value<String> message;
  final Value<String> category;
  final Value<bool> isRead;
  final Value<DateTime> createdAt;
  const AppNotificationsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.title = const Value.absent(),
    this.message = const Value.absent(),
    this.category = const Value.absent(),
    this.isRead = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  AppNotificationsCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required String title,
    required String message,
    this.category = const Value.absent(),
    this.isRead = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : userId = Value(userId),
       title = Value(title),
       message = Value(message);
  static Insertable<AppNotification> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<String>? title,
    Expression<String>? message,
    Expression<String>? category,
    Expression<bool>? isRead,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (title != null) 'title': title,
      if (message != null) 'message': message,
      if (category != null) 'category': category,
      if (isRead != null) 'is_read': isRead,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  AppNotificationsCompanion copyWith({
    Value<int>? id,
    Value<int>? userId,
    Value<String>? title,
    Value<String>? message,
    Value<String>? category,
    Value<bool>? isRead,
    Value<DateTime>? createdAt,
  }) {
    return AppNotificationsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      message: message ?? this.message,
      category: category ?? this.category,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (isRead.present) {
      map['is_read'] = Variable<bool>(isRead.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppNotificationsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('title: $title, ')
          ..write('message: $message, ')
          ..write('category: $category, ')
          ..write('isRead: $isRead, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $FavoritesTable extends Favorites
    with TableInfo<$FavoritesTable, Favorite> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoritesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _memberIdMeta = const VerificationMeta(
    'memberId',
  );
  @override
  late final GeneratedColumn<int> memberId = GeneratedColumn<int>(
    'member_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _kosIdMeta = const VerificationMeta('kosId');
  @override
  late final GeneratedColumn<int> kosId = GeneratedColumn<int>(
    'kos_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES kos (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [memberId, kosId, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorites';
  @override
  VerificationContext validateIntegrity(
    Insertable<Favorite> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('member_id')) {
      context.handle(
        _memberIdMeta,
        memberId.isAcceptableOrUnknown(data['member_id']!, _memberIdMeta),
      );
    } else if (isInserting) {
      context.missing(_memberIdMeta);
    }
    if (data.containsKey('kos_id')) {
      context.handle(
        _kosIdMeta,
        kosId.isAcceptableOrUnknown(data['kos_id']!, _kosIdMeta),
      );
    } else if (isInserting) {
      context.missing(_kosIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {memberId, kosId};
  @override
  Favorite map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Favorite(
      memberId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}member_id'],
      )!,
      kosId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}kos_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $FavoritesTable createAlias(String alias) {
    return $FavoritesTable(attachedDatabase, alias);
  }
}

class Favorite extends DataClass implements Insertable<Favorite> {
  final int memberId;
  final int kosId;
  final DateTime createdAt;
  const Favorite({
    required this.memberId,
    required this.kosId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['member_id'] = Variable<int>(memberId);
    map['kos_id'] = Variable<int>(kosId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FavoritesCompanion toCompanion(bool nullToAbsent) {
    return FavoritesCompanion(
      memberId: Value(memberId),
      kosId: Value(kosId),
      createdAt: Value(createdAt),
    );
  }

  factory Favorite.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Favorite(
      memberId: serializer.fromJson<int>(json['memberId']),
      kosId: serializer.fromJson<int>(json['kosId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'memberId': serializer.toJson<int>(memberId),
      'kosId': serializer.toJson<int>(kosId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Favorite copyWith({int? memberId, int? kosId, DateTime? createdAt}) =>
      Favorite(
        memberId: memberId ?? this.memberId,
        kosId: kosId ?? this.kosId,
        createdAt: createdAt ?? this.createdAt,
      );
  Favorite copyWithCompanion(FavoritesCompanion data) {
    return Favorite(
      memberId: data.memberId.present ? data.memberId.value : this.memberId,
      kosId: data.kosId.present ? data.kosId.value : this.kosId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Favorite(')
          ..write('memberId: $memberId, ')
          ..write('kosId: $kosId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(memberId, kosId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Favorite &&
          other.memberId == this.memberId &&
          other.kosId == this.kosId &&
          other.createdAt == this.createdAt);
}

class FavoritesCompanion extends UpdateCompanion<Favorite> {
  final Value<int> memberId;
  final Value<int> kosId;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const FavoritesCompanion({
    this.memberId = const Value.absent(),
    this.kosId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FavoritesCompanion.insert({
    required int memberId,
    required int kosId,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : memberId = Value(memberId),
       kosId = Value(kosId);
  static Insertable<Favorite> custom({
    Expression<int>? memberId,
    Expression<int>? kosId,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (memberId != null) 'member_id': memberId,
      if (kosId != null) 'kos_id': kosId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FavoritesCompanion copyWith({
    Value<int>? memberId,
    Value<int>? kosId,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return FavoritesCompanion(
      memberId: memberId ?? this.memberId,
      kosId: kosId ?? this.kosId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (memberId.present) {
      map['member_id'] = Variable<int>(memberId.value);
    }
    if (kosId.present) {
      map['kos_id'] = Variable<int>(kosId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoritesCompanion(')
          ..write('memberId: $memberId, ')
          ..write('kosId: $kosId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $UserProfilesTable userProfiles = $UserProfilesTable(this);
  late final $KosPropertiesTable kosProperties = $KosPropertiesTable(this);
  late final $KosImagesTable kosImages = $KosImagesTable(this);
  late final $FacilitiesTable facilities = $FacilitiesTable(this);
  late final $KosFacilitiesTable kosFacilities = $KosFacilitiesTable(this);
  late final $BookingsTable bookings = $BookingsTable(this);
  late final $InvoicesTable invoices = $InvoicesTable(this);
  late final $ReviewsTable reviews = $ReviewsTable(this);
  late final $AppNotificationsTable appNotifications = $AppNotificationsTable(
    this,
  );
  late final $FavoritesTable favorites = $FavoritesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    users,
    userProfiles,
    kosProperties,
    kosImages,
    facilities,
    kosFacilities,
    bookings,
    invoices,
    reviews,
    appNotifications,
    favorites,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('user_profiles', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('kos', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'kos',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('kos_images', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'kos',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('kos_facilities', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'facilities',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('kos_facilities', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'kos',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('bookings', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('bookings', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'bookings',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('invoices', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('invoices', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'kos',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('invoices', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'kos',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('reviews', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('reviews', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('notifications', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('favorites', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'kos',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('favorites', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  required String name,
  required String email,
  required String passwordHash,
  required String passwordSalt,
  Value<String> role,
  Value<DateTime> createdAt,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> email,
  Value<String> passwordHash,
  Value<String> passwordSalt,
  Value<String> role,
  Value<DateTime> createdAt,
});

final class $$UsersTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTable, User> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UserProfilesTable, List<UserProfile>>
  _userProfilesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.userProfiles,
    aliasName: 'users__id__user_profiles__user_id',
  );

  $$UserProfilesTableProcessedTableManager get userProfilesRefs {
    final manager = $$UserProfilesTableTableManager(
      $_db,
      $_db.userProfiles,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_userProfilesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$KosPropertiesTable, List<KosProperty>>
  _kosPropertiesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.kosProperties,
    aliasName: 'users__id__kos__owner_id',
  );

  $$KosPropertiesTableProcessedTableManager get kosPropertiesRefs {
    final manager = $$KosPropertiesTableTableManager(
      $_db,
      $_db.kosProperties,
    ).filter((f) => f.ownerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_kosPropertiesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$BookingsTable, List<Booking>> _bookingsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.bookings,
    aliasName: 'users__id__bookings__member_id',
  );

  $$BookingsTableProcessedTableManager get bookingsRefs {
    final manager = $$BookingsTableTableManager(
      $_db,
      $_db.bookings,
    ).filter((f) => f.memberId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_bookingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$InvoicesTable, List<Invoice>> _invoicesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.invoices,
    aliasName: 'users__id__invoices__member_id',
  );

  $$InvoicesTableProcessedTableManager get invoicesRefs {
    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.memberId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_invoicesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ReviewsTable, List<Review>> _reviewsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.reviews,
    aliasName: 'users__id__reviews__member_id',
  );

  $$ReviewsTableProcessedTableManager get reviewsRefs {
    final manager = $$ReviewsTableTableManager(
      $_db,
      $_db.reviews,
    ).filter((f) => f.memberId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_reviewsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AppNotificationsTable, List<AppNotification>>
  _appNotificationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.appNotifications,
    aliasName: 'users__id__notifications__user_id',
  );

  $$AppNotificationsTableProcessedTableManager get appNotificationsRefs {
    final manager = $$AppNotificationsTableTableManager(
      $_db,
      $_db.appNotifications,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _appNotificationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FavoritesTable, List<Favorite>>
  _favoritesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.favorites,
    aliasName: 'users__id__favorites__member_id',
  );

  $$FavoritesTableProcessedTableManager get favoritesRefs {
    final manager = $$FavoritesTableTableManager(
      $_db,
      $_db.favorites,
    ).filter((f) => f.memberId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_favoritesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get passwordSalt => $composableBuilder(
    column: $table.passwordSalt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> userProfilesRefs(
    Expression<bool> Function($$UserProfilesTableFilterComposer f) f,
  ) {
    final $$UserProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userProfiles,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfilesTableFilterComposer(
            $db: $db,
            $table: $db.userProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> kosPropertiesRefs(
    Expression<bool> Function($$KosPropertiesTableFilterComposer f) f,
  ) {
    final $$KosPropertiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.kosProperties,
      getReferencedColumn: (t) => t.ownerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KosPropertiesTableFilterComposer(
            $db: $db,
            $table: $db.kosProperties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> bookingsRefs(
    Expression<bool> Function($$BookingsTableFilterComposer f) f,
  ) {
    final $$BookingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bookings,
      getReferencedColumn: (t) => t.memberId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookingsTableFilterComposer(
            $db: $db,
            $table: $db.bookings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> invoicesRefs(
    Expression<bool> Function($$InvoicesTableFilterComposer f) f,
  ) {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.memberId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> reviewsRefs(
    Expression<bool> Function($$ReviewsTableFilterComposer f) f,
  ) {
    final $$ReviewsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reviews,
      getReferencedColumn: (t) => t.memberId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewsTableFilterComposer(
            $db: $db,
            $table: $db.reviews,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> appNotificationsRefs(
    Expression<bool> Function($$AppNotificationsTableFilterComposer f) f,
  ) {
    final $$AppNotificationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.appNotifications,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppNotificationsTableFilterComposer(
            $db: $db,
            $table: $db.appNotifications,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> favoritesRefs(
    Expression<bool> Function($$FavoritesTableFilterComposer f) f,
  ) {
    final $$FavoritesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.favorites,
      getReferencedColumn: (t) => t.memberId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FavoritesTableFilterComposer(
            $db: $db,
            $table: $db.favorites,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get passwordSalt => $composableBuilder(
    column: $table.passwordSalt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => column,
  );

  GeneratedColumn<String> get passwordSalt => $composableBuilder(
    column: $table.passwordSalt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> userProfilesRefs<T extends Object>(
    Expression<T> Function($$UserProfilesTableAnnotationComposer a) f,
  ) {
    final $$UserProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userProfiles,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.userProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> kosPropertiesRefs<T extends Object>(
    Expression<T> Function($$KosPropertiesTableAnnotationComposer a) f,
  ) {
    final $$KosPropertiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.kosProperties,
      getReferencedColumn: (t) => t.ownerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KosPropertiesTableAnnotationComposer(
            $db: $db,
            $table: $db.kosProperties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> bookingsRefs<T extends Object>(
    Expression<T> Function($$BookingsTableAnnotationComposer a) f,
  ) {
    final $$BookingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bookings,
      getReferencedColumn: (t) => t.memberId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookingsTableAnnotationComposer(
            $db: $db,
            $table: $db.bookings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> invoicesRefs<T extends Object>(
    Expression<T> Function($$InvoicesTableAnnotationComposer a) f,
  ) {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.memberId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> reviewsRefs<T extends Object>(
    Expression<T> Function($$ReviewsTableAnnotationComposer a) f,
  ) {
    final $$ReviewsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reviews,
      getReferencedColumn: (t) => t.memberId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewsTableAnnotationComposer(
            $db: $db,
            $table: $db.reviews,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> appNotificationsRefs<T extends Object>(
    Expression<T> Function($$AppNotificationsTableAnnotationComposer a) f,
  ) {
    final $$AppNotificationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.appNotifications,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppNotificationsTableAnnotationComposer(
            $db: $db,
            $table: $db.appNotifications,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> favoritesRefs<T extends Object>(
    Expression<T> Function($$FavoritesTableAnnotationComposer a) f,
  ) {
    final $$FavoritesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.favorites,
      getReferencedColumn: (t) => t.memberId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FavoritesTableAnnotationComposer(
            $db: $db,
            $table: $db.favorites,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, $$UsersTableReferences),
          User,
          PrefetchHooks Function({
            bool userProfilesRefs,
            bool kosPropertiesRefs,
            bool bookingsRefs,
            bool invoicesRefs,
            bool reviewsRefs,
            bool appNotificationsRefs,
            bool favoritesRefs,
          })
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> passwordHash = const Value.absent(),
                Value<String> passwordSalt = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                name: name,
                email: email,
                passwordHash: passwordHash,
                passwordSalt: passwordSalt,
                role: role,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String email,
                required String passwordHash,
                required String passwordSalt,
                Value<String> role = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                name: name,
                email: email,
                passwordHash: passwordHash,
                passwordSalt: passwordSalt,
                role: role,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UsersTable, User>(table),
                  $$UsersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                userProfilesRefs = false,
                kosPropertiesRefs = false,
                bookingsRefs = false,
                invoicesRefs = false,
                reviewsRefs = false,
                appNotificationsRefs = false,
                favoritesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (userProfilesRefs) db.userProfiles,
                    if (kosPropertiesRefs) db.kosProperties,
                    if (bookingsRefs) db.bookings,
                    if (invoicesRefs) db.invoices,
                    if (reviewsRefs) db.reviews,
                    if (appNotificationsRefs) db.appNotifications,
                    if (favoritesRefs) db.favorites,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (userProfilesRefs)
                        await $_getPrefetchedDataByColumns<
                          User,
                          $UsersTable,
                          UserProfile,
                          $UserProfilesTable
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._userProfilesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).userProfilesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'user_id',
                          typedResults: items,
                        ),
                      if (kosPropertiesRefs)
                        await $_getPrefetchedDataByColumns<
                          User,
                          $UsersTable,
                          KosProperty,
                          $KosPropertiesTable
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._kosPropertiesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).kosPropertiesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'owner_id',
                          typedResults: items,
                        ),
                      if (bookingsRefs)
                        await $_getPrefetchedDataByColumns<
                          User,
                          $UsersTable,
                          Booking,
                          $BookingsTable
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._bookingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).bookingsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'member_id',
                          typedResults: items,
                        ),
                      if (invoicesRefs)
                        await $_getPrefetchedDataByColumns<
                          User,
                          $UsersTable,
                          Invoice,
                          $InvoicesTable
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._invoicesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).invoicesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'member_id',
                          typedResults: items,
                        ),
                      if (reviewsRefs)
                        await $_getPrefetchedDataByColumns<
                          User,
                          $UsersTable,
                          Review,
                          $ReviewsTable
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._reviewsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(db, table, p0).reviewsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'member_id',
                          typedResults: items,
                        ),
                      if (appNotificationsRefs)
                        await $_getPrefetchedDataByColumns<
                          User,
                          $UsersTable,
                          AppNotification,
                          $AppNotificationsTable
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._appNotificationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).appNotificationsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'user_id',
                          typedResults: items,
                        ),
                      if (favoritesRefs)
                        await $_getPrefetchedDataByColumns<
                          User,
                          $UsersTable,
                          Favorite,
                          $FavoritesTable
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._favoritesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).favoritesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'member_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, $$UsersTableReferences),
      User,
      PrefetchHooks Function({
        bool userProfilesRefs,
        bool kosPropertiesRefs,
        bool bookingsRefs,
        bool invoicesRefs,
        bool reviewsRefs,
        bool appNotificationsRefs,
        bool favoritesRefs,
      })
    >;
typedef $$UserProfilesTableCreateCompanionBuilder =
    UserProfilesCompanion Function({
      Value<int> id,
      required int userId,
      Value<String?> phone,
      Value<String?> address,
      Value<String?> bio,
      Value<String?> avatarAsset,
      Value<DateTime> updatedAt,
    });
typedef $$UserProfilesTableUpdateCompanionBuilder =
    UserProfilesCompanion Function({
      Value<int> id,
      Value<int> userId,
      Value<String?> phone,
      Value<String?> address,
      Value<String?> bio,
      Value<String?> avatarAsset,
      Value<DateTime> updatedAt,
    });

final class $$UserProfilesTableReferences
    extends BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfile> {
  $$UserProfilesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) =>
      db.users.createAlias('user_profiles__user_id__users__id');

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UserProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bio => $composableBuilder(
    column: $table.bio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarAsset => $composableBuilder(
    column: $table.avatarAsset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bio => $composableBuilder(
    column: $table.bio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarAsset => $composableBuilder(
    column: $table.avatarAsset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get bio =>
      $composableBuilder(column: $table.bio, builder: (column) => column);

  GeneratedColumn<String> get avatarAsset => $composableBuilder(
    column: $table.avatarAsset,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserProfilesTable,
          UserProfile,
          $$UserProfilesTableFilterComposer,
          $$UserProfilesTableOrderingComposer,
          $$UserProfilesTableAnnotationComposer,
          $$UserProfilesTableCreateCompanionBuilder,
          $$UserProfilesTableUpdateCompanionBuilder,
          (UserProfile, $$UserProfilesTableReferences),
          UserProfile,
          PrefetchHooks Function({bool userId})
        > {
  $$UserProfilesTableTableManager(_$AppDatabase db, $UserProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> bio = const Value.absent(),
                Value<String?> avatarAsset = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserProfilesCompanion(
                id: id,
                userId: userId,
                phone: phone,
                address: address,
                bio: bio,
                avatarAsset: avatarAsset,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int userId,
                Value<String?> phone = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> bio = const Value.absent(),
                Value<String?> avatarAsset = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserProfilesCompanion.insert(
                id: id,
                userId: userId,
                phone: phone,
                address: address,
                bio: bio,
                avatarAsset: avatarAsset,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UserProfilesTable, UserProfile>(table),
                  $$UserProfilesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.userId,
                        referencedTable: $$UserProfilesTableReferences
                            ._userIdTable(db),
                        referencedColumn: $$UserProfilesTableReferences
                            ._userIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$UserProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserProfilesTable,
      UserProfile,
      $$UserProfilesTableFilterComposer,
      $$UserProfilesTableOrderingComposer,
      $$UserProfilesTableAnnotationComposer,
      $$UserProfilesTableCreateCompanionBuilder,
      $$UserProfilesTableUpdateCompanionBuilder,
      (UserProfile, $$UserProfilesTableReferences),
      UserProfile,
      PrefetchHooks Function({bool userId})
    >;
typedef $$KosPropertiesTableCreateCompanionBuilder =
    KosPropertiesCompanion Function({
      Value<int> id,
      required int ownerId,
      required String slug,
      required String title,
      required String description,
      required double price,
      required String type,
      required String city,
      required String address,
      required String thumbnailAsset,
      Value<String> status,
      Value<String?> area,
      Value<String?> roomsCount,
      Value<String?> bathrooms,
      Value<String?> garages,
      Value<bool> isFeatured,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$KosPropertiesTableUpdateCompanionBuilder =
    KosPropertiesCompanion Function({
      Value<int> id,
      Value<int> ownerId,
      Value<String> slug,
      Value<String> title,
      Value<String> description,
      Value<double> price,
      Value<String> type,
      Value<String> city,
      Value<String> address,
      Value<String> thumbnailAsset,
      Value<String> status,
      Value<String?> area,
      Value<String?> roomsCount,
      Value<String?> bathrooms,
      Value<String?> garages,
      Value<bool> isFeatured,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$KosPropertiesTableReferences
    extends BaseReferences<_$AppDatabase, $KosPropertiesTable, KosProperty> {
  $$KosPropertiesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UsersTable _ownerIdTable(_$AppDatabase db) =>
      db.users.createAlias('kos__owner_id__users__id');

  $$UsersTableProcessedTableManager get ownerId {
    final $_column = $_itemColumn<int>('owner_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ownerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$KosImagesTable, List<KosImage>>
  _kosImagesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.kosImages,
    aliasName: 'kos__id__kos_images__kos_id',
  );

  $$KosImagesTableProcessedTableManager get kosImagesRefs {
    final manager = $$KosImagesTableTableManager(
      $_db,
      $_db.kosImages,
    ).filter((f) => f.kosId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_kosImagesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$KosFacilitiesTable, List<KosFacility>>
  _kosFacilitiesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.kosFacilities,
    aliasName: 'kos__id__kos_facilities__kos_id',
  );

  $$KosFacilitiesTableProcessedTableManager get kosFacilitiesRefs {
    final manager = $$KosFacilitiesTableTableManager(
      $_db,
      $_db.kosFacilities,
    ).filter((f) => f.kosId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_kosFacilitiesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$BookingsTable, List<Booking>> _bookingsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.bookings,
    aliasName: 'kos__id__bookings__kos_id',
  );

  $$BookingsTableProcessedTableManager get bookingsRefs {
    final manager = $$BookingsTableTableManager(
      $_db,
      $_db.bookings,
    ).filter((f) => f.kosId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_bookingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$InvoicesTable, List<Invoice>> _invoicesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.invoices,
    aliasName: 'kos__id__invoices__kos_id',
  );

  $$InvoicesTableProcessedTableManager get invoicesRefs {
    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.kosId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_invoicesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ReviewsTable, List<Review>> _reviewsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.reviews,
    aliasName: 'kos__id__reviews__kos_id',
  );

  $$ReviewsTableProcessedTableManager get reviewsRefs {
    final manager = $$ReviewsTableTableManager(
      $_db,
      $_db.reviews,
    ).filter((f) => f.kosId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_reviewsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FavoritesTable, List<Favorite>>
  _favoritesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.favorites,
    aliasName: 'kos__id__favorites__kos_id',
  );

  $$FavoritesTableProcessedTableManager get favoritesRefs {
    final manager = $$FavoritesTableTableManager(
      $_db,
      $_db.favorites,
    ).filter((f) => f.kosId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_favoritesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$KosPropertiesTableFilterComposer
    extends Composer<_$AppDatabase, $KosPropertiesTable> {
  $$KosPropertiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get thumbnailAsset => $composableBuilder(
    column: $table.thumbnailAsset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get area => $composableBuilder(
    column: $table.area,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get roomsCount => $composableBuilder(
    column: $table.roomsCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bathrooms => $composableBuilder(
    column: $table.bathrooms,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get garages => $composableBuilder(
    column: $table.garages,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFeatured => $composableBuilder(
    column: $table.isFeatured,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get ownerId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ownerId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> kosImagesRefs(
    Expression<bool> Function($$KosImagesTableFilterComposer f) f,
  ) {
    final $$KosImagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.kosImages,
      getReferencedColumn: (t) => t.kosId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KosImagesTableFilterComposer(
            $db: $db,
            $table: $db.kosImages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> kosFacilitiesRefs(
    Expression<bool> Function($$KosFacilitiesTableFilterComposer f) f,
  ) {
    final $$KosFacilitiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.kosFacilities,
      getReferencedColumn: (t) => t.kosId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KosFacilitiesTableFilterComposer(
            $db: $db,
            $table: $db.kosFacilities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> bookingsRefs(
    Expression<bool> Function($$BookingsTableFilterComposer f) f,
  ) {
    final $$BookingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bookings,
      getReferencedColumn: (t) => t.kosId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookingsTableFilterComposer(
            $db: $db,
            $table: $db.bookings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> invoicesRefs(
    Expression<bool> Function($$InvoicesTableFilterComposer f) f,
  ) {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.kosId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> reviewsRefs(
    Expression<bool> Function($$ReviewsTableFilterComposer f) f,
  ) {
    final $$ReviewsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reviews,
      getReferencedColumn: (t) => t.kosId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewsTableFilterComposer(
            $db: $db,
            $table: $db.reviews,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> favoritesRefs(
    Expression<bool> Function($$FavoritesTableFilterComposer f) f,
  ) {
    final $$FavoritesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.favorites,
      getReferencedColumn: (t) => t.kosId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FavoritesTableFilterComposer(
            $db: $db,
            $table: $db.favorites,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$KosPropertiesTableOrderingComposer
    extends Composer<_$AppDatabase, $KosPropertiesTable> {
  $$KosPropertiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get thumbnailAsset => $composableBuilder(
    column: $table.thumbnailAsset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get area => $composableBuilder(
    column: $table.area,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get roomsCount => $composableBuilder(
    column: $table.roomsCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bathrooms => $composableBuilder(
    column: $table.bathrooms,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get garages => $composableBuilder(
    column: $table.garages,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFeatured => $composableBuilder(
    column: $table.isFeatured,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get ownerId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ownerId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$KosPropertiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $KosPropertiesTable> {
  $$KosPropertiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get thumbnailAsset => $composableBuilder(
    column: $table.thumbnailAsset,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get area =>
      $composableBuilder(column: $table.area, builder: (column) => column);

  GeneratedColumn<String> get roomsCount => $composableBuilder(
    column: $table.roomsCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bathrooms =>
      $composableBuilder(column: $table.bathrooms, builder: (column) => column);

  GeneratedColumn<String> get garages =>
      $composableBuilder(column: $table.garages, builder: (column) => column);

  GeneratedColumn<bool> get isFeatured => $composableBuilder(
    column: $table.isFeatured,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get ownerId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ownerId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> kosImagesRefs<T extends Object>(
    Expression<T> Function($$KosImagesTableAnnotationComposer a) f,
  ) {
    final $$KosImagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.kosImages,
      getReferencedColumn: (t) => t.kosId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KosImagesTableAnnotationComposer(
            $db: $db,
            $table: $db.kosImages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> kosFacilitiesRefs<T extends Object>(
    Expression<T> Function($$KosFacilitiesTableAnnotationComposer a) f,
  ) {
    final $$KosFacilitiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.kosFacilities,
      getReferencedColumn: (t) => t.kosId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KosFacilitiesTableAnnotationComposer(
            $db: $db,
            $table: $db.kosFacilities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> bookingsRefs<T extends Object>(
    Expression<T> Function($$BookingsTableAnnotationComposer a) f,
  ) {
    final $$BookingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bookings,
      getReferencedColumn: (t) => t.kosId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookingsTableAnnotationComposer(
            $db: $db,
            $table: $db.bookings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> invoicesRefs<T extends Object>(
    Expression<T> Function($$InvoicesTableAnnotationComposer a) f,
  ) {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.kosId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> reviewsRefs<T extends Object>(
    Expression<T> Function($$ReviewsTableAnnotationComposer a) f,
  ) {
    final $$ReviewsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reviews,
      getReferencedColumn: (t) => t.kosId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewsTableAnnotationComposer(
            $db: $db,
            $table: $db.reviews,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> favoritesRefs<T extends Object>(
    Expression<T> Function($$FavoritesTableAnnotationComposer a) f,
  ) {
    final $$FavoritesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.favorites,
      getReferencedColumn: (t) => t.kosId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FavoritesTableAnnotationComposer(
            $db: $db,
            $table: $db.favorites,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$KosPropertiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $KosPropertiesTable,
          KosProperty,
          $$KosPropertiesTableFilterComposer,
          $$KosPropertiesTableOrderingComposer,
          $$KosPropertiesTableAnnotationComposer,
          $$KosPropertiesTableCreateCompanionBuilder,
          $$KosPropertiesTableUpdateCompanionBuilder,
          (KosProperty, $$KosPropertiesTableReferences),
          KosProperty,
          PrefetchHooks Function({
            bool ownerId,
            bool kosImagesRefs,
            bool kosFacilitiesRefs,
            bool bookingsRefs,
            bool invoicesRefs,
            bool reviewsRefs,
            bool favoritesRefs,
          })
        > {
  $$KosPropertiesTableTableManager(_$AppDatabase db, $KosPropertiesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KosPropertiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KosPropertiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KosPropertiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> ownerId = const Value.absent(),
                Value<String> slug = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> city = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<String> thumbnailAsset = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> area = const Value.absent(),
                Value<String?> roomsCount = const Value.absent(),
                Value<String?> bathrooms = const Value.absent(),
                Value<String?> garages = const Value.absent(),
                Value<bool> isFeatured = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => KosPropertiesCompanion(
                id: id,
                ownerId: ownerId,
                slug: slug,
                title: title,
                description: description,
                price: price,
                type: type,
                city: city,
                address: address,
                thumbnailAsset: thumbnailAsset,
                status: status,
                area: area,
                roomsCount: roomsCount,
                bathrooms: bathrooms,
                garages: garages,
                isFeatured: isFeatured,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int ownerId,
                required String slug,
                required String title,
                required String description,
                required double price,
                required String type,
                required String city,
                required String address,
                required String thumbnailAsset,
                Value<String> status = const Value.absent(),
                Value<String?> area = const Value.absent(),
                Value<String?> roomsCount = const Value.absent(),
                Value<String?> bathrooms = const Value.absent(),
                Value<String?> garages = const Value.absent(),
                Value<bool> isFeatured = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => KosPropertiesCompanion.insert(
                id: id,
                ownerId: ownerId,
                slug: slug,
                title: title,
                description: description,
                price: price,
                type: type,
                city: city,
                address: address,
                thumbnailAsset: thumbnailAsset,
                status: status,
                area: area,
                roomsCount: roomsCount,
                bathrooms: bathrooms,
                garages: garages,
                isFeatured: isFeatured,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$KosPropertiesTable, KosProperty>(table),
                  $$KosPropertiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                ownerId = false,
                kosImagesRefs = false,
                kosFacilitiesRefs = false,
                bookingsRefs = false,
                invoicesRefs = false,
                reviewsRefs = false,
                favoritesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (kosImagesRefs) db.kosImages,
                    if (kosFacilitiesRefs) db.kosFacilities,
                    if (bookingsRefs) db.bookings,
                    if (invoicesRefs) db.invoices,
                    if (reviewsRefs) db.reviews,
                    if (favoritesRefs) db.favorites,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (ownerId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.ownerId,
                            referencedTable: $$KosPropertiesTableReferences
                                ._ownerIdTable(db),
                            referencedColumn: $$KosPropertiesTableReferences
                                ._ownerIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (kosImagesRefs)
                        await $_getPrefetchedDataByColumns<
                          KosProperty,
                          $KosPropertiesTable,
                          KosImage,
                          $KosImagesTable
                        >(
                          currentTable: table,
                          referencedTable: $$KosPropertiesTableReferences
                              ._kosImagesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$KosPropertiesTableReferences(
                                db,
                                table,
                                p0,
                              ).kosImagesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'kos_id',
                          typedResults: items,
                        ),
                      if (kosFacilitiesRefs)
                        await $_getPrefetchedDataByColumns<
                          KosProperty,
                          $KosPropertiesTable,
                          KosFacility,
                          $KosFacilitiesTable
                        >(
                          currentTable: table,
                          referencedTable: $$KosPropertiesTableReferences
                              ._kosFacilitiesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$KosPropertiesTableReferences(
                                db,
                                table,
                                p0,
                              ).kosFacilitiesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'kos_id',
                          typedResults: items,
                        ),
                      if (bookingsRefs)
                        await $_getPrefetchedDataByColumns<
                          KosProperty,
                          $KosPropertiesTable,
                          Booking,
                          $BookingsTable
                        >(
                          currentTable: table,
                          referencedTable: $$KosPropertiesTableReferences
                              ._bookingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$KosPropertiesTableReferences(
                                db,
                                table,
                                p0,
                              ).bookingsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'kos_id',
                          typedResults: items,
                        ),
                      if (invoicesRefs)
                        await $_getPrefetchedDataByColumns<
                          KosProperty,
                          $KosPropertiesTable,
                          Invoice,
                          $InvoicesTable
                        >(
                          currentTable: table,
                          referencedTable: $$KosPropertiesTableReferences
                              ._invoicesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$KosPropertiesTableReferences(
                                db,
                                table,
                                p0,
                              ).invoicesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'kos_id',
                          typedResults: items,
                        ),
                      if (reviewsRefs)
                        await $_getPrefetchedDataByColumns<
                          KosProperty,
                          $KosPropertiesTable,
                          Review,
                          $ReviewsTable
                        >(
                          currentTable: table,
                          referencedTable: $$KosPropertiesTableReferences
                              ._reviewsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$KosPropertiesTableReferences(
                                db,
                                table,
                                p0,
                              ).reviewsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'kos_id',
                          typedResults: items,
                        ),
                      if (favoritesRefs)
                        await $_getPrefetchedDataByColumns<
                          KosProperty,
                          $KosPropertiesTable,
                          Favorite,
                          $FavoritesTable
                        >(
                          currentTable: table,
                          referencedTable: $$KosPropertiesTableReferences
                              ._favoritesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$KosPropertiesTableReferences(
                                db,
                                table,
                                p0,
                              ).favoritesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'kos_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$KosPropertiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $KosPropertiesTable,
      KosProperty,
      $$KosPropertiesTableFilterComposer,
      $$KosPropertiesTableOrderingComposer,
      $$KosPropertiesTableAnnotationComposer,
      $$KosPropertiesTableCreateCompanionBuilder,
      $$KosPropertiesTableUpdateCompanionBuilder,
      (KosProperty, $$KosPropertiesTableReferences),
      KosProperty,
      PrefetchHooks Function({
        bool ownerId,
        bool kosImagesRefs,
        bool kosFacilitiesRefs,
        bool bookingsRefs,
        bool invoicesRefs,
        bool reviewsRefs,
        bool favoritesRefs,
      })
    >;
typedef $$KosImagesTableCreateCompanionBuilder = KosImagesCompanion Function({
  Value<int> id,
  required int kosId,
  required String imagePath,
  Value<int> sortOrder,
});
typedef $$KosImagesTableUpdateCompanionBuilder = KosImagesCompanion Function({
  Value<int> id,
  Value<int> kosId,
  Value<String> imagePath,
  Value<int> sortOrder,
});

final class $$KosImagesTableReferences
    extends BaseReferences<_$AppDatabase, $KosImagesTable, KosImage> {
  $$KosImagesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $KosPropertiesTable _kosIdTable(_$AppDatabase db) =>
      db.kosProperties.createAlias('kos_images__kos_id__kos__id');

  $$KosPropertiesTableProcessedTableManager get kosId {
    final $_column = $_itemColumn<int>('kos_id')!;

    final manager = $$KosPropertiesTableTableManager(
      $_db,
      $_db.kosProperties,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_kosIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$KosImagesTableFilterComposer
    extends Composer<_$AppDatabase, $KosImagesTable> {
  $$KosImagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$KosPropertiesTableFilterComposer get kosId {
    final $$KosPropertiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.kosId,
      referencedTable: $db.kosProperties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KosPropertiesTableFilterComposer(
            $db: $db,
            $table: $db.kosProperties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$KosImagesTableOrderingComposer
    extends Composer<_$AppDatabase, $KosImagesTable> {
  $$KosImagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$KosPropertiesTableOrderingComposer get kosId {
    final $$KosPropertiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.kosId,
      referencedTable: $db.kosProperties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KosPropertiesTableOrderingComposer(
            $db: $db,
            $table: $db.kosProperties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$KosImagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $KosImagesTable> {
  $$KosImagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$KosPropertiesTableAnnotationComposer get kosId {
    final $$KosPropertiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.kosId,
      referencedTable: $db.kosProperties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KosPropertiesTableAnnotationComposer(
            $db: $db,
            $table: $db.kosProperties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$KosImagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $KosImagesTable,
          KosImage,
          $$KosImagesTableFilterComposer,
          $$KosImagesTableOrderingComposer,
          $$KosImagesTableAnnotationComposer,
          $$KosImagesTableCreateCompanionBuilder,
          $$KosImagesTableUpdateCompanionBuilder,
          (KosImage, $$KosImagesTableReferences),
          KosImage,
          PrefetchHooks Function({bool kosId})
        > {
  $$KosImagesTableTableManager(_$AppDatabase db, $KosImagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KosImagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KosImagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KosImagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> kosId = const Value.absent(),
                Value<String> imagePath = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => KosImagesCompanion(
                id: id,
                kosId: kosId,
                imagePath: imagePath,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int kosId,
                required String imagePath,
                Value<int> sortOrder = const Value.absent(),
              }) => KosImagesCompanion.insert(
                id: id,
                kosId: kosId,
                imagePath: imagePath,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$KosImagesTable, KosImage>(table),
                  $$KosImagesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({kosId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (kosId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.kosId,
                        referencedTable: $$KosImagesTableReferences._kosIdTable(
                          db,
                        ),
                        referencedColumn: $$KosImagesTableReferences
                            ._kosIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$KosImagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $KosImagesTable,
      KosImage,
      $$KosImagesTableFilterComposer,
      $$KosImagesTableOrderingComposer,
      $$KosImagesTableAnnotationComposer,
      $$KosImagesTableCreateCompanionBuilder,
      $$KosImagesTableUpdateCompanionBuilder,
      (KosImage, $$KosImagesTableReferences),
      KosImage,
      PrefetchHooks Function({bool kosId})
    >;
typedef $$FacilitiesTableCreateCompanionBuilder = FacilitiesCompanion Function({
  Value<int> id,
  required String name,
  required String slug,
  Value<String> iconKey,
});
typedef $$FacilitiesTableUpdateCompanionBuilder = FacilitiesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> slug,
  Value<String> iconKey,
});

final class $$FacilitiesTableReferences
    extends BaseReferences<_$AppDatabase, $FacilitiesTable, Facility> {
  $$FacilitiesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$KosFacilitiesTable, List<KosFacility>>
  _kosFacilitiesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.kosFacilities,
    aliasName: 'facilities__id__kos_facilities__facility_id',
  );

  $$KosFacilitiesTableProcessedTableManager get kosFacilitiesRefs {
    final manager = $$KosFacilitiesTableTableManager(
      $_db,
      $_db.kosFacilities,
    ).filter((f) => f.facilityId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_kosFacilitiesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FacilitiesTableFilterComposer
    extends Composer<_$AppDatabase, $FacilitiesTable> {
  $$FacilitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconKey => $composableBuilder(
    column: $table.iconKey,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> kosFacilitiesRefs(
    Expression<bool> Function($$KosFacilitiesTableFilterComposer f) f,
  ) {
    final $$KosFacilitiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.kosFacilities,
      getReferencedColumn: (t) => t.facilityId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KosFacilitiesTableFilterComposer(
            $db: $db,
            $table: $db.kosFacilities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FacilitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $FacilitiesTable> {
  $$FacilitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconKey => $composableBuilder(
    column: $table.iconKey,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FacilitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FacilitiesTable> {
  $$FacilitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get iconKey =>
      $composableBuilder(column: $table.iconKey, builder: (column) => column);

  Expression<T> kosFacilitiesRefs<T extends Object>(
    Expression<T> Function($$KosFacilitiesTableAnnotationComposer a) f,
  ) {
    final $$KosFacilitiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.kosFacilities,
      getReferencedColumn: (t) => t.facilityId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KosFacilitiesTableAnnotationComposer(
            $db: $db,
            $table: $db.kosFacilities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FacilitiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FacilitiesTable,
          Facility,
          $$FacilitiesTableFilterComposer,
          $$FacilitiesTableOrderingComposer,
          $$FacilitiesTableAnnotationComposer,
          $$FacilitiesTableCreateCompanionBuilder,
          $$FacilitiesTableUpdateCompanionBuilder,
          (Facility, $$FacilitiesTableReferences),
          Facility,
          PrefetchHooks Function({bool kosFacilitiesRefs})
        > {
  $$FacilitiesTableTableManager(_$AppDatabase db, $FacilitiesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FacilitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FacilitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FacilitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> slug = const Value.absent(),
                Value<String> iconKey = const Value.absent(),
              }) => FacilitiesCompanion(
                id: id,
                name: name,
                slug: slug,
                iconKey: iconKey,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String slug,
                Value<String> iconKey = const Value.absent(),
              }) => FacilitiesCompanion.insert(
                id: id,
                name: name,
                slug: slug,
                iconKey: iconKey,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FacilitiesTable, Facility>(table),
                  $$FacilitiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({kosFacilitiesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (kosFacilitiesRefs) db.kosFacilities,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (kosFacilitiesRefs)
                    await $_getPrefetchedDataByColumns<
                      Facility,
                      $FacilitiesTable,
                      KosFacility,
                      $KosFacilitiesTable
                    >(
                      currentTable: table,
                      referencedTable: $$FacilitiesTableReferences
                          ._kosFacilitiesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$FacilitiesTableReferences(
                            db,
                            table,
                            p0,
                          ).kosFacilitiesRefs,
                      currentColumn: 'id',
                      referencedColumn: 'facility_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$FacilitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FacilitiesTable,
      Facility,
      $$FacilitiesTableFilterComposer,
      $$FacilitiesTableOrderingComposer,
      $$FacilitiesTableAnnotationComposer,
      $$FacilitiesTableCreateCompanionBuilder,
      $$FacilitiesTableUpdateCompanionBuilder,
      (Facility, $$FacilitiesTableReferences),
      Facility,
      PrefetchHooks Function({bool kosFacilitiesRefs})
    >;
typedef $$KosFacilitiesTableCreateCompanionBuilder =
    KosFacilitiesCompanion Function({
      required int kosId,
      required int facilityId,
      Value<int> rowid,
    });
typedef $$KosFacilitiesTableUpdateCompanionBuilder =
    KosFacilitiesCompanion Function({
      Value<int> kosId,
      Value<int> facilityId,
      Value<int> rowid,
    });

final class $$KosFacilitiesTableReferences
    extends BaseReferences<_$AppDatabase, $KosFacilitiesTable, KosFacility> {
  $$KosFacilitiesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $KosPropertiesTable _kosIdTable(_$AppDatabase db) =>
      db.kosProperties.createAlias('kos_facilities__kos_id__kos__id');

  $$KosPropertiesTableProcessedTableManager get kosId {
    final $_column = $_itemColumn<int>('kos_id')!;

    final manager = $$KosPropertiesTableTableManager(
      $_db,
      $_db.kosProperties,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_kosIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $FacilitiesTable _facilityIdTable(_$AppDatabase db) =>
      db.facilities.createAlias('kos_facilities__facility_id__facilities__id');

  $$FacilitiesTableProcessedTableManager get facilityId {
    final $_column = $_itemColumn<int>('facility_id')!;

    final manager = $$FacilitiesTableTableManager(
      $_db,
      $_db.facilities,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_facilityIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$KosFacilitiesTableFilterComposer
    extends Composer<_$AppDatabase, $KosFacilitiesTable> {
  $$KosFacilitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$KosPropertiesTableFilterComposer get kosId {
    final $$KosPropertiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.kosId,
      referencedTable: $db.kosProperties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KosPropertiesTableFilterComposer(
            $db: $db,
            $table: $db.kosProperties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FacilitiesTableFilterComposer get facilityId {
    final $$FacilitiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.facilityId,
      referencedTable: $db.facilities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FacilitiesTableFilterComposer(
            $db: $db,
            $table: $db.facilities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$KosFacilitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $KosFacilitiesTable> {
  $$KosFacilitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$KosPropertiesTableOrderingComposer get kosId {
    final $$KosPropertiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.kosId,
      referencedTable: $db.kosProperties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KosPropertiesTableOrderingComposer(
            $db: $db,
            $table: $db.kosProperties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FacilitiesTableOrderingComposer get facilityId {
    final $$FacilitiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.facilityId,
      referencedTable: $db.facilities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FacilitiesTableOrderingComposer(
            $db: $db,
            $table: $db.facilities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$KosFacilitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $KosFacilitiesTable> {
  $$KosFacilitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$KosPropertiesTableAnnotationComposer get kosId {
    final $$KosPropertiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.kosId,
      referencedTable: $db.kosProperties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KosPropertiesTableAnnotationComposer(
            $db: $db,
            $table: $db.kosProperties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FacilitiesTableAnnotationComposer get facilityId {
    final $$FacilitiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.facilityId,
      referencedTable: $db.facilities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FacilitiesTableAnnotationComposer(
            $db: $db,
            $table: $db.facilities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$KosFacilitiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $KosFacilitiesTable,
          KosFacility,
          $$KosFacilitiesTableFilterComposer,
          $$KosFacilitiesTableOrderingComposer,
          $$KosFacilitiesTableAnnotationComposer,
          $$KosFacilitiesTableCreateCompanionBuilder,
          $$KosFacilitiesTableUpdateCompanionBuilder,
          (KosFacility, $$KosFacilitiesTableReferences),
          KosFacility,
          PrefetchHooks Function({bool kosId, bool facilityId})
        > {
  $$KosFacilitiesTableTableManager(_$AppDatabase db, $KosFacilitiesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KosFacilitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KosFacilitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KosFacilitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> kosId = const Value.absent(),
                Value<int> facilityId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => KosFacilitiesCompanion(
                kosId: kosId,
                facilityId: facilityId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int kosId,
                required int facilityId,
                Value<int> rowid = const Value.absent(),
              }) => KosFacilitiesCompanion.insert(
                kosId: kosId,
                facilityId: facilityId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$KosFacilitiesTable, KosFacility>(table),
                  $$KosFacilitiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({kosId = false, facilityId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (kosId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.kosId,
                        referencedTable: $$KosFacilitiesTableReferences
                            ._kosIdTable(db),
                        referencedColumn: $$KosFacilitiesTableReferences
                            ._kosIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (facilityId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.facilityId,
                        referencedTable: $$KosFacilitiesTableReferences
                            ._facilityIdTable(db),
                        referencedColumn: $$KosFacilitiesTableReferences
                            ._facilityIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$KosFacilitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $KosFacilitiesTable,
      KosFacility,
      $$KosFacilitiesTableFilterComposer,
      $$KosFacilitiesTableOrderingComposer,
      $$KosFacilitiesTableAnnotationComposer,
      $$KosFacilitiesTableCreateCompanionBuilder,
      $$KosFacilitiesTableUpdateCompanionBuilder,
      (KosFacility, $$KosFacilitiesTableReferences),
      KosFacility,
      PrefetchHooks Function({bool kosId, bool facilityId})
    >;
typedef $$BookingsTableCreateCompanionBuilder = BookingsCompanion Function({
  Value<int> id,
  required String bookingCode,
  required int kosId,
  required int memberId,
  required String tenantName,
  required String tenantPhone,
  required String tenantEmail,
  required String startDate,
  required String endDate,
  required int durationMonths,
  required double kosPrice,
  required double subtotal,
  Value<double> adminFee,
  required double totalAmount,
  Value<String?> notes,
  Value<String> status,
  Value<String?> rejectionReason,
  Value<DateTime> createdAt,
});
typedef $$BookingsTableUpdateCompanionBuilder = BookingsCompanion Function({
  Value<int> id,
  Value<String> bookingCode,
  Value<int> kosId,
  Value<int> memberId,
  Value<String> tenantName,
  Value<String> tenantPhone,
  Value<String> tenantEmail,
  Value<String> startDate,
  Value<String> endDate,
  Value<int> durationMonths,
  Value<double> kosPrice,
  Value<double> subtotal,
  Value<double> adminFee,
  Value<double> totalAmount,
  Value<String?> notes,
  Value<String> status,
  Value<String?> rejectionReason,
  Value<DateTime> createdAt,
});

final class $$BookingsTableReferences
    extends BaseReferences<_$AppDatabase, $BookingsTable, Booking> {
  $$BookingsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $KosPropertiesTable _kosIdTable(_$AppDatabase db) =>
      db.kosProperties.createAlias('bookings__kos_id__kos__id');

  $$KosPropertiesTableProcessedTableManager get kosId {
    final $_column = $_itemColumn<int>('kos_id')!;

    final manager = $$KosPropertiesTableTableManager(
      $_db,
      $_db.kosProperties,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_kosIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UsersTable _memberIdTable(_$AppDatabase db) =>
      db.users.createAlias('bookings__member_id__users__id');

  $$UsersTableProcessedTableManager get memberId {
    final $_column = $_itemColumn<int>('member_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_memberIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$InvoicesTable, List<Invoice>> _invoicesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.invoices,
    aliasName: 'bookings__id__invoices__booking_id',
  );

  $$InvoicesTableProcessedTableManager get invoicesRefs {
    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.bookingId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_invoicesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BookingsTableFilterComposer
    extends Composer<_$AppDatabase, $BookingsTable> {
  $$BookingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bookingCode => $composableBuilder(
    column: $table.bookingCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tenantName => $composableBuilder(
    column: $table.tenantName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tenantPhone => $composableBuilder(
    column: $table.tenantPhone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tenantEmail => $composableBuilder(
    column: $table.tenantEmail,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMonths => $composableBuilder(
    column: $table.durationMonths,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get kosPrice => $composableBuilder(
    column: $table.kosPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get adminFee => $composableBuilder(
    column: $table.adminFee,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rejectionReason => $composableBuilder(
    column: $table.rejectionReason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$KosPropertiesTableFilterComposer get kosId {
    final $$KosPropertiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.kosId,
      referencedTable: $db.kosProperties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KosPropertiesTableFilterComposer(
            $db: $db,
            $table: $db.kosProperties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableFilterComposer get memberId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> invoicesRefs(
    Expression<bool> Function($$InvoicesTableFilterComposer f) f,
  ) {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.bookingId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BookingsTableOrderingComposer
    extends Composer<_$AppDatabase, $BookingsTable> {
  $$BookingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bookingCode => $composableBuilder(
    column: $table.bookingCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tenantName => $composableBuilder(
    column: $table.tenantName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tenantPhone => $composableBuilder(
    column: $table.tenantPhone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tenantEmail => $composableBuilder(
    column: $table.tenantEmail,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMonths => $composableBuilder(
    column: $table.durationMonths,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get kosPrice => $composableBuilder(
    column: $table.kosPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get adminFee => $composableBuilder(
    column: $table.adminFee,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rejectionReason => $composableBuilder(
    column: $table.rejectionReason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$KosPropertiesTableOrderingComposer get kosId {
    final $$KosPropertiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.kosId,
      referencedTable: $db.kosProperties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KosPropertiesTableOrderingComposer(
            $db: $db,
            $table: $db.kosProperties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableOrderingComposer get memberId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BookingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BookingsTable> {
  $$BookingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get bookingCode => $composableBuilder(
    column: $table.bookingCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tenantName => $composableBuilder(
    column: $table.tenantName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tenantPhone => $composableBuilder(
    column: $table.tenantPhone,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tenantEmail => $composableBuilder(
    column: $table.tenantEmail,
    builder: (column) => column,
  );

  GeneratedColumn<String> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<String> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<int> get durationMonths => $composableBuilder(
    column: $table.durationMonths,
    builder: (column) => column,
  );

  GeneratedColumn<double> get kosPrice =>
      $composableBuilder(column: $table.kosPrice, builder: (column) => column);

  GeneratedColumn<double> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);

  GeneratedColumn<double> get adminFee =>
      $composableBuilder(column: $table.adminFee, builder: (column) => column);

  GeneratedColumn<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get rejectionReason => $composableBuilder(
    column: $table.rejectionReason,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$KosPropertiesTableAnnotationComposer get kosId {
    final $$KosPropertiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.kosId,
      referencedTable: $db.kosProperties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KosPropertiesTableAnnotationComposer(
            $db: $db,
            $table: $db.kosProperties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableAnnotationComposer get memberId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> invoicesRefs<T extends Object>(
    Expression<T> Function($$InvoicesTableAnnotationComposer a) f,
  ) {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.bookingId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BookingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BookingsTable,
          Booking,
          $$BookingsTableFilterComposer,
          $$BookingsTableOrderingComposer,
          $$BookingsTableAnnotationComposer,
          $$BookingsTableCreateCompanionBuilder,
          $$BookingsTableUpdateCompanionBuilder,
          (Booking, $$BookingsTableReferences),
          Booking,
          PrefetchHooks Function({bool kosId, bool memberId, bool invoicesRefs})
        > {
  $$BookingsTableTableManager(_$AppDatabase db, $BookingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BookingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BookingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BookingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> bookingCode = const Value.absent(),
                Value<int> kosId = const Value.absent(),
                Value<int> memberId = const Value.absent(),
                Value<String> tenantName = const Value.absent(),
                Value<String> tenantPhone = const Value.absent(),
                Value<String> tenantEmail = const Value.absent(),
                Value<String> startDate = const Value.absent(),
                Value<String> endDate = const Value.absent(),
                Value<int> durationMonths = const Value.absent(),
                Value<double> kosPrice = const Value.absent(),
                Value<double> subtotal = const Value.absent(),
                Value<double> adminFee = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> rejectionReason = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => BookingsCompanion(
                id: id,
                bookingCode: bookingCode,
                kosId: kosId,
                memberId: memberId,
                tenantName: tenantName,
                tenantPhone: tenantPhone,
                tenantEmail: tenantEmail,
                startDate: startDate,
                endDate: endDate,
                durationMonths: durationMonths,
                kosPrice: kosPrice,
                subtotal: subtotal,
                adminFee: adminFee,
                totalAmount: totalAmount,
                notes: notes,
                status: status,
                rejectionReason: rejectionReason,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String bookingCode,
                required int kosId,
                required int memberId,
                required String tenantName,
                required String tenantPhone,
                required String tenantEmail,
                required String startDate,
                required String endDate,
                required int durationMonths,
                required double kosPrice,
                required double subtotal,
                Value<double> adminFee = const Value.absent(),
                required double totalAmount,
                Value<String?> notes = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> rejectionReason = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => BookingsCompanion.insert(
                id: id,
                bookingCode: bookingCode,
                kosId: kosId,
                memberId: memberId,
                tenantName: tenantName,
                tenantPhone: tenantPhone,
                tenantEmail: tenantEmail,
                startDate: startDate,
                endDate: endDate,
                durationMonths: durationMonths,
                kosPrice: kosPrice,
                subtotal: subtotal,
                adminFee: adminFee,
                totalAmount: totalAmount,
                notes: notes,
                status: status,
                rejectionReason: rejectionReason,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BookingsTable, Booking>(table),
                  $$BookingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({kosId = false, memberId = false, invoicesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [if (invoicesRefs) db.invoices],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (kosId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.kosId,
                            referencedTable: $$BookingsTableReferences
                                ._kosIdTable(db),
                            referencedColumn: $$BookingsTableReferences
                                ._kosIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (memberId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.memberId,
                            referencedTable: $$BookingsTableReferences
                                ._memberIdTable(db),
                            referencedColumn: $$BookingsTableReferences
                                ._memberIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (invoicesRefs)
                        await $_getPrefetchedDataByColumns<
                          Booking,
                          $BookingsTable,
                          Invoice,
                          $InvoicesTable
                        >(
                          currentTable: table,
                          referencedTable: $$BookingsTableReferences
                              ._invoicesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BookingsTableReferences(
                                db,
                                table,
                                p0,
                              ).invoicesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'booking_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$BookingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BookingsTable,
      Booking,
      $$BookingsTableFilterComposer,
      $$BookingsTableOrderingComposer,
      $$BookingsTableAnnotationComposer,
      $$BookingsTableCreateCompanionBuilder,
      $$BookingsTableUpdateCompanionBuilder,
      (Booking, $$BookingsTableReferences),
      Booking,
      PrefetchHooks Function({bool kosId, bool memberId, bool invoicesRefs})
    >;
typedef $$InvoicesTableCreateCompanionBuilder = InvoicesCompanion Function({
  Value<int> id,
  required String invoiceNumber,
  required int bookingId,
  required int memberId,
  required int kosId,
  required double amount,
  Value<double> adminFee,
  required double totalAmount,
  required String dueDate,
  Value<DateTime?> paidAt,
  Value<String?> paymentMethod,
  Value<String> status,
  Value<DateTime> createdAt,
});
typedef $$InvoicesTableUpdateCompanionBuilder = InvoicesCompanion Function({
  Value<int> id,
  Value<String> invoiceNumber,
  Value<int> bookingId,
  Value<int> memberId,
  Value<int> kosId,
  Value<double> amount,
  Value<double> adminFee,
  Value<double> totalAmount,
  Value<String> dueDate,
  Value<DateTime?> paidAt,
  Value<String?> paymentMethod,
  Value<String> status,
  Value<DateTime> createdAt,
});

final class $$InvoicesTableReferences
    extends BaseReferences<_$AppDatabase, $InvoicesTable, Invoice> {
  $$InvoicesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BookingsTable _bookingIdTable(_$AppDatabase db) =>
      db.bookings.createAlias('invoices__booking_id__bookings__id');

  $$BookingsTableProcessedTableManager get bookingId {
    final $_column = $_itemColumn<int>('booking_id')!;

    final manager = $$BookingsTableTableManager(
      $_db,
      $_db.bookings,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bookingIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UsersTable _memberIdTable(_$AppDatabase db) =>
      db.users.createAlias('invoices__member_id__users__id');

  $$UsersTableProcessedTableManager get memberId {
    final $_column = $_itemColumn<int>('member_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_memberIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $KosPropertiesTable _kosIdTable(_$AppDatabase db) =>
      db.kosProperties.createAlias('invoices__kos_id__kos__id');

  $$KosPropertiesTableProcessedTableManager get kosId {
    final $_column = $_itemColumn<int>('kos_id')!;

    final manager = $$KosPropertiesTableTableManager(
      $_db,
      $_db.kosProperties,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_kosIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$InvoicesTableFilterComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invoiceNumber => $composableBuilder(
    column: $table.invoiceNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get adminFee => $composableBuilder(
    column: $table.adminFee,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get paidAt => $composableBuilder(
    column: $table.paidAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$BookingsTableFilterComposer get bookingId {
    final $$BookingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookingId,
      referencedTable: $db.bookings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookingsTableFilterComposer(
            $db: $db,
            $table: $db.bookings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableFilterComposer get memberId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$KosPropertiesTableFilterComposer get kosId {
    final $$KosPropertiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.kosId,
      referencedTable: $db.kosProperties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KosPropertiesTableFilterComposer(
            $db: $db,
            $table: $db.kosProperties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvoicesTableOrderingComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invoiceNumber => $composableBuilder(
    column: $table.invoiceNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get adminFee => $composableBuilder(
    column: $table.adminFee,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get paidAt => $composableBuilder(
    column: $table.paidAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$BookingsTableOrderingComposer get bookingId {
    final $$BookingsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookingId,
      referencedTable: $db.bookings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookingsTableOrderingComposer(
            $db: $db,
            $table: $db.bookings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableOrderingComposer get memberId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$KosPropertiesTableOrderingComposer get kosId {
    final $$KosPropertiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.kosId,
      referencedTable: $db.kosProperties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KosPropertiesTableOrderingComposer(
            $db: $db,
            $table: $db.kosProperties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvoicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get invoiceNumber => $composableBuilder(
    column: $table.invoiceNumber,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<double> get adminFee =>
      $composableBuilder(column: $table.adminFee, builder: (column) => column);

  GeneratedColumn<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<DateTime> get paidAt =>
      $composableBuilder(column: $table.paidAt, builder: (column) => column);

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$BookingsTableAnnotationComposer get bookingId {
    final $$BookingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookingId,
      referencedTable: $db.bookings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookingsTableAnnotationComposer(
            $db: $db,
            $table: $db.bookings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableAnnotationComposer get memberId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$KosPropertiesTableAnnotationComposer get kosId {
    final $$KosPropertiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.kosId,
      referencedTable: $db.kosProperties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KosPropertiesTableAnnotationComposer(
            $db: $db,
            $table: $db.kosProperties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvoicesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InvoicesTable,
          Invoice,
          $$InvoicesTableFilterComposer,
          $$InvoicesTableOrderingComposer,
          $$InvoicesTableAnnotationComposer,
          $$InvoicesTableCreateCompanionBuilder,
          $$InvoicesTableUpdateCompanionBuilder,
          (Invoice, $$InvoicesTableReferences),
          Invoice,
          PrefetchHooks Function({bool bookingId, bool memberId, bool kosId})
        > {
  $$InvoicesTableTableManager(_$AppDatabase db, $InvoicesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvoicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvoicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvoicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> invoiceNumber = const Value.absent(),
                Value<int> bookingId = const Value.absent(),
                Value<int> memberId = const Value.absent(),
                Value<int> kosId = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<double> adminFee = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
                Value<String> dueDate = const Value.absent(),
                Value<DateTime?> paidAt = const Value.absent(),
                Value<String?> paymentMethod = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => InvoicesCompanion(
                id: id,
                invoiceNumber: invoiceNumber,
                bookingId: bookingId,
                memberId: memberId,
                kosId: kosId,
                amount: amount,
                adminFee: adminFee,
                totalAmount: totalAmount,
                dueDate: dueDate,
                paidAt: paidAt,
                paymentMethod: paymentMethod,
                status: status,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String invoiceNumber,
                required int bookingId,
                required int memberId,
                required int kosId,
                required double amount,
                Value<double> adminFee = const Value.absent(),
                required double totalAmount,
                required String dueDate,
                Value<DateTime?> paidAt = const Value.absent(),
                Value<String?> paymentMethod = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => InvoicesCompanion.insert(
                id: id,
                invoiceNumber: invoiceNumber,
                bookingId: bookingId,
                memberId: memberId,
                kosId: kosId,
                amount: amount,
                adminFee: adminFee,
                totalAmount: totalAmount,
                dueDate: dueDate,
                paidAt: paidAt,
                paymentMethod: paymentMethod,
                status: status,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$InvoicesTable, Invoice>(table),
                  $$InvoicesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({bookingId = false, memberId = false, kosId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (bookingId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.bookingId,
                            referencedTable: $$InvoicesTableReferences
                                ._bookingIdTable(db),
                            referencedColumn: $$InvoicesTableReferences
                                ._bookingIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (memberId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.memberId,
                            referencedTable: $$InvoicesTableReferences
                                ._memberIdTable(db),
                            referencedColumn: $$InvoicesTableReferences
                                ._memberIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (kosId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.kosId,
                            referencedTable: $$InvoicesTableReferences
                                ._kosIdTable(db),
                            referencedColumn: $$InvoicesTableReferences
                                ._kosIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$InvoicesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InvoicesTable,
      Invoice,
      $$InvoicesTableFilterComposer,
      $$InvoicesTableOrderingComposer,
      $$InvoicesTableAnnotationComposer,
      $$InvoicesTableCreateCompanionBuilder,
      $$InvoicesTableUpdateCompanionBuilder,
      (Invoice, $$InvoicesTableReferences),
      Invoice,
      PrefetchHooks Function({bool bookingId, bool memberId, bool kosId})
    >;
typedef $$ReviewsTableCreateCompanionBuilder = ReviewsCompanion Function({
  Value<int> id,
  required int kosId,
  required int memberId,
  required String reviewerName,
  required int rating,
  required String comment,
  Value<String?> ownerReply,
  Value<DateTime> createdAt,
});
typedef $$ReviewsTableUpdateCompanionBuilder = ReviewsCompanion Function({
  Value<int> id,
  Value<int> kosId,
  Value<int> memberId,
  Value<String> reviewerName,
  Value<int> rating,
  Value<String> comment,
  Value<String?> ownerReply,
  Value<DateTime> createdAt,
});

final class $$ReviewsTableReferences
    extends BaseReferences<_$AppDatabase, $ReviewsTable, Review> {
  $$ReviewsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $KosPropertiesTable _kosIdTable(_$AppDatabase db) =>
      db.kosProperties.createAlias('reviews__kos_id__kos__id');

  $$KosPropertiesTableProcessedTableManager get kosId {
    final $_column = $_itemColumn<int>('kos_id')!;

    final manager = $$KosPropertiesTableTableManager(
      $_db,
      $_db.kosProperties,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_kosIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UsersTable _memberIdTable(_$AppDatabase db) =>
      db.users.createAlias('reviews__member_id__users__id');

  $$UsersTableProcessedTableManager get memberId {
    final $_column = $_itemColumn<int>('member_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_memberIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ReviewsTableFilterComposer
    extends Composer<_$AppDatabase, $ReviewsTable> {
  $$ReviewsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reviewerName => $composableBuilder(
    column: $table.reviewerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerReply => $composableBuilder(
    column: $table.ownerReply,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$KosPropertiesTableFilterComposer get kosId {
    final $$KosPropertiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.kosId,
      referencedTable: $db.kosProperties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KosPropertiesTableFilterComposer(
            $db: $db,
            $table: $db.kosProperties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableFilterComposer get memberId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReviewsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReviewsTable> {
  $$ReviewsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reviewerName => $composableBuilder(
    column: $table.reviewerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerReply => $composableBuilder(
    column: $table.ownerReply,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$KosPropertiesTableOrderingComposer get kosId {
    final $$KosPropertiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.kosId,
      referencedTable: $db.kosProperties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KosPropertiesTableOrderingComposer(
            $db: $db,
            $table: $db.kosProperties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableOrderingComposer get memberId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReviewsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReviewsTable> {
  $$ReviewsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get reviewerName => $composableBuilder(
    column: $table.reviewerName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<String> get comment =>
      $composableBuilder(column: $table.comment, builder: (column) => column);

  GeneratedColumn<String> get ownerReply => $composableBuilder(
    column: $table.ownerReply,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$KosPropertiesTableAnnotationComposer get kosId {
    final $$KosPropertiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.kosId,
      referencedTable: $db.kosProperties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KosPropertiesTableAnnotationComposer(
            $db: $db,
            $table: $db.kosProperties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableAnnotationComposer get memberId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReviewsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReviewsTable,
          Review,
          $$ReviewsTableFilterComposer,
          $$ReviewsTableOrderingComposer,
          $$ReviewsTableAnnotationComposer,
          $$ReviewsTableCreateCompanionBuilder,
          $$ReviewsTableUpdateCompanionBuilder,
          (Review, $$ReviewsTableReferences),
          Review,
          PrefetchHooks Function({bool kosId, bool memberId})
        > {
  $$ReviewsTableTableManager(_$AppDatabase db, $ReviewsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReviewsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReviewsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReviewsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> kosId = const Value.absent(),
                Value<int> memberId = const Value.absent(),
                Value<String> reviewerName = const Value.absent(),
                Value<int> rating = const Value.absent(),
                Value<String> comment = const Value.absent(),
                Value<String?> ownerReply = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ReviewsCompanion(
                id: id,
                kosId: kosId,
                memberId: memberId,
                reviewerName: reviewerName,
                rating: rating,
                comment: comment,
                ownerReply: ownerReply,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int kosId,
                required int memberId,
                required String reviewerName,
                required int rating,
                required String comment,
                Value<String?> ownerReply = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ReviewsCompanion.insert(
                id: id,
                kosId: kosId,
                memberId: memberId,
                reviewerName: reviewerName,
                rating: rating,
                comment: comment,
                ownerReply: ownerReply,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ReviewsTable, Review>(table),
                  $$ReviewsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({kosId = false, memberId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (kosId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.kosId,
                        referencedTable: $$ReviewsTableReferences._kosIdTable(
                          db,
                        ),
                        referencedColumn: $$ReviewsTableReferences
                            ._kosIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (memberId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.memberId,
                        referencedTable: $$ReviewsTableReferences
                            ._memberIdTable(db),
                        referencedColumn: $$ReviewsTableReferences
                            ._memberIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ReviewsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReviewsTable,
      Review,
      $$ReviewsTableFilterComposer,
      $$ReviewsTableOrderingComposer,
      $$ReviewsTableAnnotationComposer,
      $$ReviewsTableCreateCompanionBuilder,
      $$ReviewsTableUpdateCompanionBuilder,
      (Review, $$ReviewsTableReferences),
      Review,
      PrefetchHooks Function({bool kosId, bool memberId})
    >;
typedef $$AppNotificationsTableCreateCompanionBuilder =
    AppNotificationsCompanion Function({
      Value<int> id,
      required int userId,
      required String title,
      required String message,
      Value<String> category,
      Value<bool> isRead,
      Value<DateTime> createdAt,
    });
typedef $$AppNotificationsTableUpdateCompanionBuilder =
    AppNotificationsCompanion Function({
      Value<int> id,
      Value<int> userId,
      Value<String> title,
      Value<String> message,
      Value<String> category,
      Value<bool> isRead,
      Value<DateTime> createdAt,
    });

final class $$AppNotificationsTableReferences
    extends
        BaseReferences<_$AppDatabase, $AppNotificationsTable, AppNotification> {
  $$AppNotificationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UsersTable _userIdTable(_$AppDatabase db) =>
      db.users.createAlias('notifications__user_id__users__id');

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AppNotificationsTableFilterComposer
    extends Composer<_$AppDatabase, $AppNotificationsTable> {
  $$AppNotificationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AppNotificationsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppNotificationsTable> {
  $$AppNotificationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AppNotificationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppNotificationsTable> {
  $$AppNotificationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<bool> get isRead =>
      $composableBuilder(column: $table.isRead, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AppNotificationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppNotificationsTable,
          AppNotification,
          $$AppNotificationsTableFilterComposer,
          $$AppNotificationsTableOrderingComposer,
          $$AppNotificationsTableAnnotationComposer,
          $$AppNotificationsTableCreateCompanionBuilder,
          $$AppNotificationsTableUpdateCompanionBuilder,
          (AppNotification, $$AppNotificationsTableReferences),
          AppNotification,
          PrefetchHooks Function({bool userId})
        > {
  $$AppNotificationsTableTableManager(
    _$AppDatabase db,
    $AppNotificationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppNotificationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppNotificationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppNotificationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> message = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<bool> isRead = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => AppNotificationsCompanion(
                id: id,
                userId: userId,
                title: title,
                message: message,
                category: category,
                isRead: isRead,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int userId,
                required String title,
                required String message,
                Value<String> category = const Value.absent(),
                Value<bool> isRead = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => AppNotificationsCompanion.insert(
                id: id,
                userId: userId,
                title: title,
                message: message,
                category: category,
                isRead: isRead,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AppNotificationsTable, AppNotification>(table),
                  $$AppNotificationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.userId,
                        referencedTable: $$AppNotificationsTableReferences
                            ._userIdTable(db),
                        referencedColumn: $$AppNotificationsTableReferences
                            ._userIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AppNotificationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppNotificationsTable,
      AppNotification,
      $$AppNotificationsTableFilterComposer,
      $$AppNotificationsTableOrderingComposer,
      $$AppNotificationsTableAnnotationComposer,
      $$AppNotificationsTableCreateCompanionBuilder,
      $$AppNotificationsTableUpdateCompanionBuilder,
      (AppNotification, $$AppNotificationsTableReferences),
      AppNotification,
      PrefetchHooks Function({bool userId})
    >;
typedef $$FavoritesTableCreateCompanionBuilder = FavoritesCompanion Function({
  required int memberId,
  required int kosId,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$FavoritesTableUpdateCompanionBuilder = FavoritesCompanion Function({
  Value<int> memberId,
  Value<int> kosId,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$FavoritesTableReferences
    extends BaseReferences<_$AppDatabase, $FavoritesTable, Favorite> {
  $$FavoritesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _memberIdTable(_$AppDatabase db) =>
      db.users.createAlias('favorites__member_id__users__id');

  $$UsersTableProcessedTableManager get memberId {
    final $_column = $_itemColumn<int>('member_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_memberIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $KosPropertiesTable _kosIdTable(_$AppDatabase db) =>
      db.kosProperties.createAlias('favorites__kos_id__kos__id');

  $$KosPropertiesTableProcessedTableManager get kosId {
    final $_column = $_itemColumn<int>('kos_id')!;

    final manager = $$KosPropertiesTableTableManager(
      $_db,
      $_db.kosProperties,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_kosIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FavoritesTableFilterComposer
    extends Composer<_$AppDatabase, $FavoritesTable> {
  $$FavoritesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get memberId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$KosPropertiesTableFilterComposer get kosId {
    final $$KosPropertiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.kosId,
      referencedTable: $db.kosProperties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KosPropertiesTableFilterComposer(
            $db: $db,
            $table: $db.kosProperties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FavoritesTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoritesTable> {
  $$FavoritesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get memberId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$KosPropertiesTableOrderingComposer get kosId {
    final $$KosPropertiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.kosId,
      referencedTable: $db.kosProperties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KosPropertiesTableOrderingComposer(
            $db: $db,
            $table: $db.kosProperties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FavoritesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoritesTable> {
  $$FavoritesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get memberId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$KosPropertiesTableAnnotationComposer get kosId {
    final $$KosPropertiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.kosId,
      referencedTable: $db.kosProperties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KosPropertiesTableAnnotationComposer(
            $db: $db,
            $table: $db.kosProperties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FavoritesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FavoritesTable,
          Favorite,
          $$FavoritesTableFilterComposer,
          $$FavoritesTableOrderingComposer,
          $$FavoritesTableAnnotationComposer,
          $$FavoritesTableCreateCompanionBuilder,
          $$FavoritesTableUpdateCompanionBuilder,
          (Favorite, $$FavoritesTableReferences),
          Favorite,
          PrefetchHooks Function({bool memberId, bool kosId})
        > {
  $$FavoritesTableTableManager(_$AppDatabase db, $FavoritesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoritesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoritesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoritesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> memberId = const Value.absent(),
                Value<int> kosId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FavoritesCompanion(
                memberId: memberId,
                kosId: kosId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int memberId,
                required int kosId,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FavoritesCompanion.insert(
                memberId: memberId,
                kosId: kosId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FavoritesTable, Favorite>(table),
                  $$FavoritesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({memberId = false, kosId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (memberId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.memberId,
                        referencedTable: $$FavoritesTableReferences
                            ._memberIdTable(db),
                        referencedColumn: $$FavoritesTableReferences
                            ._memberIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (kosId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.kosId,
                        referencedTable: $$FavoritesTableReferences._kosIdTable(
                          db,
                        ),
                        referencedColumn: $$FavoritesTableReferences
                            ._kosIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FavoritesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FavoritesTable,
      Favorite,
      $$FavoritesTableFilterComposer,
      $$FavoritesTableOrderingComposer,
      $$FavoritesTableAnnotationComposer,
      $$FavoritesTableCreateCompanionBuilder,
      $$FavoritesTableUpdateCompanionBuilder,
      (Favorite, $$FavoritesTableReferences),
      Favorite,
      PrefetchHooks Function({bool memberId, bool kosId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$UserProfilesTableTableManager get userProfiles =>
      $$UserProfilesTableTableManager(_db, _db.userProfiles);
  $$KosPropertiesTableTableManager get kosProperties =>
      $$KosPropertiesTableTableManager(_db, _db.kosProperties);
  $$KosImagesTableTableManager get kosImages =>
      $$KosImagesTableTableManager(_db, _db.kosImages);
  $$FacilitiesTableTableManager get facilities =>
      $$FacilitiesTableTableManager(_db, _db.facilities);
  $$KosFacilitiesTableTableManager get kosFacilities =>
      $$KosFacilitiesTableTableManager(_db, _db.kosFacilities);
  $$BookingsTableTableManager get bookings =>
      $$BookingsTableTableManager(_db, _db.bookings);
  $$InvoicesTableTableManager get invoices =>
      $$InvoicesTableTableManager(_db, _db.invoices);
  $$ReviewsTableTableManager get reviews =>
      $$ReviewsTableTableManager(_db, _db.reviews);
  $$AppNotificationsTableTableManager get appNotifications =>
      $$AppNotificationsTableTableManager(_db, _db.appNotifications);
  $$FavoritesTableTableManager get favorites =>
      $$FavoritesTableTableManager(_db, _db.favorites);
}
