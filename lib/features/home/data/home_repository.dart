import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_endpoints.dart';
import '../../../core/errors/app_exception.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/network/dio_client.dart';
import '../../../shared/models/home_data_model.dart';

/// Repository fetching curated home data from `GET /api/v1/home`.
class HomeRepository {
  const HomeRepository(this._dio);

  final Dio _dio;

  Future<HomeDataModel> fetchHomeData() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(ApiEndpoints.home);
      final data = response.data?['data'];
      if (data is Map<String, dynamic>) {
        return HomeDataModel.fromJson(data);
      }
      throw const UnknownAppException('Format data beranda tidak valid.');
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }
}

final homeRepositoryProvider = Provider<HomeRepository>(
  (ref) => HomeRepository(ref.watch(dioProvider)),
);
