import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/utils/json_converters.dart';
import 'facility_model.dart';
import 'kos_models.dart';

part 'home_data_model.freezed.dart';
part 'home_data_model.g.dart';

@freezed
abstract class CityStatModel with _$CityStatModel {
  const factory CityStatModel({
    required String city,
    @JsonKey(fromJson: intFromJson) @Default(0) int kosCount,
  }) = _CityStatModel;

  factory CityStatModel.fromJson(Map<String, dynamic> json) =>
      _$CityStatModelFromJson(json);
}

@freezed
abstract class HomeDataModel with _$HomeDataModel {
  const factory HomeDataModel({
    @Default([]) List<KosSummaryModel> featuredKos,
    @Default([]) List<CityStatModel> popularCities,
    @Default([]) List<FacilityModel> facilities,
  }) = _HomeDataModel;

  factory HomeDataModel.fromJson(Map<String, dynamic> json) =>
      _$HomeDataModelFromJson(json);
}
