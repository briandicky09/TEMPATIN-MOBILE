// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kos_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OwnerSummaryModel {

 int get id; String get name; String? get phone; String? get avatarUrl;
/// Create a copy of OwnerSummaryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OwnerSummaryModelCopyWith<OwnerSummaryModel> get copyWith => _$OwnerSummaryModelCopyWithImpl<OwnerSummaryModel>(this as OwnerSummaryModel, _$identity);

  /// Serializes this OwnerSummaryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as OwnerSummaryModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OwnerSummaryModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.phone, _this.phone) || other.phone == _this.phone)&&(identical(other.avatarUrl, _this.avatarUrl) || other.avatarUrl == _this.avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as OwnerSummaryModel;
  return Object.hash(runtimeType,_this.id,_this.name,_this.phone,_this.avatarUrl);
}

@override
String toString() {
  final _this = this as OwnerSummaryModel;
  return 'OwnerSummaryModel(id: ${_this.id}, name: ${_this.name}, phone: ${_this.phone}, avatarUrl: ${_this.avatarUrl})';
}


}

/// @nodoc
abstract mixin class $OwnerSummaryModelCopyWith<$Res>  {
  factory $OwnerSummaryModelCopyWith(OwnerSummaryModel value, $Res Function(OwnerSummaryModel) _then) = _$OwnerSummaryModelCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? phone, String? avatarUrl
});




}
/// @nodoc
class _$OwnerSummaryModelCopyWithImpl<$Res>
    implements $OwnerSummaryModelCopyWith<$Res> {
  _$OwnerSummaryModelCopyWithImpl(this._self, this._then);

  final OwnerSummaryModel _self;
  final $Res Function(OwnerSummaryModel) _then;

/// Create a copy of OwnerSummaryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? phone = freezed,Object? avatarUrl = freezed,}) {
  return _then(OwnerSummaryModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OwnerSummaryModel].
extension OwnerSummaryModelPatterns on OwnerSummaryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OwnerSummaryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OwnerSummaryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OwnerSummaryModel value)  $default,){
final _that = this;
switch (_that) {
case _OwnerSummaryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OwnerSummaryModel value)?  $default,){
final _that = this;
switch (_that) {
case _OwnerSummaryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? phone,  String? avatarUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OwnerSummaryModel() when $default != null:
return $default(_that.id,_that.name,_that.phone,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? phone,  String? avatarUrl)  $default,) {final _that = this;
switch (_that) {
case _OwnerSummaryModel():
return $default(_that.id,_that.name,_that.phone,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? phone,  String? avatarUrl)?  $default,) {final _that = this;
switch (_that) {
case _OwnerSummaryModel() when $default != null:
return $default(_that.id,_that.name,_that.phone,_that.avatarUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OwnerSummaryModel implements OwnerSummaryModel {
  const _OwnerSummaryModel({required this.id, required this.name, this.phone, this.avatarUrl});
  factory _OwnerSummaryModel.fromJson(Map<String, dynamic> json) => _$OwnerSummaryModelFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? phone;
@override final  String? avatarUrl;

/// Create a copy of OwnerSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OwnerSummaryModelCopyWith<_OwnerSummaryModel> get copyWith => __$OwnerSummaryModelCopyWithImpl<_OwnerSummaryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OwnerSummaryModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OwnerSummaryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,phone,avatarUrl);
}

@override
String toString() {
    return 'OwnerSummaryModel(id: $id, name: $name, phone: $phone, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class _$OwnerSummaryModelCopyWith<$Res> implements $OwnerSummaryModelCopyWith<$Res> {
  factory _$OwnerSummaryModelCopyWith(_OwnerSummaryModel value, $Res Function(_OwnerSummaryModel) _then) = __$OwnerSummaryModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? phone, String? avatarUrl
});




}
/// @nodoc
class __$OwnerSummaryModelCopyWithImpl<$Res>
    implements _$OwnerSummaryModelCopyWith<$Res> {
  __$OwnerSummaryModelCopyWithImpl(this._self, this._then);

  final _OwnerSummaryModel _self;
  final $Res Function(_OwnerSummaryModel) _then;

/// Create a copy of OwnerSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? phone = freezed,Object? avatarUrl = freezed,}) {
  return _then(_OwnerSummaryModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$KosPhotoModel {

 int get id; String get photoUrl; int get sortOrder;
/// Create a copy of KosPhotoModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KosPhotoModelCopyWith<KosPhotoModel> get copyWith => _$KosPhotoModelCopyWithImpl<KosPhotoModel>(this as KosPhotoModel, _$identity);

  /// Serializes this KosPhotoModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as KosPhotoModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KosPhotoModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.photoUrl, _this.photoUrl) || other.photoUrl == _this.photoUrl)&&(identical(other.sortOrder, _this.sortOrder) || other.sortOrder == _this.sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as KosPhotoModel;
  return Object.hash(runtimeType,_this.id,_this.photoUrl,_this.sortOrder);
}

@override
String toString() {
  final _this = this as KosPhotoModel;
  return 'KosPhotoModel(id: ${_this.id}, photoUrl: ${_this.photoUrl}, sortOrder: ${_this.sortOrder})';
}


}

/// @nodoc
abstract mixin class $KosPhotoModelCopyWith<$Res>  {
  factory $KosPhotoModelCopyWith(KosPhotoModel value, $Res Function(KosPhotoModel) _then) = _$KosPhotoModelCopyWithImpl;
@useResult
$Res call({
 int id, String photoUrl, int sortOrder
});




}
/// @nodoc
class _$KosPhotoModelCopyWithImpl<$Res>
    implements $KosPhotoModelCopyWith<$Res> {
  _$KosPhotoModelCopyWithImpl(this._self, this._then);

  final KosPhotoModel _self;
  final $Res Function(KosPhotoModel) _then;

/// Create a copy of KosPhotoModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? photoUrl = null,Object? sortOrder = null,}) {
  return _then(KosPhotoModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,photoUrl: null == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [KosPhotoModel].
extension KosPhotoModelPatterns on KosPhotoModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KosPhotoModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KosPhotoModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KosPhotoModel value)  $default,){
final _that = this;
switch (_that) {
case _KosPhotoModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KosPhotoModel value)?  $default,){
final _that = this;
switch (_that) {
case _KosPhotoModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String photoUrl,  int sortOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KosPhotoModel() when $default != null:
return $default(_that.id,_that.photoUrl,_that.sortOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String photoUrl,  int sortOrder)  $default,) {final _that = this;
switch (_that) {
case _KosPhotoModel():
return $default(_that.id,_that.photoUrl,_that.sortOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String photoUrl,  int sortOrder)?  $default,) {final _that = this;
switch (_that) {
case _KosPhotoModel() when $default != null:
return $default(_that.id,_that.photoUrl,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KosPhotoModel implements KosPhotoModel {
  const _KosPhotoModel({required this.id, required this.photoUrl, this.sortOrder = 0});
  factory _KosPhotoModel.fromJson(Map<String, dynamic> json) => _$KosPhotoModelFromJson(json);

@override final  int id;
@override final  String photoUrl;
@override@JsonKey() final  int sortOrder;

/// Create a copy of KosPhotoModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KosPhotoModelCopyWith<_KosPhotoModel> get copyWith => __$KosPhotoModelCopyWithImpl<_KosPhotoModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KosPhotoModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _KosPhotoModel&&(identical(other.id, id) || other.id == id)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,photoUrl,sortOrder);
}

@override
String toString() {
    return 'KosPhotoModel(id: $id, photoUrl: $photoUrl, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$KosPhotoModelCopyWith<$Res> implements $KosPhotoModelCopyWith<$Res> {
  factory _$KosPhotoModelCopyWith(_KosPhotoModel value, $Res Function(_KosPhotoModel) _then) = __$KosPhotoModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String photoUrl, int sortOrder
});




}
/// @nodoc
class __$KosPhotoModelCopyWithImpl<$Res>
    implements _$KosPhotoModelCopyWith<$Res> {
  __$KosPhotoModelCopyWithImpl(this._self, this._then);

  final _KosPhotoModel _self;
  final $Res Function(_KosPhotoModel) _then;

/// Create a copy of KosPhotoModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? photoUrl = null,Object? sortOrder = null,}) {
  return _then(_KosPhotoModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,photoUrl: null == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$RoomModel {

 int get id; String get roomNumber; String? get floor; String? get roomType;@JsonKey(fromJson: nullableDoubleFromJson) double? get priceOverride;@JsonKey(fromJson: doubleFromJson) double get effectivePrice; String get status; String? get notes;
/// Create a copy of RoomModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoomModelCopyWith<RoomModel> get copyWith => _$RoomModelCopyWithImpl<RoomModel>(this as RoomModel, _$identity);

  /// Serializes this RoomModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RoomModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoomModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.roomNumber, _this.roomNumber) || other.roomNumber == _this.roomNumber)&&(identical(other.floor, _this.floor) || other.floor == _this.floor)&&(identical(other.roomType, _this.roomType) || other.roomType == _this.roomType)&&(identical(other.priceOverride, _this.priceOverride) || other.priceOverride == _this.priceOverride)&&(identical(other.effectivePrice, _this.effectivePrice) || other.effectivePrice == _this.effectivePrice)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.notes, _this.notes) || other.notes == _this.notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RoomModel;
  return Object.hash(runtimeType,_this.id,_this.roomNumber,_this.floor,_this.roomType,_this.priceOverride,_this.effectivePrice,_this.status,_this.notes);
}

@override
String toString() {
  final _this = this as RoomModel;
  return 'RoomModel(id: ${_this.id}, roomNumber: ${_this.roomNumber}, floor: ${_this.floor}, roomType: ${_this.roomType}, priceOverride: ${_this.priceOverride}, effectivePrice: ${_this.effectivePrice}, status: ${_this.status}, notes: ${_this.notes})';
}


}

/// @nodoc
abstract mixin class $RoomModelCopyWith<$Res>  {
  factory $RoomModelCopyWith(RoomModel value, $Res Function(RoomModel) _then) = _$RoomModelCopyWithImpl;
@useResult
$Res call({
 int id, String roomNumber, String? floor, String? roomType,@JsonKey(fromJson: nullableDoubleFromJson) double? priceOverride,@JsonKey(fromJson: doubleFromJson) double effectivePrice, String status, String? notes
});




}
/// @nodoc
class _$RoomModelCopyWithImpl<$Res>
    implements $RoomModelCopyWith<$Res> {
  _$RoomModelCopyWithImpl(this._self, this._then);

  final RoomModel _self;
  final $Res Function(RoomModel) _then;

/// Create a copy of RoomModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? roomNumber = null,Object? floor = freezed,Object? roomType = freezed,Object? priceOverride = freezed,Object? effectivePrice = null,Object? status = null,Object? notes = freezed,}) {
  return _then(RoomModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,roomNumber: null == roomNumber ? _self.roomNumber : roomNumber // ignore: cast_nullable_to_non_nullable
as String,floor: freezed == floor ? _self.floor : floor // ignore: cast_nullable_to_non_nullable
as String?,roomType: freezed == roomType ? _self.roomType : roomType // ignore: cast_nullable_to_non_nullable
as String?,priceOverride: freezed == priceOverride ? _self.priceOverride : priceOverride // ignore: cast_nullable_to_non_nullable
as double?,effectivePrice: null == effectivePrice ? _self.effectivePrice : effectivePrice // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RoomModel].
extension RoomModelPatterns on RoomModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoomModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoomModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoomModel value)  $default,){
final _that = this;
switch (_that) {
case _RoomModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoomModel value)?  $default,){
final _that = this;
switch (_that) {
case _RoomModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String roomNumber,  String? floor,  String? roomType, @JsonKey(fromJson: nullableDoubleFromJson)  double? priceOverride, @JsonKey(fromJson: doubleFromJson)  double effectivePrice,  String status,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoomModel() when $default != null:
return $default(_that.id,_that.roomNumber,_that.floor,_that.roomType,_that.priceOverride,_that.effectivePrice,_that.status,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String roomNumber,  String? floor,  String? roomType, @JsonKey(fromJson: nullableDoubleFromJson)  double? priceOverride, @JsonKey(fromJson: doubleFromJson)  double effectivePrice,  String status,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _RoomModel():
return $default(_that.id,_that.roomNumber,_that.floor,_that.roomType,_that.priceOverride,_that.effectivePrice,_that.status,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String roomNumber,  String? floor,  String? roomType, @JsonKey(fromJson: nullableDoubleFromJson)  double? priceOverride, @JsonKey(fromJson: doubleFromJson)  double effectivePrice,  String status,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _RoomModel() when $default != null:
return $default(_that.id,_that.roomNumber,_that.floor,_that.roomType,_that.priceOverride,_that.effectivePrice,_that.status,_that.notes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RoomModel implements RoomModel {
  const _RoomModel({required this.id, required this.roomNumber, this.floor, this.roomType, @JsonKey(fromJson: nullableDoubleFromJson) this.priceOverride, @JsonKey(fromJson: doubleFromJson) this.effectivePrice = 0.0, this.status = 'available', this.notes});
  factory _RoomModel.fromJson(Map<String, dynamic> json) => _$RoomModelFromJson(json);

@override final  int id;
@override final  String roomNumber;
@override final  String? floor;
@override final  String? roomType;
@override@JsonKey(fromJson: nullableDoubleFromJson) final  double? priceOverride;
@override@JsonKey(fromJson: doubleFromJson) final  double effectivePrice;
@override@JsonKey() final  String status;
@override final  String? notes;

/// Create a copy of RoomModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoomModelCopyWith<_RoomModel> get copyWith => __$RoomModelCopyWithImpl<_RoomModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoomModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoomModel&&(identical(other.id, id) || other.id == id)&&(identical(other.roomNumber, roomNumber) || other.roomNumber == roomNumber)&&(identical(other.floor, floor) || other.floor == floor)&&(identical(other.roomType, roomType) || other.roomType == roomType)&&(identical(other.priceOverride, priceOverride) || other.priceOverride == priceOverride)&&(identical(other.effectivePrice, effectivePrice) || other.effectivePrice == effectivePrice)&&(identical(other.status, status) || other.status == status)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,roomNumber,floor,roomType,priceOverride,effectivePrice,status,notes);
}

@override
String toString() {
    return 'RoomModel(id: $id, roomNumber: $roomNumber, floor: $floor, roomType: $roomType, priceOverride: $priceOverride, effectivePrice: $effectivePrice, status: $status, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$RoomModelCopyWith<$Res> implements $RoomModelCopyWith<$Res> {
  factory _$RoomModelCopyWith(_RoomModel value, $Res Function(_RoomModel) _then) = __$RoomModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String roomNumber, String? floor, String? roomType,@JsonKey(fromJson: nullableDoubleFromJson) double? priceOverride,@JsonKey(fromJson: doubleFromJson) double effectivePrice, String status, String? notes
});




}
/// @nodoc
class __$RoomModelCopyWithImpl<$Res>
    implements _$RoomModelCopyWith<$Res> {
  __$RoomModelCopyWithImpl(this._self, this._then);

  final _RoomModel _self;
  final $Res Function(_RoomModel) _then;

/// Create a copy of RoomModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? roomNumber = null,Object? floor = freezed,Object? roomType = freezed,Object? priceOverride = freezed,Object? effectivePrice = null,Object? status = null,Object? notes = freezed,}) {
  return _then(_RoomModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,roomNumber: null == roomNumber ? _self.roomNumber : roomNumber // ignore: cast_nullable_to_non_nullable
as String,floor: freezed == floor ? _self.floor : floor // ignore: cast_nullable_to_non_nullable
as String?,roomType: freezed == roomType ? _self.roomType : roomType // ignore: cast_nullable_to_non_nullable
as String?,priceOverride: freezed == priceOverride ? _self.priceOverride : priceOverride // ignore: cast_nullable_to_non_nullable
as double?,effectivePrice: null == effectivePrice ? _self.effectivePrice : effectivePrice // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ReviewModel {

 int get id; String get reviewerName; bool get isVerifiedTenant; int get rating; String get comment; String? get reply; String? get userAvatarUrl; DateTime? get createdAt;
/// Create a copy of ReviewModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReviewModelCopyWith<ReviewModel> get copyWith => _$ReviewModelCopyWithImpl<ReviewModel>(this as ReviewModel, _$identity);

  /// Serializes this ReviewModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ReviewModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.reviewerName, _this.reviewerName) || other.reviewerName == _this.reviewerName)&&(identical(other.isVerifiedTenant, _this.isVerifiedTenant) || other.isVerifiedTenant == _this.isVerifiedTenant)&&(identical(other.rating, _this.rating) || other.rating == _this.rating)&&(identical(other.comment, _this.comment) || other.comment == _this.comment)&&(identical(other.reply, _this.reply) || other.reply == _this.reply)&&(identical(other.userAvatarUrl, _this.userAvatarUrl) || other.userAvatarUrl == _this.userAvatarUrl)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ReviewModel;
  return Object.hash(runtimeType,_this.id,_this.reviewerName,_this.isVerifiedTenant,_this.rating,_this.comment,_this.reply,_this.userAvatarUrl,_this.createdAt);
}

@override
String toString() {
  final _this = this as ReviewModel;
  return 'ReviewModel(id: ${_this.id}, reviewerName: ${_this.reviewerName}, isVerifiedTenant: ${_this.isVerifiedTenant}, rating: ${_this.rating}, comment: ${_this.comment}, reply: ${_this.reply}, userAvatarUrl: ${_this.userAvatarUrl}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $ReviewModelCopyWith<$Res>  {
  factory $ReviewModelCopyWith(ReviewModel value, $Res Function(ReviewModel) _then) = _$ReviewModelCopyWithImpl;
@useResult
$Res call({
 int id, String reviewerName, bool isVerifiedTenant, int rating, String comment, String? reply, String? userAvatarUrl, DateTime? createdAt
});




}
/// @nodoc
class _$ReviewModelCopyWithImpl<$Res>
    implements $ReviewModelCopyWith<$Res> {
  _$ReviewModelCopyWithImpl(this._self, this._then);

  final ReviewModel _self;
  final $Res Function(ReviewModel) _then;

/// Create a copy of ReviewModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? reviewerName = null,Object? isVerifiedTenant = null,Object? rating = null,Object? comment = null,Object? reply = freezed,Object? userAvatarUrl = freezed,Object? createdAt = freezed,}) {
  return _then(ReviewModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,reviewerName: null == reviewerName ? _self.reviewerName : reviewerName // ignore: cast_nullable_to_non_nullable
as String,isVerifiedTenant: null == isVerifiedTenant ? _self.isVerifiedTenant : isVerifiedTenant // ignore: cast_nullable_to_non_nullable
as bool,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,reply: freezed == reply ? _self.reply : reply // ignore: cast_nullable_to_non_nullable
as String?,userAvatarUrl: freezed == userAvatarUrl ? _self.userAvatarUrl : userAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReviewModel].
extension ReviewModelPatterns on ReviewModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReviewModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReviewModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReviewModel value)  $default,){
final _that = this;
switch (_that) {
case _ReviewModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReviewModel value)?  $default,){
final _that = this;
switch (_that) {
case _ReviewModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String reviewerName,  bool isVerifiedTenant,  int rating,  String comment,  String? reply,  String? userAvatarUrl,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReviewModel() when $default != null:
return $default(_that.id,_that.reviewerName,_that.isVerifiedTenant,_that.rating,_that.comment,_that.reply,_that.userAvatarUrl,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String reviewerName,  bool isVerifiedTenant,  int rating,  String comment,  String? reply,  String? userAvatarUrl,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _ReviewModel():
return $default(_that.id,_that.reviewerName,_that.isVerifiedTenant,_that.rating,_that.comment,_that.reply,_that.userAvatarUrl,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String reviewerName,  bool isVerifiedTenant,  int rating,  String comment,  String? reply,  String? userAvatarUrl,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ReviewModel() when $default != null:
return $default(_that.id,_that.reviewerName,_that.isVerifiedTenant,_that.rating,_that.comment,_that.reply,_that.userAvatarUrl,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReviewModel implements ReviewModel {
  const _ReviewModel({required this.id, required this.reviewerName, this.isVerifiedTenant = false, this.rating = 5, required this.comment, this.reply, this.userAvatarUrl, this.createdAt});
  factory _ReviewModel.fromJson(Map<String, dynamic> json) => _$ReviewModelFromJson(json);

@override final  int id;
@override final  String reviewerName;
@override@JsonKey() final  bool isVerifiedTenant;
@override@JsonKey() final  int rating;
@override final  String comment;
@override final  String? reply;
@override final  String? userAvatarUrl;
@override final  DateTime? createdAt;

/// Create a copy of ReviewModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReviewModelCopyWith<_ReviewModel> get copyWith => __$ReviewModelCopyWithImpl<_ReviewModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReviewModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReviewModel&&(identical(other.id, id) || other.id == id)&&(identical(other.reviewerName, reviewerName) || other.reviewerName == reviewerName)&&(identical(other.isVerifiedTenant, isVerifiedTenant) || other.isVerifiedTenant == isVerifiedTenant)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.reply, reply) || other.reply == reply)&&(identical(other.userAvatarUrl, userAvatarUrl) || other.userAvatarUrl == userAvatarUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,reviewerName,isVerifiedTenant,rating,comment,reply,userAvatarUrl,createdAt);
}

@override
String toString() {
    return 'ReviewModel(id: $id, reviewerName: $reviewerName, isVerifiedTenant: $isVerifiedTenant, rating: $rating, comment: $comment, reply: $reply, userAvatarUrl: $userAvatarUrl, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ReviewModelCopyWith<$Res> implements $ReviewModelCopyWith<$Res> {
  factory _$ReviewModelCopyWith(_ReviewModel value, $Res Function(_ReviewModel) _then) = __$ReviewModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String reviewerName, bool isVerifiedTenant, int rating, String comment, String? reply, String? userAvatarUrl, DateTime? createdAt
});




}
/// @nodoc
class __$ReviewModelCopyWithImpl<$Res>
    implements _$ReviewModelCopyWith<$Res> {
  __$ReviewModelCopyWithImpl(this._self, this._then);

  final _ReviewModel _self;
  final $Res Function(_ReviewModel) _then;

/// Create a copy of ReviewModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? reviewerName = null,Object? isVerifiedTenant = null,Object? rating = null,Object? comment = null,Object? reply = freezed,Object? userAvatarUrl = freezed,Object? createdAt = freezed,}) {
  return _then(_ReviewModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,reviewerName: null == reviewerName ? _self.reviewerName : reviewerName // ignore: cast_nullable_to_non_nullable
as String,isVerifiedTenant: null == isVerifiedTenant ? _self.isVerifiedTenant : isVerifiedTenant // ignore: cast_nullable_to_non_nullable
as bool,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,reply: freezed == reply ? _self.reply : reply // ignore: cast_nullable_to_non_nullable
as String?,userAvatarUrl: freezed == userAvatarUrl ? _self.userAvatarUrl : userAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$KosSummaryModel {

 int get id; String get title; String get slug;@JsonKey(fromJson: doubleFromJson) double get price; String get type; String get city; String? get address; String get thumbnailUrl; String get status;@JsonKey(fromJson: doubleFromJson) double get rating;@JsonKey(fromJson: intFromJson) int get reviewCount; bool get isFavorited; int? get availableRoomsCount; List<FacilityModel> get facilities;
/// Create a copy of KosSummaryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KosSummaryModelCopyWith<KosSummaryModel> get copyWith => _$KosSummaryModelCopyWithImpl<KosSummaryModel>(this as KosSummaryModel, _$identity);

  /// Serializes this KosSummaryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as KosSummaryModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KosSummaryModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.slug, _this.slug) || other.slug == _this.slug)&&(identical(other.price, _this.price) || other.price == _this.price)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.city, _this.city) || other.city == _this.city)&&(identical(other.address, _this.address) || other.address == _this.address)&&(identical(other.thumbnailUrl, _this.thumbnailUrl) || other.thumbnailUrl == _this.thumbnailUrl)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.rating, _this.rating) || other.rating == _this.rating)&&(identical(other.reviewCount, _this.reviewCount) || other.reviewCount == _this.reviewCount)&&(identical(other.isFavorited, _this.isFavorited) || other.isFavorited == _this.isFavorited)&&(identical(other.availableRoomsCount, _this.availableRoomsCount) || other.availableRoomsCount == _this.availableRoomsCount)&&const DeepCollectionEquality().equals(other.facilities, _this.facilities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as KosSummaryModel;
  return Object.hash(runtimeType,_this.id,_this.title,_this.slug,_this.price,_this.type,_this.city,_this.address,_this.thumbnailUrl,_this.status,_this.rating,_this.reviewCount,_this.isFavorited,_this.availableRoomsCount,const DeepCollectionEquality().hash(_this.facilities));
}

@override
String toString() {
  final _this = this as KosSummaryModel;
  return 'KosSummaryModel(id: ${_this.id}, title: ${_this.title}, slug: ${_this.slug}, price: ${_this.price}, type: ${_this.type}, city: ${_this.city}, address: ${_this.address}, thumbnailUrl: ${_this.thumbnailUrl}, status: ${_this.status}, rating: ${_this.rating}, reviewCount: ${_this.reviewCount}, isFavorited: ${_this.isFavorited}, availableRoomsCount: ${_this.availableRoomsCount}, facilities: ${_this.facilities})';
}


}

/// @nodoc
abstract mixin class $KosSummaryModelCopyWith<$Res>  {
  factory $KosSummaryModelCopyWith(KosSummaryModel value, $Res Function(KosSummaryModel) _then) = _$KosSummaryModelCopyWithImpl;
@useResult
$Res call({
 int id, String title, String slug,@JsonKey(fromJson: doubleFromJson) double price, String type, String city, String? address, String thumbnailUrl, String status,@JsonKey(fromJson: doubleFromJson) double rating,@JsonKey(fromJson: intFromJson) int reviewCount, bool isFavorited, int? availableRoomsCount, List<FacilityModel> facilities
});




}
/// @nodoc
class _$KosSummaryModelCopyWithImpl<$Res>
    implements $KosSummaryModelCopyWith<$Res> {
  _$KosSummaryModelCopyWithImpl(this._self, this._then);

  final KosSummaryModel _self;
  final $Res Function(KosSummaryModel) _then;

/// Create a copy of KosSummaryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? slug = null,Object? price = null,Object? type = null,Object? city = null,Object? address = freezed,Object? thumbnailUrl = null,Object? status = null,Object? rating = null,Object? reviewCount = null,Object? isFavorited = null,Object? availableRoomsCount = freezed,Object? facilities = null,}) {
  return _then(KosSummaryModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: null == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,isFavorited: null == isFavorited ? _self.isFavorited : isFavorited // ignore: cast_nullable_to_non_nullable
as bool,availableRoomsCount: freezed == availableRoomsCount ? _self.availableRoomsCount : availableRoomsCount // ignore: cast_nullable_to_non_nullable
as int?,facilities: null == facilities ? _self.facilities : facilities // ignore: cast_nullable_to_non_nullable
as List<FacilityModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [KosSummaryModel].
extension KosSummaryModelPatterns on KosSummaryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KosSummaryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KosSummaryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KosSummaryModel value)  $default,){
final _that = this;
switch (_that) {
case _KosSummaryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KosSummaryModel value)?  $default,){
final _that = this;
switch (_that) {
case _KosSummaryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String slug, @JsonKey(fromJson: doubleFromJson)  double price,  String type,  String city,  String? address,  String thumbnailUrl,  String status, @JsonKey(fromJson: doubleFromJson)  double rating, @JsonKey(fromJson: intFromJson)  int reviewCount,  bool isFavorited,  int? availableRoomsCount,  List<FacilityModel> facilities)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KosSummaryModel() when $default != null:
return $default(_that.id,_that.title,_that.slug,_that.price,_that.type,_that.city,_that.address,_that.thumbnailUrl,_that.status,_that.rating,_that.reviewCount,_that.isFavorited,_that.availableRoomsCount,_that.facilities);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String slug, @JsonKey(fromJson: doubleFromJson)  double price,  String type,  String city,  String? address,  String thumbnailUrl,  String status, @JsonKey(fromJson: doubleFromJson)  double rating, @JsonKey(fromJson: intFromJson)  int reviewCount,  bool isFavorited,  int? availableRoomsCount,  List<FacilityModel> facilities)  $default,) {final _that = this;
switch (_that) {
case _KosSummaryModel():
return $default(_that.id,_that.title,_that.slug,_that.price,_that.type,_that.city,_that.address,_that.thumbnailUrl,_that.status,_that.rating,_that.reviewCount,_that.isFavorited,_that.availableRoomsCount,_that.facilities);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String slug, @JsonKey(fromJson: doubleFromJson)  double price,  String type,  String city,  String? address,  String thumbnailUrl,  String status, @JsonKey(fromJson: doubleFromJson)  double rating, @JsonKey(fromJson: intFromJson)  int reviewCount,  bool isFavorited,  int? availableRoomsCount,  List<FacilityModel> facilities)?  $default,) {final _that = this;
switch (_that) {
case _KosSummaryModel() when $default != null:
return $default(_that.id,_that.title,_that.slug,_that.price,_that.type,_that.city,_that.address,_that.thumbnailUrl,_that.status,_that.rating,_that.reviewCount,_that.isFavorited,_that.availableRoomsCount,_that.facilities);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KosSummaryModel implements KosSummaryModel {
  const _KosSummaryModel({required this.id, required this.title, required this.slug, @JsonKey(fromJson: doubleFromJson) required this.price, required this.type, required this.city, this.address, required this.thumbnailUrl, this.status = 'active', @JsonKey(fromJson: doubleFromJson) this.rating = 0.0, @JsonKey(fromJson: intFromJson) this.reviewCount = 0, this.isFavorited = false, this.availableRoomsCount,  List<FacilityModel> facilities = const []}): _facilities = facilities;
  factory _KosSummaryModel.fromJson(Map<String, dynamic> json) => _$KosSummaryModelFromJson(json);

@override final  int id;
@override final  String title;
@override final  String slug;
@override@JsonKey(fromJson: doubleFromJson) final  double price;
@override final  String type;
@override final  String city;
@override final  String? address;
@override final  String thumbnailUrl;
@override@JsonKey() final  String status;
@override@JsonKey(fromJson: doubleFromJson) final  double rating;
@override@JsonKey(fromJson: intFromJson) final  int reviewCount;
@override@JsonKey() final  bool isFavorited;
@override final  int? availableRoomsCount;
 final  List<FacilityModel> _facilities;
@override@JsonKey() List<FacilityModel> get facilities {
  if (_facilities is EqualUnmodifiableListView) return _facilities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_facilities);
}


/// Create a copy of KosSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KosSummaryModelCopyWith<_KosSummaryModel> get copyWith => __$KosSummaryModelCopyWithImpl<_KosSummaryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KosSummaryModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _KosSummaryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.price, price) || other.price == price)&&(identical(other.type, type) || other.type == type)&&(identical(other.city, city) || other.city == city)&&(identical(other.address, address) || other.address == address)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.isFavorited, isFavorited) || other.isFavorited == isFavorited)&&(identical(other.availableRoomsCount, availableRoomsCount) || other.availableRoomsCount == availableRoomsCount)&&const DeepCollectionEquality().equals(other.facilities, _facilities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,slug,price,type,city,address,thumbnailUrl,status,rating,reviewCount,isFavorited,availableRoomsCount,const DeepCollectionEquality().hash(_facilities));
}

@override
String toString() {
    return 'KosSummaryModel(id: $id, title: $title, slug: $slug, price: $price, type: $type, city: $city, address: $address, thumbnailUrl: $thumbnailUrl, status: $status, rating: $rating, reviewCount: $reviewCount, isFavorited: $isFavorited, availableRoomsCount: $availableRoomsCount, facilities: $facilities)';
}


}

/// @nodoc
abstract mixin class _$KosSummaryModelCopyWith<$Res> implements $KosSummaryModelCopyWith<$Res> {
  factory _$KosSummaryModelCopyWith(_KosSummaryModel value, $Res Function(_KosSummaryModel) _then) = __$KosSummaryModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String slug,@JsonKey(fromJson: doubleFromJson) double price, String type, String city, String? address, String thumbnailUrl, String status,@JsonKey(fromJson: doubleFromJson) double rating,@JsonKey(fromJson: intFromJson) int reviewCount, bool isFavorited, int? availableRoomsCount, List<FacilityModel> facilities
});




}
/// @nodoc
class __$KosSummaryModelCopyWithImpl<$Res>
    implements _$KosSummaryModelCopyWith<$Res> {
  __$KosSummaryModelCopyWithImpl(this._self, this._then);

  final _KosSummaryModel _self;
  final $Res Function(_KosSummaryModel) _then;

/// Create a copy of KosSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? slug = null,Object? price = null,Object? type = null,Object? city = null,Object? address = freezed,Object? thumbnailUrl = null,Object? status = null,Object? rating = null,Object? reviewCount = null,Object? isFavorited = null,Object? availableRoomsCount = freezed,Object? facilities = null,}) {
  return _then(_KosSummaryModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: null == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,isFavorited: null == isFavorited ? _self.isFavorited : isFavorited // ignore: cast_nullable_to_non_nullable
as bool,availableRoomsCount: freezed == availableRoomsCount ? _self.availableRoomsCount : availableRoomsCount // ignore: cast_nullable_to_non_nullable
as int?,facilities: null == facilities ? _self._facilities : facilities // ignore: cast_nullable_to_non_nullable
as List<FacilityModel>,
  ));
}


}


/// @nodoc
mixin _$KosDetailModel {

 int get id; String get title; String get slug; String? get description;@JsonKey(fromJson: doubleFromJson) double get price; String get type; String get city; String? get address; String get thumbnailUrl; String get status; String? get area; String? get roomsSummary; String? get bathrooms; String? get bedrooms; String? get garages;@JsonKey(fromJson: nullableDoubleFromJson) double? get latitude;@JsonKey(fromJson: nullableDoubleFromJson) double? get longitude;@JsonKey(fromJson: doubleFromJson) double get rating;@JsonKey(fromJson: intFromJson) int get reviewCount; bool get isFavorited; bool get canReview; OwnerSummaryModel? get owner; List<KosPhotoModel> get photos; List<FacilityModel> get facilities; List<RoomModel> get availableRooms; List<ReviewModel> get reviews; List<KosSummaryModel> get similarKos;
/// Create a copy of KosDetailModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KosDetailModelCopyWith<KosDetailModel> get copyWith => _$KosDetailModelCopyWithImpl<KosDetailModel>(this as KosDetailModel, _$identity);

  /// Serializes this KosDetailModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as KosDetailModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KosDetailModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.slug, _this.slug) || other.slug == _this.slug)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.price, _this.price) || other.price == _this.price)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.city, _this.city) || other.city == _this.city)&&(identical(other.address, _this.address) || other.address == _this.address)&&(identical(other.thumbnailUrl, _this.thumbnailUrl) || other.thumbnailUrl == _this.thumbnailUrl)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.area, _this.area) || other.area == _this.area)&&(identical(other.roomsSummary, _this.roomsSummary) || other.roomsSummary == _this.roomsSummary)&&(identical(other.bathrooms, _this.bathrooms) || other.bathrooms == _this.bathrooms)&&(identical(other.bedrooms, _this.bedrooms) || other.bedrooms == _this.bedrooms)&&(identical(other.garages, _this.garages) || other.garages == _this.garages)&&(identical(other.latitude, _this.latitude) || other.latitude == _this.latitude)&&(identical(other.longitude, _this.longitude) || other.longitude == _this.longitude)&&(identical(other.rating, _this.rating) || other.rating == _this.rating)&&(identical(other.reviewCount, _this.reviewCount) || other.reviewCount == _this.reviewCount)&&(identical(other.isFavorited, _this.isFavorited) || other.isFavorited == _this.isFavorited)&&(identical(other.canReview, _this.canReview) || other.canReview == _this.canReview)&&(identical(other.owner, _this.owner) || other.owner == _this.owner)&&const DeepCollectionEquality().equals(other.photos, _this.photos)&&const DeepCollectionEquality().equals(other.facilities, _this.facilities)&&const DeepCollectionEquality().equals(other.availableRooms, _this.availableRooms)&&const DeepCollectionEquality().equals(other.reviews, _this.reviews)&&const DeepCollectionEquality().equals(other.similarKos, _this.similarKos));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as KosDetailModel;
  return Object.hashAll([runtimeType,_this.id,_this.title,_this.slug,_this.description,_this.price,_this.type,_this.city,_this.address,_this.thumbnailUrl,_this.status,_this.area,_this.roomsSummary,_this.bathrooms,_this.bedrooms,_this.garages,_this.latitude,_this.longitude,_this.rating,_this.reviewCount,_this.isFavorited,_this.canReview,_this.owner,const DeepCollectionEquality().hash(_this.photos),const DeepCollectionEquality().hash(_this.facilities),const DeepCollectionEquality().hash(_this.availableRooms),const DeepCollectionEquality().hash(_this.reviews),const DeepCollectionEquality().hash(_this.similarKos)]);
}

@override
String toString() {
  final _this = this as KosDetailModel;
  return 'KosDetailModel(id: ${_this.id}, title: ${_this.title}, slug: ${_this.slug}, description: ${_this.description}, price: ${_this.price}, type: ${_this.type}, city: ${_this.city}, address: ${_this.address}, thumbnailUrl: ${_this.thumbnailUrl}, status: ${_this.status}, area: ${_this.area}, roomsSummary: ${_this.roomsSummary}, bathrooms: ${_this.bathrooms}, bedrooms: ${_this.bedrooms}, garages: ${_this.garages}, latitude: ${_this.latitude}, longitude: ${_this.longitude}, rating: ${_this.rating}, reviewCount: ${_this.reviewCount}, isFavorited: ${_this.isFavorited}, canReview: ${_this.canReview}, owner: ${_this.owner}, photos: ${_this.photos}, facilities: ${_this.facilities}, availableRooms: ${_this.availableRooms}, reviews: ${_this.reviews}, similarKos: ${_this.similarKos})';
}


}

/// @nodoc
abstract mixin class $KosDetailModelCopyWith<$Res>  {
  factory $KosDetailModelCopyWith(KosDetailModel value, $Res Function(KosDetailModel) _then) = _$KosDetailModelCopyWithImpl;
@useResult
$Res call({
 int id, String title, String slug, String? description,@JsonKey(fromJson: doubleFromJson) double price, String type, String city, String? address, String thumbnailUrl, String status, String? area, String? roomsSummary, String? bathrooms, String? bedrooms, String? garages,@JsonKey(fromJson: nullableDoubleFromJson) double? latitude,@JsonKey(fromJson: nullableDoubleFromJson) double? longitude,@JsonKey(fromJson: doubleFromJson) double rating,@JsonKey(fromJson: intFromJson) int reviewCount, bool isFavorited, bool canReview, OwnerSummaryModel? owner, List<KosPhotoModel> photos, List<FacilityModel> facilities, List<RoomModel> availableRooms, List<ReviewModel> reviews, List<KosSummaryModel> similarKos
});


$OwnerSummaryModelCopyWith<$Res>? get owner;

}
/// @nodoc
class _$KosDetailModelCopyWithImpl<$Res>
    implements $KosDetailModelCopyWith<$Res> {
  _$KosDetailModelCopyWithImpl(this._self, this._then);

  final KosDetailModel _self;
  final $Res Function(KosDetailModel) _then;

/// Create a copy of KosDetailModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? slug = null,Object? description = freezed,Object? price = null,Object? type = null,Object? city = null,Object? address = freezed,Object? thumbnailUrl = null,Object? status = null,Object? area = freezed,Object? roomsSummary = freezed,Object? bathrooms = freezed,Object? bedrooms = freezed,Object? garages = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? rating = null,Object? reviewCount = null,Object? isFavorited = null,Object? canReview = null,Object? owner = freezed,Object? photos = null,Object? facilities = null,Object? availableRooms = null,Object? reviews = null,Object? similarKos = null,}) {
  return _then(KosDetailModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: null == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,area: freezed == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String?,roomsSummary: freezed == roomsSummary ? _self.roomsSummary : roomsSummary // ignore: cast_nullable_to_non_nullable
as String?,bathrooms: freezed == bathrooms ? _self.bathrooms : bathrooms // ignore: cast_nullable_to_non_nullable
as String?,bedrooms: freezed == bedrooms ? _self.bedrooms : bedrooms // ignore: cast_nullable_to_non_nullable
as String?,garages: freezed == garages ? _self.garages : garages // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,isFavorited: null == isFavorited ? _self.isFavorited : isFavorited // ignore: cast_nullable_to_non_nullable
as bool,canReview: null == canReview ? _self.canReview : canReview // ignore: cast_nullable_to_non_nullable
as bool,owner: freezed == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as OwnerSummaryModel?,photos: null == photos ? _self.photos : photos // ignore: cast_nullable_to_non_nullable
as List<KosPhotoModel>,facilities: null == facilities ? _self.facilities : facilities // ignore: cast_nullable_to_non_nullable
as List<FacilityModel>,availableRooms: null == availableRooms ? _self.availableRooms : availableRooms // ignore: cast_nullable_to_non_nullable
as List<RoomModel>,reviews: null == reviews ? _self.reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<ReviewModel>,similarKos: null == similarKos ? _self.similarKos : similarKos // ignore: cast_nullable_to_non_nullable
as List<KosSummaryModel>,
  ));
}
/// Create a copy of KosDetailModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OwnerSummaryModelCopyWith<$Res>? get owner {
    if (_self.owner == null) {
    return null;
  }

  return $OwnerSummaryModelCopyWith<$Res>(_self.owner!, (value) {
    return _then(_self.copyWith(owner: value));
  });
}
}


/// Adds pattern-matching-related methods to [KosDetailModel].
extension KosDetailModelPatterns on KosDetailModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KosDetailModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KosDetailModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KosDetailModel value)  $default,){
final _that = this;
switch (_that) {
case _KosDetailModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KosDetailModel value)?  $default,){
final _that = this;
switch (_that) {
case _KosDetailModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String slug,  String? description, @JsonKey(fromJson: doubleFromJson)  double price,  String type,  String city,  String? address,  String thumbnailUrl,  String status,  String? area,  String? roomsSummary,  String? bathrooms,  String? bedrooms,  String? garages, @JsonKey(fromJson: nullableDoubleFromJson)  double? latitude, @JsonKey(fromJson: nullableDoubleFromJson)  double? longitude, @JsonKey(fromJson: doubleFromJson)  double rating, @JsonKey(fromJson: intFromJson)  int reviewCount,  bool isFavorited,  bool canReview,  OwnerSummaryModel? owner,  List<KosPhotoModel> photos,  List<FacilityModel> facilities,  List<RoomModel> availableRooms,  List<ReviewModel> reviews,  List<KosSummaryModel> similarKos)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KosDetailModel() when $default != null:
return $default(_that.id,_that.title,_that.slug,_that.description,_that.price,_that.type,_that.city,_that.address,_that.thumbnailUrl,_that.status,_that.area,_that.roomsSummary,_that.bathrooms,_that.bedrooms,_that.garages,_that.latitude,_that.longitude,_that.rating,_that.reviewCount,_that.isFavorited,_that.canReview,_that.owner,_that.photos,_that.facilities,_that.availableRooms,_that.reviews,_that.similarKos);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String slug,  String? description, @JsonKey(fromJson: doubleFromJson)  double price,  String type,  String city,  String? address,  String thumbnailUrl,  String status,  String? area,  String? roomsSummary,  String? bathrooms,  String? bedrooms,  String? garages, @JsonKey(fromJson: nullableDoubleFromJson)  double? latitude, @JsonKey(fromJson: nullableDoubleFromJson)  double? longitude, @JsonKey(fromJson: doubleFromJson)  double rating, @JsonKey(fromJson: intFromJson)  int reviewCount,  bool isFavorited,  bool canReview,  OwnerSummaryModel? owner,  List<KosPhotoModel> photos,  List<FacilityModel> facilities,  List<RoomModel> availableRooms,  List<ReviewModel> reviews,  List<KosSummaryModel> similarKos)  $default,) {final _that = this;
switch (_that) {
case _KosDetailModel():
return $default(_that.id,_that.title,_that.slug,_that.description,_that.price,_that.type,_that.city,_that.address,_that.thumbnailUrl,_that.status,_that.area,_that.roomsSummary,_that.bathrooms,_that.bedrooms,_that.garages,_that.latitude,_that.longitude,_that.rating,_that.reviewCount,_that.isFavorited,_that.canReview,_that.owner,_that.photos,_that.facilities,_that.availableRooms,_that.reviews,_that.similarKos);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String slug,  String? description, @JsonKey(fromJson: doubleFromJson)  double price,  String type,  String city,  String? address,  String thumbnailUrl,  String status,  String? area,  String? roomsSummary,  String? bathrooms,  String? bedrooms,  String? garages, @JsonKey(fromJson: nullableDoubleFromJson)  double? latitude, @JsonKey(fromJson: nullableDoubleFromJson)  double? longitude, @JsonKey(fromJson: doubleFromJson)  double rating, @JsonKey(fromJson: intFromJson)  int reviewCount,  bool isFavorited,  bool canReview,  OwnerSummaryModel? owner,  List<KosPhotoModel> photos,  List<FacilityModel> facilities,  List<RoomModel> availableRooms,  List<ReviewModel> reviews,  List<KosSummaryModel> similarKos)?  $default,) {final _that = this;
switch (_that) {
case _KosDetailModel() when $default != null:
return $default(_that.id,_that.title,_that.slug,_that.description,_that.price,_that.type,_that.city,_that.address,_that.thumbnailUrl,_that.status,_that.area,_that.roomsSummary,_that.bathrooms,_that.bedrooms,_that.garages,_that.latitude,_that.longitude,_that.rating,_that.reviewCount,_that.isFavorited,_that.canReview,_that.owner,_that.photos,_that.facilities,_that.availableRooms,_that.reviews,_that.similarKos);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KosDetailModel implements KosDetailModel {
  const _KosDetailModel({required this.id, required this.title, required this.slug, this.description, @JsonKey(fromJson: doubleFromJson) required this.price, required this.type, required this.city, this.address, required this.thumbnailUrl, this.status = 'active', this.area, this.roomsSummary, this.bathrooms, this.bedrooms, this.garages, @JsonKey(fromJson: nullableDoubleFromJson) this.latitude, @JsonKey(fromJson: nullableDoubleFromJson) this.longitude, @JsonKey(fromJson: doubleFromJson) this.rating = 0.0, @JsonKey(fromJson: intFromJson) this.reviewCount = 0, this.isFavorited = false, this.canReview = false, this.owner,  List<KosPhotoModel> photos = const [],  List<FacilityModel> facilities = const [],  List<RoomModel> availableRooms = const [],  List<ReviewModel> reviews = const [],  List<KosSummaryModel> similarKos = const []}): _photos = photos,_facilities = facilities,_availableRooms = availableRooms,_reviews = reviews,_similarKos = similarKos;
  factory _KosDetailModel.fromJson(Map<String, dynamic> json) => _$KosDetailModelFromJson(json);

@override final  int id;
@override final  String title;
@override final  String slug;
@override final  String? description;
@override@JsonKey(fromJson: doubleFromJson) final  double price;
@override final  String type;
@override final  String city;
@override final  String? address;
@override final  String thumbnailUrl;
@override@JsonKey() final  String status;
@override final  String? area;
@override final  String? roomsSummary;
@override final  String? bathrooms;
@override final  String? bedrooms;
@override final  String? garages;
@override@JsonKey(fromJson: nullableDoubleFromJson) final  double? latitude;
@override@JsonKey(fromJson: nullableDoubleFromJson) final  double? longitude;
@override@JsonKey(fromJson: doubleFromJson) final  double rating;
@override@JsonKey(fromJson: intFromJson) final  int reviewCount;
@override@JsonKey() final  bool isFavorited;
@override@JsonKey() final  bool canReview;
@override final  OwnerSummaryModel? owner;
 final  List<KosPhotoModel> _photos;
@override@JsonKey() List<KosPhotoModel> get photos {
  if (_photos is EqualUnmodifiableListView) return _photos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photos);
}

 final  List<FacilityModel> _facilities;
@override@JsonKey() List<FacilityModel> get facilities {
  if (_facilities is EqualUnmodifiableListView) return _facilities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_facilities);
}

 final  List<RoomModel> _availableRooms;
@override@JsonKey() List<RoomModel> get availableRooms {
  if (_availableRooms is EqualUnmodifiableListView) return _availableRooms;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availableRooms);
}

 final  List<ReviewModel> _reviews;
@override@JsonKey() List<ReviewModel> get reviews {
  if (_reviews is EqualUnmodifiableListView) return _reviews;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reviews);
}

 final  List<KosSummaryModel> _similarKos;
@override@JsonKey() List<KosSummaryModel> get similarKos {
  if (_similarKos is EqualUnmodifiableListView) return _similarKos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_similarKos);
}


/// Create a copy of KosDetailModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KosDetailModelCopyWith<_KosDetailModel> get copyWith => __$KosDetailModelCopyWithImpl<_KosDetailModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KosDetailModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _KosDetailModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.type, type) || other.type == type)&&(identical(other.city, city) || other.city == city)&&(identical(other.address, address) || other.address == address)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.area, area) || other.area == area)&&(identical(other.roomsSummary, roomsSummary) || other.roomsSummary == roomsSummary)&&(identical(other.bathrooms, bathrooms) || other.bathrooms == bathrooms)&&(identical(other.bedrooms, bedrooms) || other.bedrooms == bedrooms)&&(identical(other.garages, garages) || other.garages == garages)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.isFavorited, isFavorited) || other.isFavorited == isFavorited)&&(identical(other.canReview, canReview) || other.canReview == canReview)&&(identical(other.owner, owner) || other.owner == owner)&&const DeepCollectionEquality().equals(other.photos, _photos)&&const DeepCollectionEquality().equals(other.facilities, _facilities)&&const DeepCollectionEquality().equals(other.availableRooms, _availableRooms)&&const DeepCollectionEquality().equals(other.reviews, _reviews)&&const DeepCollectionEquality().equals(other.similarKos, _similarKos));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,id,title,slug,description,price,type,city,address,thumbnailUrl,status,area,roomsSummary,bathrooms,bedrooms,garages,latitude,longitude,rating,reviewCount,isFavorited,canReview,owner,const DeepCollectionEquality().hash(_photos),const DeepCollectionEquality().hash(_facilities),const DeepCollectionEquality().hash(_availableRooms),const DeepCollectionEquality().hash(_reviews),const DeepCollectionEquality().hash(_similarKos)]);
}

