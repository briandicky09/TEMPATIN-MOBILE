import 'package:freezed_annotation/freezed_annotation.dart';

part 'facility_model.freezed.dart';
part 'facility_model.g.dart';

/// Master facility matching `facilities` table (`id`, `name`, `slug`).
@freezed
abstract class FacilityModel with _$FacilityModel {
  const factory FacilityModel({
    required int id,
    required String name,
    required String slug,
  }) = _FacilityModel;

  factory FacilityModel.fromJson(Map<String, dynamic> json) =>
      _$FacilityModelFromJson(json);
}
