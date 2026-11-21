// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CityStatModel {

 String get city;@JsonKey(fromJson: intFromJson) int get kosCount;
/// Create a copy of CityStatModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CityStatModelCopyWith<CityStatModel> get copyWith => _$CityStatModelCopyWithImpl<CityStatModel>(this as CityStatModel, _$identity);

  /// Serializes this CityStatModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CityStatModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CityStatModel&&(identical(other.city, _this.city) || other.city == _this.city)&&(identical(other.kosCount, _this.kosCount) || other.kosCount == _this.kosCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CityStatModel;
  return Object.hash(runtimeType,_this.city,_this.kosCount);
}

@override
String toString() {
  final _this = this as CityStatModel;
  return 'CityStatModel(city: ${_this.city}, kosCount: ${_this.kosCount})';
}


}

/// @nodoc
abstract mixin class $CityStatModelCopyWith<$Res>  {
  factory $CityStatModelCopyWith(CityStatModel value, $Res Function(CityStatModel) _then) = _$CityStatModelCopyWithImpl;
@useResult
$Res call({
 String city,@JsonKey(fromJson: intFromJson) int kosCount
});




}
/// @nodoc
class _$CityStatModelCopyWithImpl<$Res>
    implements $CityStatModelCopyWith<$Res> {
  _$CityStatModelCopyWithImpl(this._self, this._then);

  final CityStatModel _self;
  final $Res Function(CityStatModel) _then;

/// Create a copy of CityStatModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? city = null,Object? kosCount = null,}) {
  return _then(CityStatModel(
city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,kosCount: null == kosCount ? _self.kosCount : kosCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CityStatModel].
extension CityStatModelPatterns on CityStatModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CityStatModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CityStatModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CityStatModel value)  $default,){
final _that = this;
switch (_that) {
case _CityStatModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CityStatModel value)?  $default,){
final _that = this;
switch (_that) {
case _CityStatModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String city, @JsonKey(fromJson: intFromJson)  int kosCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CityStatModel() when $default != null:
return $default(_that.city,_that.kosCount);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String city, @JsonKey(fromJson: intFromJson)  int kosCount)  $default,) {final _that = this;
switch (_that) {
case _CityStatModel():
return $default(_that.city,_that.kosCount);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String city, @JsonKey(fromJson: intFromJson)  int kosCount)?  $default,) {final _that = this;
switch (_that) {
case _CityStatModel() when $default != null:
return $default(_that.city,_that.kosCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CityStatModel implements CityStatModel {
  const _CityStatModel({required this.city, @JsonKey(fromJson: intFromJson) this.kosCount = 0});
  factory _CityStatModel.fromJson(Map<String, dynamic> json) => _$CityStatModelFromJson(json);

@override final  String city;
@override@JsonKey(fromJson: intFromJson) final  int kosCount;

/// Create a copy of CityStatModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CityStatModelCopyWith<_CityStatModel> get copyWith => __$CityStatModelCopyWithImpl<_CityStatModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CityStatModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CityStatModel&&(identical(other.city, city) || other.city == city)&&(identical(other.kosCount, kosCount) || other.kosCount == kosCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,city,kosCount);
}

@override
String toString() {
    return 'CityStatModel(city: $city, kosCount: $kosCount)';
}


}

/// @nodoc
abstract mixin class _$CityStatModelCopyWith<$Res> implements $CityStatModelCopyWith<$Res> {
  factory _$CityStatModelCopyWith(_CityStatModel value, $Res Function(_CityStatModel) _then) = __$CityStatModelCopyWithImpl;
@override @useResult
$Res call({
 String city,@JsonKey(fromJson: intFromJson) int kosCount
});




}
/// @nodoc
class __$CityStatModelCopyWithImpl<$Res>
    implements _$CityStatModelCopyWith<$Res> {
  __$CityStatModelCopyWithImpl(this._self, this._then);

  final _CityStatModel _self;
  final $Res Function(_CityStatModel) _then;

/// Create a copy of CityStatModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? city = null,Object? kosCount = null,}) {
  return _then(_CityStatModel(
city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,kosCount: null == kosCount ? _self.kosCount : kosCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$HomeDataModel {

 List<KosSummaryModel> get featuredKos; List<CityStatModel> get popularCities; List<FacilityModel> get facilities;
/// Create a copy of HomeDataModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeDataModelCopyWith<HomeDataModel> get copyWith => _$HomeDataModelCopyWithImpl<HomeDataModel>(this as HomeDataModel, _$identity);

  /// Serializes this HomeDataModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as HomeDataModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeDataModel&&const DeepCollectionEquality().equals(other.featuredKos, _this.featuredKos)&&const DeepCollectionEquality().equals(other.popularCities, _this.popularCities)&&const DeepCollectionEquality().equals(other.facilities, _this.facilities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as HomeDataModel;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.featuredKos),const DeepCollectionEquality().hash(_this.popularCities),const DeepCollectionEquality().hash(_this.facilities));
}

@override
String toString() {
  final _this = this as HomeDataModel;
  return 'HomeDataModel(featuredKos: ${_this.featuredKos}, popularCities: ${_this.popularCities}, facilities: ${_this.facilities})';
}


}

/// @nodoc
abstract mixin class $HomeDataModelCopyWith<$Res>  {
  factory $HomeDataModelCopyWith(HomeDataModel value, $Res Function(HomeDataModel) _then) = _$HomeDataModelCopyWithImpl;
@useResult
$Res call({
 List<KosSummaryModel> featuredKos, List<CityStatModel> popularCities, List<FacilityModel> facilities
});




}
/// @nodoc
class _$HomeDataModelCopyWithImpl<$Res>
    implements $HomeDataModelCopyWith<$Res> {
  _$HomeDataModelCopyWithImpl(this._self, this._then);

  final HomeDataModel _self;
  final $Res Function(HomeDataModel) _then;

/// Create a copy of HomeDataModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? featuredKos = null,Object? popularCities = null,Object? facilities = null,}) {
  return _then(HomeDataModel(
featuredKos: null == featuredKos ? _self.featuredKos : featuredKos // ignore: cast_nullable_to_non_nullable
as List<KosSummaryModel>,popularCities: null == popularCities ? _self.popularCities : popularCities // ignore: cast_nullable_to_non_nullable
as List<CityStatModel>,facilities: null == facilities ? _self.facilities : facilities // ignore: cast_nullable_to_non_nullable
as List<FacilityModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeDataModel].
extension HomeDataModelPatterns on HomeDataModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeDataModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeDataModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeDataModel value)  $default,){
final _that = this;
switch (_that) {
case _HomeDataModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeDataModel value)?  $default,){
final _that = this;
switch (_that) {
case _HomeDataModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<KosSummaryModel> featuredKos,  List<CityStatModel> popularCities,  List<FacilityModel> facilities)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeDataModel() when $default != null:
return $default(_that.featuredKos,_that.popularCities,_that.facilities);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<KosSummaryModel> featuredKos,  List<CityStatModel> popularCities,  List<FacilityModel> facilities)  $default,) {final _that = this;
switch (_that) {
case _HomeDataModel():
return $default(_that.featuredKos,_that.popularCities,_that.facilities);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<KosSummaryModel> featuredKos,  List<CityStatModel> popularCities,  List<FacilityModel> facilities)?  $default,) {final _that = this;
switch (_that) {
case _HomeDataModel() when $default != null:
return $default(_that.featuredKos,_that.popularCities,_that.facilities);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HomeDataModel implements HomeDataModel {
  const _HomeDataModel({ List<KosSummaryModel> featuredKos = const [],  List<CityStatModel> popularCities = const [],  List<FacilityModel> facilities = const []}): _featuredKos = featuredKos,_popularCities = popularCities,_facilities = facilities;
  factory _HomeDataModel.fromJson(Map<String, dynamic> json) => _$HomeDataModelFromJson(json);

 final  List<KosSummaryModel> _featuredKos;
@override@JsonKey() List<KosSummaryModel> get featuredKos {
  if (_featuredKos is EqualUnmodifiableListView) return _featuredKos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_featuredKos);
}

 final  List<CityStatModel> _popularCities;
@override@JsonKey() List<CityStatModel> get popularCities {
  if (_popularCities is EqualUnmodifiableListView) return _popularCities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_popularCities);
}

 final  List<FacilityModel> _facilities;
@override@JsonKey() List<FacilityModel> get facilities {
  if (_facilities is EqualUnmodifiableListView) return _facilities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_facilities);
}


/// Create a copy of HomeDataModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeDataModelCopyWith<_HomeDataModel> get copyWith => __$HomeDataModelCopyWithImpl<_HomeDataModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeDataModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeDataModel&&const DeepCollectionEquality().equals(other.featuredKos, _featuredKos)&&const DeepCollectionEquality().equals(other.popularCities, _popularCities)&&const DeepCollectionEquality().equals(other.facilities, _facilities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_featuredKos),const DeepCollectionEquality().hash(_popularCities),const DeepCollectionEquality().hash(_facilities));
}

@override
String toString() {
    return 'HomeDataModel(featuredKos: $featuredKos, popularCities: $popularCities, facilities: $facilities)';
}


}

/// @nodoc
abstract mixin class _$HomeDataModelCopyWith<$Res> implements $HomeDataModelCopyWith<$Res> {
  factory _$HomeDataModelCopyWith(_HomeDataModel value, $Res Function(_HomeDataModel) _then) = __$HomeDataModelCopyWithImpl;
@override @useResult
$Res call({
 List<KosSummaryModel> featuredKos, List<CityStatModel> popularCities, List<FacilityModel> facilities
});




}
/// @nodoc
class __$HomeDataModelCopyWithImpl<$Res>
    implements _$HomeDataModelCopyWith<$Res> {
  __$HomeDataModelCopyWithImpl(this._self, this._then);

  final _HomeDataModel _self;
  final $Res Function(_HomeDataModel) _then;

/// Create a copy of HomeDataModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? featuredKos = null,Object? popularCities = null,Object? facilities = null,}) {
  return _then(_HomeDataModel(
featuredKos: null == featuredKos ? _self._featuredKos : featuredKos // ignore: cast_nullable_to_non_nullable
as List<KosSummaryModel>,popularCities: null == popularCities ? _self._popularCities : popularCities // ignore: cast_nullable_to_non_nullable
as List<CityStatModel>,facilities: null == facilities ? _self._facilities : facilities // ignore: cast_nullable_to_non_nullable
as List<FacilityModel>,
  ));
}


}

// dart format on