@override
String toString() {
    return 'KosDetailModel(id: $id, title: $title, slug: $slug, description: $description, price: $price, type: $type, city: $city, address: $address, thumbnailUrl: $thumbnailUrl, status: $status, area: $area, roomsSummary: $roomsSummary, bathrooms: $bathrooms, bedrooms: $bedrooms, garages: $garages, latitude: $latitude, longitude: $longitude, rating: $rating, reviewCount: $reviewCount, isFavorited: $isFavorited, canReview: $canReview, owner: $owner, photos: $photos, facilities: $facilities, availableRooms: $availableRooms, reviews: $reviews, similarKos: $similarKos)';
}


}

/// @nodoc
abstract mixin class _$KosDetailModelCopyWith<$Res> implements $KosDetailModelCopyWith<$Res> {
  factory _$KosDetailModelCopyWith(_KosDetailModel value, $Res Function(_KosDetailModel) _then) = __$KosDetailModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String slug, String? description,@JsonKey(fromJson: doubleFromJson) double price, String type, String city, String? address, String thumbnailUrl, String status, String? area, String? roomsSummary, String? bathrooms, String? bedrooms, String? garages,@JsonKey(fromJson: nullableDoubleFromJson) double? latitude,@JsonKey(fromJson: nullableDoubleFromJson) double? longitude,@JsonKey(fromJson: doubleFromJson) double rating,@JsonKey(fromJson: intFromJson) int reviewCount, bool isFavorited, bool canReview, OwnerSummaryModel? owner, List<KosPhotoModel> photos, List<FacilityModel> facilities, List<RoomModel> availableRooms, List<ReviewModel> reviews, List<KosSummaryModel> similarKos
});


