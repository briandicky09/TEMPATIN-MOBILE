// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CityStatModel _$CityStatModelFromJson(Map<String, dynamic> json) =>
    _CityStatModel(
      city: json['city'] as String,
      kosCount: json['kos_count'] == null ? 0 : intFromJson(json['kos_count']),
    );

Map<String, dynamic> _$CityStatModelToJson(_CityStatModel instance) =>
    <String, dynamic>{'city': instance.city, 'kos_count': instance.kosCount};

_HomeDataModel _$HomeDataModelFromJson(Map<String, dynamic> json) =>
    _HomeDataModel(
      featuredKos:
          (json['featured_kos'] as List<dynamic>?)
              ?.map((e) => KosSummaryModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      popularCities:
          (json['popular_cities'] as List<dynamic>?)
              ?.map((e) => CityStatModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      facilities:
          (json['facilities'] as List<dynamic>?)
              ?.map((e) => FacilityModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$HomeDataModelToJson(_HomeDataModel instance) =>
    <String, dynamic>{
      'featured_kos': instance.featuredKos.map((e) => e.toJson()).toList(),
      'popular_cities': instance.popularCities.map((e) => e.toJson()).toList(),
      'facilities': instance.facilities.map((e) => e.toJson()).toList(),
    };