@override $OwnerSummaryModelCopyWith<$Res>? get owner;

}
/// @nodoc
class __$KosDetailModelCopyWithImpl<$Res>
    implements _$KosDetailModelCopyWith<$Res> {
  __$KosDetailModelCopyWithImpl(this._self, this._then);

  final _KosDetailModel _self;
  final $Res Function(_KosDetailModel) _then;

/// Create a copy of KosDetailModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? slug = null,Object? description = freezed,Object? price = null,Object? type = null,Object? city = null,Object? address = freezed,Object? thumbnailUrl = null,Object? status = null,Object? area = freezed,Object? roomsSummary = freezed,Object? bathrooms = freezed,Object? bedrooms = freezed,Object? garages = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? rating = null,Object? reviewCount = null,Object? isFavorited = null,Object? canReview = null,Object? owner = freezed,Object? photos = null,Object? facilities = null,Object? availableRooms = null,Object? reviews = null,Object? similarKos = null,}) {
  return _then(_KosDetailModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: null == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,area: freezed == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String?,roomsSummary: freezed == roomsSummary ? _self.roomsSummary : roomsSummary // ignore: cast_nullable_to_non_nullable
as String?,bathrooms: freezed == bathrooms ? _self.bathrooms : bathrooms // ignore: cast_nullable_to_non_nullable
as String?,bedrooms: freezed == bedrooms ? _self.bedrooms : bedrooms // ignore: cast_nullable_to_non_nullable
as String?,garages: freezed == garages ? _self.garages : garages // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,isFavorited: null == isFavorited ? _self.isFavorited : isFavorited // ignore: cast_nullable_to_non_nullable
as bool,canReview: null == canReview ? _self.canReview : canReview // ignore: cast_nullable_to_non_nullable
as bool,owner: freezed == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as OwnerSummaryModel?,photos: null == photos ? _self._photos : photos // ignore: cast_nullable_to_non_nullable
as List<KosPhotoModel>,facilities: null == facilities ? _self._facilities : facilities // ignore: cast_nullable_to_non_nullable
as List<FacilityModel>,availableRooms: null == availableRooms ? _self._availableRooms : availableRooms // ignore: cast_nullable_to_non_nullable
as List<RoomModel>,reviews: null == reviews ? _self._reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<ReviewModel>,similarKos: null == similarKos ? _self._similarKos : similarKos // ignore: cast_nullable_to_non_nullable
as List<KosSummaryModel>,
  ));
}

/// Create a copy of KosDetailModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OwnerSummaryModelCopyWith<$Res>? get owner {
    if (_self.owner == null) {
    return null;
  }

  return $OwnerSummaryModelCopyWith<$Res>(_self.owner!, (value) {
    return _then(_self.copyWith(owner: value));
  });
}
}

// dart format on
