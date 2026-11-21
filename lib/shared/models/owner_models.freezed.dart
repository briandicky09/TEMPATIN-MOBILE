// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'owner_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OwnerDashboardModel {

@JsonKey(fromJson: intFromJson) int get totalKos;@JsonKey(fromJson: intFromJson) int get activeKos;@JsonKey(fromJson: intFromJson) int get inactiveKos;@JsonKey(fromJson: doubleFromJson) double get avgPrice;@JsonKey(fromJson: intFromJson) int get pendingBookingsCount;@JsonKey(fromJson: intFromJson) int get pendingSurveysCount;@JsonKey(fromJson: intFromJson) int get openMaintenanceCount; List<KosSummaryModel> get recentKos;
/// Create a copy of OwnerDashboardModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OwnerDashboardModelCopyWith<OwnerDashboardModel> get copyWith => _$OwnerDashboardModelCopyWithImpl<OwnerDashboardModel>(this as OwnerDashboardModel, _$identity);

  /// Serializes this OwnerDashboardModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as OwnerDashboardModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OwnerDashboardModel&&(identical(other.totalKos, _this.totalKos) || other.totalKos == _this.totalKos)&&(identical(other.activeKos, _this.activeKos) || other.activeKos == _this.activeKos)&&(identical(other.inactiveKos, _this.inactiveKos) || other.inactiveKos == _this.inactiveKos)&&(identical(other.avgPrice, _this.avgPrice) || other.avgPrice == _this.avgPrice)&&(identical(other.pendingBookingsCount, _this.pendingBookingsCount) || other.pendingBookingsCount == _this.pendingBookingsCount)&&(identical(other.pendingSurveysCount, _this.pendingSurveysCount) || other.pendingSurveysCount == _this.pendingSurveysCount)&&(identical(other.openMaintenanceCount, _this.openMaintenanceCount) || other.openMaintenanceCount == _this.openMaintenanceCount)&&const DeepCollectionEquality().equals(other.recentKos, _this.recentKos));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as OwnerDashboardModel;
  return Object.hash(runtimeType,_this.totalKos,_this.activeKos,_this.inactiveKos,_this.avgPrice,_this.pendingBookingsCount,_this.pendingSurveysCount,_this.openMaintenanceCount,const DeepCollectionEquality().hash(_this.recentKos));
}

@override
String toString() {
  final _this = this as OwnerDashboardModel;
  return 'OwnerDashboardModel(totalKos: ${_this.totalKos}, activeKos: ${_this.activeKos}, inactiveKos: ${_this.inactiveKos}, avgPrice: ${_this.avgPrice}, pendingBookingsCount: ${_this.pendingBookingsCount}, pendingSurveysCount: ${_this.pendingSurveysCount}, openMaintenanceCount: ${_this.openMaintenanceCount}, recentKos: ${_this.recentKos})';
}


}

/// @nodoc
abstract mixin class $OwnerDashboardModelCopyWith<$Res>  {
  factory $OwnerDashboardModelCopyWith(OwnerDashboardModel value, $Res Function(OwnerDashboardModel) _then) = _$OwnerDashboardModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: intFromJson) int totalKos,@JsonKey(fromJson: intFromJson) int activeKos,@JsonKey(fromJson: intFromJson) int inactiveKos,@JsonKey(fromJson: doubleFromJson) double avgPrice,@JsonKey(fromJson: intFromJson) int pendingBookingsCount,@JsonKey(fromJson: intFromJson) int pendingSurveysCount,@JsonKey(fromJson: intFromJson) int openMaintenanceCount, List<KosSummaryModel> recentKos
});




}
/// @nodoc
class _$OwnerDashboardModelCopyWithImpl<$Res>
    implements $OwnerDashboardModelCopyWith<$Res> {
  _$OwnerDashboardModelCopyWithImpl(this._self, this._then);

  final OwnerDashboardModel _self;
  final $Res Function(OwnerDashboardModel) _then;

/// Create a copy of OwnerDashboardModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalKos = null,Object? activeKos = null,Object? inactiveKos = null,Object? avgPrice = null,Object? pendingBookingsCount = null,Object? pendingSurveysCount = null,Object? openMaintenanceCount = null,Object? recentKos = null,}) {
  return _then(OwnerDashboardModel(
totalKos: null == totalKos ? _self.totalKos : totalKos // ignore: cast_nullable_to_non_nullable
as int,activeKos: null == activeKos ? _self.activeKos : activeKos // ignore: cast_nullable_to_non_nullable
as int,inactiveKos: null == inactiveKos ? _self.inactiveKos : inactiveKos // ignore: cast_nullable_to_non_nullable
as int,avgPrice: null == avgPrice ? _self.avgPrice : avgPrice // ignore: cast_nullable_to_non_nullable
as double,pendingBookingsCount: null == pendingBookingsCount ? _self.pendingBookingsCount : pendingBookingsCount // ignore: cast_nullable_to_non_nullable
as int,pendingSurveysCount: null == pendingSurveysCount ? _self.pendingSurveysCount : pendingSurveysCount // ignore: cast_nullable_to_non_nullable
as int,openMaintenanceCount: null == openMaintenanceCount ? _self.openMaintenanceCount : openMaintenanceCount // ignore: cast_nullable_to_non_nullable
as int,recentKos: null == recentKos ? _self.recentKos : recentKos // ignore: cast_nullable_to_non_nullable
as List<KosSummaryModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [OwnerDashboardModel].
extension OwnerDashboardModelPatterns on OwnerDashboardModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OwnerDashboardModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OwnerDashboardModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OwnerDashboardModel value)  $default,){
final _that = this;
switch (_that) {
case _OwnerDashboardModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OwnerDashboardModel value)?  $default,){
final _that = this;
switch (_that) {
case _OwnerDashboardModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: intFromJson)  int totalKos, @JsonKey(fromJson: intFromJson)  int activeKos, @JsonKey(fromJson: intFromJson)  int inactiveKos, @JsonKey(fromJson: doubleFromJson)  double avgPrice, @JsonKey(fromJson: intFromJson)  int pendingBookingsCount, @JsonKey(fromJson: intFromJson)  int pendingSurveysCount, @JsonKey(fromJson: intFromJson)  int openMaintenanceCount,  List<KosSummaryModel> recentKos)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OwnerDashboardModel() when $default != null:
return $default(_that.totalKos,_that.activeKos,_that.inactiveKos,_that.avgPrice,_that.pendingBookingsCount,_that.pendingSurveysCount,_that.openMaintenanceCount,_that.recentKos);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: intFromJson)  int totalKos, @JsonKey(fromJson: intFromJson)  int activeKos, @JsonKey(fromJson: intFromJson)  int inactiveKos, @JsonKey(fromJson: doubleFromJson)  double avgPrice, @JsonKey(fromJson: intFromJson)  int pendingBookingsCount, @JsonKey(fromJson: intFromJson)  int pendingSurveysCount, @JsonKey(fromJson: intFromJson)  int openMaintenanceCount,  List<KosSummaryModel> recentKos)  $default,) {final _that = this;
switch (_that) {
case _OwnerDashboardModel():
return $default(_that.totalKos,_that.activeKos,_that.inactiveKos,_that.avgPrice,_that.pendingBookingsCount,_that.pendingSurveysCount,_that.openMaintenanceCount,_that.recentKos);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: intFromJson)  int totalKos, @JsonKey(fromJson: intFromJson)  int activeKos, @JsonKey(fromJson: intFromJson)  int inactiveKos, @JsonKey(fromJson: doubleFromJson)  double avgPrice, @JsonKey(fromJson: intFromJson)  int pendingBookingsCount, @JsonKey(fromJson: intFromJson)  int pendingSurveysCount, @JsonKey(fromJson: intFromJson)  int openMaintenanceCount,  List<KosSummaryModel> recentKos)?  $default,) {final _that = this;
switch (_that) {
case _OwnerDashboardModel() when $default != null:
return $default(_that.totalKos,_that.activeKos,_that.inactiveKos,_that.avgPrice,_that.pendingBookingsCount,_that.pendingSurveysCount,_that.openMaintenanceCount,_that.recentKos);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OwnerDashboardModel implements OwnerDashboardModel {
  const _OwnerDashboardModel({@JsonKey(fromJson: intFromJson) this.totalKos = 0, @JsonKey(fromJson: intFromJson) this.activeKos = 0, @JsonKey(fromJson: intFromJson) this.inactiveKos = 0, @JsonKey(fromJson: doubleFromJson) this.avgPrice = 0.0, @JsonKey(fromJson: intFromJson) this.pendingBookingsCount = 0, @JsonKey(fromJson: intFromJson) this.pendingSurveysCount = 0, @JsonKey(fromJson: intFromJson) this.openMaintenanceCount = 0,  List<KosSummaryModel> recentKos = const []}): _recentKos = recentKos;
  factory _OwnerDashboardModel.fromJson(Map<String, dynamic> json) => _$OwnerDashboardModelFromJson(json);

@override@JsonKey(fromJson: intFromJson) final  int totalKos;
@override@JsonKey(fromJson: intFromJson) final  int activeKos;
@override@JsonKey(fromJson: intFromJson) final  int inactiveKos;
@override@JsonKey(fromJson: doubleFromJson) final  double avgPrice;
@override@JsonKey(fromJson: intFromJson) final  int pendingBookingsCount;
@override@JsonKey(fromJson: intFromJson) final  int pendingSurveysCount;
@override@JsonKey(fromJson: intFromJson) final  int openMaintenanceCount;
 final  List<KosSummaryModel> _recentKos;
@override@JsonKey() List<KosSummaryModel> get recentKos {
  if (_recentKos is EqualUnmodifiableListView) return _recentKos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentKos);
}


/// Create a copy of OwnerDashboardModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OwnerDashboardModelCopyWith<_OwnerDashboardModel> get copyWith => __$OwnerDashboardModelCopyWithImpl<_OwnerDashboardModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OwnerDashboardModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OwnerDashboardModel&&(identical(other.totalKos, totalKos) || other.totalKos == totalKos)&&(identical(other.activeKos, activeKos) || other.activeKos == activeKos)&&(identical(other.inactiveKos, inactiveKos) || other.inactiveKos == inactiveKos)&&(identical(other.avgPrice, avgPrice) || other.avgPrice == avgPrice)&&(identical(other.pendingBookingsCount, pendingBookingsCount) || other.pendingBookingsCount == pendingBookingsCount)&&(identical(other.pendingSurveysCount, pendingSurveysCount) || other.pendingSurveysCount == pendingSurveysCount)&&(identical(other.openMaintenanceCount, openMaintenanceCount) || other.openMaintenanceCount == openMaintenanceCount)&&const DeepCollectionEquality().equals(other.recentKos, _recentKos));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,totalKos,activeKos,inactiveKos,avgPrice,pendingBookingsCount,pendingSurveysCount,openMaintenanceCount,const DeepCollectionEquality().hash(_recentKos));
}

@override
String toString() {
    return 'OwnerDashboardModel(totalKos: $totalKos, activeKos: $activeKos, inactiveKos: $inactiveKos, avgPrice: $avgPrice, pendingBookingsCount: $pendingBookingsCount, pendingSurveysCount: $pendingSurveysCount, openMaintenanceCount: $openMaintenanceCount, recentKos: $recentKos)';
}


}

/// @nodoc
abstract mixin class _$OwnerDashboardModelCopyWith<$Res> implements $OwnerDashboardModelCopyWith<$Res> {
  factory _$OwnerDashboardModelCopyWith(_OwnerDashboardModel value, $Res Function(_OwnerDashboardModel) _then) = __$OwnerDashboardModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: intFromJson) int totalKos,@JsonKey(fromJson: intFromJson) int activeKos,@JsonKey(fromJson: intFromJson) int inactiveKos,@JsonKey(fromJson: doubleFromJson) double avgPrice,@JsonKey(fromJson: intFromJson) int pendingBookingsCount,@JsonKey(fromJson: intFromJson) int pendingSurveysCount,@JsonKey(fromJson: intFromJson) int openMaintenanceCount, List<KosSummaryModel> recentKos
});




}
/// @nodoc
class __$OwnerDashboardModelCopyWithImpl<$Res>
    implements _$OwnerDashboardModelCopyWith<$Res> {
  __$OwnerDashboardModelCopyWithImpl(this._self, this._then);

  final _OwnerDashboardModel _self;
  final $Res Function(_OwnerDashboardModel) _then;

/// Create a copy of OwnerDashboardModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalKos = null,Object? activeKos = null,Object? inactiveKos = null,Object? avgPrice = null,Object? pendingBookingsCount = null,Object? pendingSurveysCount = null,Object? openMaintenanceCount = null,Object? recentKos = null,}) {
  return _then(_OwnerDashboardModel(
totalKos: null == totalKos ? _self.totalKos : totalKos // ignore: cast_nullable_to_non_nullable
as int,activeKos: null == activeKos ? _self.activeKos : activeKos // ignore: cast_nullable_to_non_nullable
as int,inactiveKos: null == inactiveKos ? _self.inactiveKos : inactiveKos // ignore: cast_nullable_to_non_nullable
as int,avgPrice: null == avgPrice ? _self.avgPrice : avgPrice // ignore: cast_nullable_to_non_nullable
as double,pendingBookingsCount: null == pendingBookingsCount ? _self.pendingBookingsCount : pendingBookingsCount // ignore: cast_nullable_to_non_nullable
as int,pendingSurveysCount: null == pendingSurveysCount ? _self.pendingSurveysCount : pendingSurveysCount // ignore: cast_nullable_to_non_nullable
as int,openMaintenanceCount: null == openMaintenanceCount ? _self.openMaintenanceCount : openMaintenanceCount // ignore: cast_nullable_to_non_nullable
as int,recentKos: null == recentKos ? _self._recentKos : recentKos // ignore: cast_nullable_to_non_nullable
as List<KosSummaryModel>,
  ));
}


}


/// @nodoc
mixin _$OwnerBookingCountsModel {

@JsonKey(fromJson: intFromJson) int get all;@JsonKey(fromJson: intFromJson) int get pending;@JsonKey(fromJson: intFromJson) int get approved;@JsonKey(fromJson: intFromJson) int get confirmed;@JsonKey(fromJson: intFromJson) int get active;@JsonKey(fromJson: intFromJson) int get rejected;
/// Create a copy of OwnerBookingCountsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OwnerBookingCountsModelCopyWith<OwnerBookingCountsModel> get copyWith => _$OwnerBookingCountsModelCopyWithImpl<OwnerBookingCountsModel>(this as OwnerBookingCountsModel, _$identity);

  /// Serializes this OwnerBookingCountsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as OwnerBookingCountsModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OwnerBookingCountsModel&&(identical(other.all, _this.all) || other.all == _this.all)&&(identical(other.pending, _this.pending) || other.pending == _this.pending)&&(identical(other.approved, _this.approved) || other.approved == _this.approved)&&(identical(other.confirmed, _this.confirmed) || other.confirmed == _this.confirmed)&&(identical(other.active, _this.active) || other.active == _this.active)&&(identical(other.rejected, _this.rejected) || other.rejected == _this.rejected));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as OwnerBookingCountsModel;
  return Object.hash(runtimeType,_this.all,_this.pending,_this.approved,_this.confirmed,_this.active,_this.rejected);
}

@override
String toString() {
  final _this = this as OwnerBookingCountsModel;
  return 'OwnerBookingCountsModel(all: ${_this.all}, pending: ${_this.pending}, approved: ${_this.approved}, confirmed: ${_this.confirmed}, active: ${_this.active}, rejected: ${_this.rejected})';
}


}

/// @nodoc
abstract mixin class $OwnerBookingCountsModelCopyWith<$Res>  {
  factory $OwnerBookingCountsModelCopyWith(OwnerBookingCountsModel value, $Res Function(OwnerBookingCountsModel) _then) = _$OwnerBookingCountsModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: intFromJson) int all,@JsonKey(fromJson: intFromJson) int pending,@JsonKey(fromJson: intFromJson) int approved,@JsonKey(fromJson: intFromJson) int confirmed,@JsonKey(fromJson: intFromJson) int active,@JsonKey(fromJson: intFromJson) int rejected
});




}
/// @nodoc
class _$OwnerBookingCountsModelCopyWithImpl<$Res>
    implements $OwnerBookingCountsModelCopyWith<$Res> {
  _$OwnerBookingCountsModelCopyWithImpl(this._self, this._then);

  final OwnerBookingCountsModel _self;
  final $Res Function(OwnerBookingCountsModel) _then;

/// Create a copy of OwnerBookingCountsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? all = null,Object? pending = null,Object? approved = null,Object? confirmed = null,Object? active = null,Object? rejected = null,}) {
  return _then(OwnerBookingCountsModel(
all: null == all ? _self.all : all // ignore: cast_nullable_to_non_nullable
as int,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as int,approved: null == approved ? _self.approved : approved // ignore: cast_nullable_to_non_nullable
as int,confirmed: null == confirmed ? _self.confirmed : confirmed // ignore: cast_nullable_to_non_nullable
as int,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as int,rejected: null == rejected ? _self.rejected : rejected // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [OwnerBookingCountsModel].
extension OwnerBookingCountsModelPatterns on OwnerBookingCountsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OwnerBookingCountsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OwnerBookingCountsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OwnerBookingCountsModel value)  $default,){
final _that = this;
switch (_that) {
case _OwnerBookingCountsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OwnerBookingCountsModel value)?  $default,){
final _that = this;
switch (_that) {
case _OwnerBookingCountsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: intFromJson)  int all, @JsonKey(fromJson: intFromJson)  int pending, @JsonKey(fromJson: intFromJson)  int approved, @JsonKey(fromJson: intFromJson)  int confirmed, @JsonKey(fromJson: intFromJson)  int active, @JsonKey(fromJson: intFromJson)  int rejected)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OwnerBookingCountsModel() when $default != null:
return $default(_that.all,_that.pending,_that.approved,_that.confirmed,_that.active,_that.rejected);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: intFromJson)  int all, @JsonKey(fromJson: intFromJson)  int pending, @JsonKey(fromJson: intFromJson)  int approved, @JsonKey(fromJson: intFromJson)  int confirmed, @JsonKey(fromJson: intFromJson)  int active, @JsonKey(fromJson: intFromJson)  int rejected)  $default,) {final _that = this;
switch (_that) {
case _OwnerBookingCountsModel():
return $default(_that.all,_that.pending,_that.approved,_that.confirmed,_that.active,_that.rejected);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: intFromJson)  int all, @JsonKey(fromJson: intFromJson)  int pending, @JsonKey(fromJson: intFromJson)  int approved, @JsonKey(fromJson: intFromJson)  int confirmed, @JsonKey(fromJson: intFromJson)  int active, @JsonKey(fromJson: intFromJson)  int rejected)?  $default,) {final _that = this;
switch (_that) {
case _OwnerBookingCountsModel() when $default != null:
return $default(_that.all,_that.pending,_that.approved,_that.confirmed,_that.active,_that.rejected);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OwnerBookingCountsModel implements OwnerBookingCountsModel {
  const _OwnerBookingCountsModel({@JsonKey(fromJson: intFromJson) this.all = 0, @JsonKey(fromJson: intFromJson) this.pending = 0, @JsonKey(fromJson: intFromJson) this.approved = 0, @JsonKey(fromJson: intFromJson) this.confirmed = 0, @JsonKey(fromJson: intFromJson) this.active = 0, @JsonKey(fromJson: intFromJson) this.rejected = 0});
  factory _OwnerBookingCountsModel.fromJson(Map<String, dynamic> json) => _$OwnerBookingCountsModelFromJson(json);

@override@JsonKey(fromJson: intFromJson) final  int all;
@override@JsonKey(fromJson: intFromJson) final  int pending;
@override@JsonKey(fromJson: intFromJson) final  int approved;
@override@JsonKey(fromJson: intFromJson) final  int confirmed;
@override@JsonKey(fromJson: intFromJson) final  int active;
@override@JsonKey(fromJson: intFromJson) final  int rejected;

/// Create a copy of OwnerBookingCountsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OwnerBookingCountsModelCopyWith<_OwnerBookingCountsModel> get copyWith => __$OwnerBookingCountsModelCopyWithImpl<_OwnerBookingCountsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OwnerBookingCountsModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OwnerBookingCountsModel&&(identical(other.all, all) || other.all == all)&&(identical(other.pending, pending) || other.pending == pending)&&(identical(other.approved, approved) || other.approved == approved)&&(identical(other.confirmed, confirmed) || other.confirmed == confirmed)&&(identical(other.active, active) || other.active == active)&&(identical(other.rejected, rejected) || other.rejected == rejected));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,all,pending,approved,confirmed,active,rejected);
}

@override
String toString() {
    return 'OwnerBookingCountsModel(all: $all, pending: $pending, approved: $approved, confirmed: $confirmed, active: $active, rejected: $rejected)';
}


}

/// @nodoc
abstract mixin class _$OwnerBookingCountsModelCopyWith<$Res> implements $OwnerBookingCountsModelCopyWith<$Res> {
  factory _$OwnerBookingCountsModelCopyWith(_OwnerBookingCountsModel value, $Res Function(_OwnerBookingCountsModel) _then) = __$OwnerBookingCountsModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: intFromJson) int all,@JsonKey(fromJson: intFromJson) int pending,@JsonKey(fromJson: intFromJson) int approved,@JsonKey(fromJson: intFromJson) int confirmed,@JsonKey(fromJson: intFromJson) int active,@JsonKey(fromJson: intFromJson) int rejected
});




}
/// @nodoc
class __$OwnerBookingCountsModelCopyWithImpl<$Res>
    implements _$OwnerBookingCountsModelCopyWith<$Res> {
  __$OwnerBookingCountsModelCopyWithImpl(this._self, this._then);

  final _OwnerBookingCountsModel _self;
  final $Res Function(_OwnerBookingCountsModel) _then;

/// Create a copy of OwnerBookingCountsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? all = null,Object? pending = null,Object? approved = null,Object? confirmed = null,Object? active = null,Object? rejected = null,}) {
  return _then(_OwnerBookingCountsModel(
all: null == all ? _self.all : all // ignore: cast_nullable_to_non_nullable
as int,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as int,approved: null == approved ? _self.approved : approved // ignore: cast_nullable_to_non_nullable
as int,confirmed: null == confirmed ? _self.confirmed : confirmed // ignore: cast_nullable_to_non_nullable
as int,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as int,rejected: null == rejected ? _self.rejected : rejected // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$OwnerBookingDetailData {

 BookingModel get booking; List<RoomModel> get availableRooms;
/// Create a copy of OwnerBookingDetailData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OwnerBookingDetailDataCopyWith<OwnerBookingDetailData> get copyWith => _$OwnerBookingDetailDataCopyWithImpl<OwnerBookingDetailData>(this as OwnerBookingDetailData, _$identity);

  /// Serializes this OwnerBookingDetailData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as OwnerBookingDetailData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OwnerBookingDetailData&&(identical(other.booking, _this.booking) || other.booking == _this.booking)&&const DeepCollectionEquality().equals(other.availableRooms, _this.availableRooms));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as OwnerBookingDetailData;
  return Object.hash(runtimeType,_this.booking,const DeepCollectionEquality().hash(_this.availableRooms));
}

@override
String toString() {
  final _this = this as OwnerBookingDetailData;
  return 'OwnerBookingDetailData(booking: ${_this.booking}, availableRooms: ${_this.availableRooms})';
}


}

/// @nodoc
abstract mixin class $OwnerBookingDetailDataCopyWith<$Res>  {
  factory $OwnerBookingDetailDataCopyWith(OwnerBookingDetailData value, $Res Function(OwnerBookingDetailData) _then) = _$OwnerBookingDetailDataCopyWithImpl;
@useResult
$Res call({
 BookingModel booking, List<RoomModel> availableRooms
});


$BookingModelCopyWith<$Res> get booking;

}
/// @nodoc
class _$OwnerBookingDetailDataCopyWithImpl<$Res>
    implements $OwnerBookingDetailDataCopyWith<$Res> {
  _$OwnerBookingDetailDataCopyWithImpl(this._self, this._then);

  final OwnerBookingDetailData _self;
  final $Res Function(OwnerBookingDetailData) _then;

/// Create a copy of OwnerBookingDetailData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? booking = null,Object? availableRooms = null,}) {
  return _then(OwnerBookingDetailData(
booking: null == booking ? _self.booking : booking // ignore: cast_nullable_to_non_nullable
as BookingModel,availableRooms: null == availableRooms ? _self.availableRooms : availableRooms // ignore: cast_nullable_to_non_nullable
as List<RoomModel>,
  ));
}
/// Create a copy of OwnerBookingDetailData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingModelCopyWith<$Res> get booking {
  
  return $BookingModelCopyWith<$Res>(_self.booking, (value) {
    return _then(_self.copyWith(booking: value));
  });
}
}


/// Adds pattern-matching-related methods to [OwnerBookingDetailData].
extension OwnerBookingDetailDataPatterns on OwnerBookingDetailData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OwnerBookingDetailData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OwnerBookingDetailData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OwnerBookingDetailData value)  $default,){
final _that = this;
switch (_that) {
case _OwnerBookingDetailData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OwnerBookingDetailData value)?  $default,){
final _that = this;
switch (_that) {
case _OwnerBookingDetailData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BookingModel booking,  List<RoomModel> availableRooms)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OwnerBookingDetailData() when $default != null:
return $default(_that.booking,_that.availableRooms);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BookingModel booking,  List<RoomModel> availableRooms)  $default,) {final _that = this;
switch (_that) {
case _OwnerBookingDetailData():
return $default(_that.booking,_that.availableRooms);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BookingModel booking,  List<RoomModel> availableRooms)?  $default,) {final _that = this;
switch (_that) {
case _OwnerBookingDetailData() when $default != null:
return $default(_that.booking,_that.availableRooms);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OwnerBookingDetailData implements OwnerBookingDetailData {
  const _OwnerBookingDetailData({required this.booking,  List<RoomModel> availableRooms = const []}): _availableRooms = availableRooms;
  factory _OwnerBookingDetailData.fromJson(Map<String, dynamic> json) => _$OwnerBookingDetailDataFromJson(json);

@override final  BookingModel booking;
 final  List<RoomModel> _availableRooms;
@override@JsonKey() List<RoomModel> get availableRooms {
  if (_availableRooms is EqualUnmodifiableListView) return _availableRooms;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availableRooms);
}


/// Create a copy of OwnerBookingDetailData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OwnerBookingDetailDataCopyWith<_OwnerBookingDetailData> get copyWith => __$OwnerBookingDetailDataCopyWithImpl<_OwnerBookingDetailData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OwnerBookingDetailDataToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OwnerBookingDetailData&&(identical(other.booking, booking) || other.booking == booking)&&const DeepCollectionEquality().equals(other.availableRooms, _availableRooms));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,booking,const DeepCollectionEquality().hash(_availableRooms));
}

@override
String toString() {
    return 'OwnerBookingDetailData(booking: $booking, availableRooms: $availableRooms)';
}


}

/// @nodoc
abstract mixin class _$OwnerBookingDetailDataCopyWith<$Res> implements $OwnerBookingDetailDataCopyWith<$Res> {
  factory _$OwnerBookingDetailDataCopyWith(_OwnerBookingDetailData value, $Res Function(_OwnerBookingDetailData) _then) = __$OwnerBookingDetailDataCopyWithImpl;
@override @useResult
$Res call({
 BookingModel booking, List<RoomModel> availableRooms
});


@override $BookingModelCopyWith<$Res> get booking;

}
/// @nodoc
class __$OwnerBookingDetailDataCopyWithImpl<$Res>
    implements _$OwnerBookingDetailDataCopyWith<$Res> {
  __$OwnerBookingDetailDataCopyWithImpl(this._self, this._then);

  final _OwnerBookingDetailData _self;
  final $Res Function(_OwnerBookingDetailData) _then;

/// Create a copy of OwnerBookingDetailData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? booking = null,Object? availableRooms = null,}) {
  return _then(_OwnerBookingDetailData(
booking: null == booking ? _self.booking : booking // ignore: cast_nullable_to_non_nullable
as BookingModel,availableRooms: null == availableRooms ? _self._availableRooms : availableRooms // ignore: cast_nullable_to_non_nullable
as List<RoomModel>,
  ));
}

/// Create a copy of OwnerBookingDetailData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingModelCopyWith<$Res> get booking {
  
  return $BookingModelCopyWith<$Res>(_self.booking, (value) {
    return _then(_self.copyWith(booking: value));
  });
}
}


/// @nodoc
mixin _$OwnerRatingSummaryModel {

@JsonKey(fromJson: intFromJson) int get totalReviews;@JsonKey(fromJson: doubleFromJson) double get averageRating;
/// Create a copy of OwnerRatingSummaryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OwnerRatingSummaryModelCopyWith<OwnerRatingSummaryModel> get copyWith => _$OwnerRatingSummaryModelCopyWithImpl<OwnerRatingSummaryModel>(this as OwnerRatingSummaryModel, _$identity);

  /// Serializes this OwnerRatingSummaryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as OwnerRatingSummaryModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OwnerRatingSummaryModel&&(identical(other.totalReviews, _this.totalReviews) || other.totalReviews == _this.totalReviews)&&(identical(other.averageRating, _this.averageRating) || other.averageRating == _this.averageRating));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as OwnerRatingSummaryModel;
  return Object.hash(runtimeType,_this.totalReviews,_this.averageRating);
}

@override
String toString() {
  final _this = this as OwnerRatingSummaryModel;
  return 'OwnerRatingSummaryModel(totalReviews: ${_this.totalReviews}, averageRating: ${_this.averageRating})';
}


}

/// @nodoc
abstract mixin class $OwnerRatingSummaryModelCopyWith<$Res>  {
  factory $OwnerRatingSummaryModelCopyWith(OwnerRatingSummaryModel value, $Res Function(OwnerRatingSummaryModel) _then) = _$OwnerRatingSummaryModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: intFromJson) int totalReviews,@JsonKey(fromJson: doubleFromJson) double averageRating
});




}
/// @nodoc
class _$OwnerRatingSummaryModelCopyWithImpl<$Res>
    implements $OwnerRatingSummaryModelCopyWith<$Res> {
  _$OwnerRatingSummaryModelCopyWithImpl(this._self, this._then);

  final OwnerRatingSummaryModel _self;
  final $Res Function(OwnerRatingSummaryModel) _then;

/// Create a copy of OwnerRatingSummaryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalReviews = null,Object? averageRating = null,}) {
  return _then(OwnerRatingSummaryModel(
totalReviews: null == totalReviews ? _self.totalReviews : totalReviews // ignore: cast_nullable_to_non_nullable
as int,averageRating: null == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [OwnerRatingSummaryModel].
extension OwnerRatingSummaryModelPatterns on OwnerRatingSummaryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OwnerRatingSummaryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OwnerRatingSummaryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OwnerRatingSummaryModel value)  $default,){
final _that = this;
switch (_that) {
case _OwnerRatingSummaryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OwnerRatingSummaryModel value)?  $default,){
final _that = this;
switch (_that) {
case _OwnerRatingSummaryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: intFromJson)  int totalReviews, @JsonKey(fromJson: doubleFromJson)  double averageRating)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OwnerRatingSummaryModel() when $default != null:
return $default(_that.totalReviews,_that.averageRating);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: intFromJson)  int totalReviews, @JsonKey(fromJson: doubleFromJson)  double averageRating)  $default,) {final _that = this;
switch (_that) {
case _OwnerRatingSummaryModel():
return $default(_that.totalReviews,_that.averageRating);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: intFromJson)  int totalReviews, @JsonKey(fromJson: doubleFromJson)  double averageRating)?  $default,) {final _that = this;
switch (_that) {
case _OwnerRatingSummaryModel() when $default != null:
return $default(_that.totalReviews,_that.averageRating);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OwnerRatingSummaryModel implements OwnerRatingSummaryModel {
  const _OwnerRatingSummaryModel({@JsonKey(fromJson: intFromJson) this.totalReviews = 0, @JsonKey(fromJson: doubleFromJson) this.averageRating = 0.0});
  factory _OwnerRatingSummaryModel.fromJson(Map<String, dynamic> json) => _$OwnerRatingSummaryModelFromJson(json);

@override@JsonKey(fromJson: intFromJson) final  int totalReviews;
@override@JsonKey(fromJson: doubleFromJson) final  double averageRating;

/// Create a copy of OwnerRatingSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OwnerRatingSummaryModelCopyWith<_OwnerRatingSummaryModel> get copyWith => __$OwnerRatingSummaryModelCopyWithImpl<_OwnerRatingSummaryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OwnerRatingSummaryModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OwnerRatingSummaryModel&&(identical(other.totalReviews, totalReviews) || other.totalReviews == totalReviews)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,totalReviews,averageRating);
}

@override
String toString() {
    return 'OwnerRatingSummaryModel(totalReviews: $totalReviews, averageRating: $averageRating)';
}


}

/// @nodoc
abstract mixin class _$OwnerRatingSummaryModelCopyWith<$Res> implements $OwnerRatingSummaryModelCopyWith<$Res> {
  factory _$OwnerRatingSummaryModelCopyWith(_OwnerRatingSummaryModel value, $Res Function(_OwnerRatingSummaryModel) _then) = __$OwnerRatingSummaryModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: intFromJson) int totalReviews,@JsonKey(fromJson: doubleFromJson) double averageRating
});




}
/// @nodoc
class __$OwnerRatingSummaryModelCopyWithImpl<$Res>
    implements _$OwnerRatingSummaryModelCopyWith<$Res> {
  __$OwnerRatingSummaryModelCopyWithImpl(this._self, this._then);

  final _OwnerRatingSummaryModel _self;
  final $Res Function(_OwnerRatingSummaryModel) _then;

/// Create a copy of OwnerRatingSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalReviews = null,Object? averageRating = null,}) {
  return _then(_OwnerRatingSummaryModel(
totalReviews: null == totalReviews ? _self.totalReviews : totalReviews // ignore: cast_nullable_to_non_nullable
as int,averageRating: null == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$MonthlyRevenuePoint {

 String get month;@JsonKey(fromJson: doubleFromJson) double get value;
/// Create a copy of MonthlyRevenuePoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MonthlyRevenuePointCopyWith<MonthlyRevenuePoint> get copyWith => _$MonthlyRevenuePointCopyWithImpl<MonthlyRevenuePoint>(this as MonthlyRevenuePoint, _$identity);

  /// Serializes this MonthlyRevenuePoint to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MonthlyRevenuePoint;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MonthlyRevenuePoint&&(identical(other.month, _this.month) || other.month == _this.month)&&(identical(other.value, _this.value) || other.value == _this.value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MonthlyRevenuePoint;
  return Object.hash(runtimeType,_this.month,_this.value);
}

@override
String toString() {
  final _this = this as MonthlyRevenuePoint;
  return 'MonthlyRevenuePoint(month: ${_this.month}, value: ${_this.value})';
}


}

/// @nodoc
abstract mixin class $MonthlyRevenuePointCopyWith<$Res>  {
  factory $MonthlyRevenuePointCopyWith(MonthlyRevenuePoint value, $Res Function(MonthlyRevenuePoint) _then) = _$MonthlyRevenuePointCopyWithImpl;
@useResult
$Res call({
 String month,@JsonKey(fromJson: doubleFromJson) double value
});




}
/// @nodoc
class _$MonthlyRevenuePointCopyWithImpl<$Res>
    implements $MonthlyRevenuePointCopyWith<$Res> {
  _$MonthlyRevenuePointCopyWithImpl(this._self, this._then);

  final MonthlyRevenuePoint _self;
  final $Res Function(MonthlyRevenuePoint) _then;

/// Create a copy of MonthlyRevenuePoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? month = null,Object? value = null,}) {
  return _then(MonthlyRevenuePoint(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [MonthlyRevenuePoint].
extension MonthlyRevenuePointPatterns on MonthlyRevenuePoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MonthlyRevenuePoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MonthlyRevenuePoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MonthlyRevenuePoint value)  $default,){
final _that = this;
switch (_that) {
case _MonthlyRevenuePoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MonthlyRevenuePoint value)?  $default,){
final _that = this;
switch (_that) {
case _MonthlyRevenuePoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String month, @JsonKey(fromJson: doubleFromJson)  double value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MonthlyRevenuePoint() when $default != null:
return $default(_that.month,_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String month, @JsonKey(fromJson: doubleFromJson)  double value)  $default,) {final _that = this;
switch (_that) {
case _MonthlyRevenuePoint():
return $default(_that.month,_that.value);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String month, @JsonKey(fromJson: doubleFromJson)  double value)?  $default,) {final _that = this;
switch (_that) {
case _MonthlyRevenuePoint() when $default != null:
return $default(_that.month,_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MonthlyRevenuePoint implements MonthlyRevenuePoint {
  const _MonthlyRevenuePoint({required this.month, @JsonKey(fromJson: doubleFromJson) this.value = 0.0});
  factory _MonthlyRevenuePoint.fromJson(Map<String, dynamic> json) => _$MonthlyRevenuePointFromJson(json);

@override final  String month;
@override@JsonKey(fromJson: doubleFromJson) final  double value;

/// Create a copy of MonthlyRevenuePoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MonthlyRevenuePointCopyWith<_MonthlyRevenuePoint> get copyWith => __$MonthlyRevenuePointCopyWithImpl<_MonthlyRevenuePoint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MonthlyRevenuePointToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MonthlyRevenuePoint&&(identical(other.month, month) || other.month == month)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,month,value);
}

@override
String toString() {
    return 'MonthlyRevenuePoint(month: $month, value: $value)';
}


}

/// @nodoc
abstract mixin class _$MonthlyRevenuePointCopyWith<$Res> implements $MonthlyRevenuePointCopyWith<$Res> {
  factory _$MonthlyRevenuePointCopyWith(_MonthlyRevenuePoint value, $Res Function(_MonthlyRevenuePoint) _then) = __$MonthlyRevenuePointCopyWithImpl;
@override @useResult
$Res call({
 String month,@JsonKey(fromJson: doubleFromJson) double value
});




}
/// @nodoc
class __$MonthlyRevenuePointCopyWithImpl<$Res>
    implements _$MonthlyRevenuePointCopyWith<$Res> {
  __$MonthlyRevenuePointCopyWithImpl(this._self, this._then);

  final _MonthlyRevenuePoint _self;
  final $Res Function(_MonthlyRevenuePoint) _then;

/// Create a copy of MonthlyRevenuePoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? month = null,Object? value = null,}) {
  return _then(_MonthlyRevenuePoint(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$KosPerformanceModel {

 String get title;@JsonKey(fromJson: intFromJson) int get occupancy;@JsonKey(fromJson: intFromJson) int get booking;@JsonKey(fromJson: doubleFromJson) double get revenue;
/// Create a copy of KosPerformanceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KosPerformanceModelCopyWith<KosPerformanceModel> get copyWith => _$KosPerformanceModelCopyWithImpl<KosPerformanceModel>(this as KosPerformanceModel, _$identity);

  /// Serializes this KosPerformanceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as KosPerformanceModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KosPerformanceModel&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.occupancy, _this.occupancy) || other.occupancy == _this.occupancy)&&(identical(other.booking, _this.booking) || other.booking == _this.booking)&&(identical(other.revenue, _this.revenue) || other.revenue == _this.revenue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as KosPerformanceModel;
  return Object.hash(runtimeType,_this.title,_this.occupancy,_this.booking,_this.revenue);
}

@override
String toString() {
  final _this = this as KosPerformanceModel;
  return 'KosPerformanceModel(title: ${_this.title}, occupancy: ${_this.occupancy}, booking: ${_this.booking}, revenue: ${_this.revenue})';
}


}

/// @nodoc
abstract mixin class $KosPerformanceModelCopyWith<$Res>  {
  factory $KosPerformanceModelCopyWith(KosPerformanceModel value, $Res Function(KosPerformanceModel) _then) = _$KosPerformanceModelCopyWithImpl;
@useResult
$Res call({
 String title,@JsonKey(fromJson: intFromJson) int occupancy,@JsonKey(fromJson: intFromJson) int booking,@JsonKey(fromJson: doubleFromJson) double revenue
});




}
/// @nodoc
class _$KosPerformanceModelCopyWithImpl<$Res>
    implements $KosPerformanceModelCopyWith<$Res> {
  _$KosPerformanceModelCopyWithImpl(this._self, this._then);

  final KosPerformanceModel _self;
  final $Res Function(KosPerformanceModel) _then;

/// Create a copy of KosPerformanceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? occupancy = null,Object? booking = null,Object? revenue = null,}) {
  return _then(KosPerformanceModel(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,occupancy: null == occupancy ? _self.occupancy : occupancy // ignore: cast_nullable_to_non_nullable
as int,booking: null == booking ? _self.booking : booking // ignore: cast_nullable_to_non_nullable
as int,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [KosPerformanceModel].
extension KosPerformanceModelPatterns on KosPerformanceModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KosPerformanceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KosPerformanceModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KosPerformanceModel value)  $default,){
final _that = this;
switch (_that) {
case _KosPerformanceModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KosPerformanceModel value)?  $default,){
final _that = this;
switch (_that) {
case _KosPerformanceModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title, @JsonKey(fromJson: intFromJson)  int occupancy, @JsonKey(fromJson: intFromJson)  int booking, @JsonKey(fromJson: doubleFromJson)  double revenue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KosPerformanceModel() when $default != null:
return $default(_that.title,_that.occupancy,_that.booking,_that.revenue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title, @JsonKey(fromJson: intFromJson)  int occupancy, @JsonKey(fromJson: intFromJson)  int booking, @JsonKey(fromJson: doubleFromJson)  double revenue)  $default,) {final _that = this;
switch (_that) {
case _KosPerformanceModel():
return $default(_that.title,_that.occupancy,_that.booking,_that.revenue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title, @JsonKey(fromJson: intFromJson)  int occupancy, @JsonKey(fromJson: intFromJson)  int booking, @JsonKey(fromJson: doubleFromJson)  double revenue)?  $default,) {final _that = this;
switch (_that) {
case _KosPerformanceModel() when $default != null:
return $default(_that.title,_that.occupancy,_that.booking,_that.revenue);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KosPerformanceModel implements KosPerformanceModel {
  const _KosPerformanceModel({required this.title, @JsonKey(fromJson: intFromJson) this.occupancy = 0, @JsonKey(fromJson: intFromJson) this.booking = 0, @JsonKey(fromJson: doubleFromJson) this.revenue = 0.0});
  factory _KosPerformanceModel.fromJson(Map<String, dynamic> json) => _$KosPerformanceModelFromJson(json);

@override final  String title;
@override@JsonKey(fromJson: intFromJson) final  int occupancy;
@override@JsonKey(fromJson: intFromJson) final  int booking;
@override@JsonKey(fromJson: doubleFromJson) final  double revenue;

/// Create a copy of KosPerformanceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KosPerformanceModelCopyWith<_KosPerformanceModel> get copyWith => __$KosPerformanceModelCopyWithImpl<_KosPerformanceModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KosPerformanceModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _KosPerformanceModel&&(identical(other.title, title) || other.title == title)&&(identical(other.occupancy, occupancy) || other.occupancy == occupancy)&&(identical(other.booking, booking) || other.booking == booking)&&(identical(other.revenue, revenue) || other.revenue == revenue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,title,occupancy,booking,revenue);
}

@override
String toString() {
    return 'KosPerformanceModel(title: $title, occupancy: $occupancy, booking: $booking, revenue: $revenue)';
}


}

/// @nodoc
abstract mixin class _$KosPerformanceModelCopyWith<$Res> implements $KosPerformanceModelCopyWith<$Res> {
  factory _$KosPerformanceModelCopyWith(_KosPerformanceModel value, $Res Function(_KosPerformanceModel) _then) = __$KosPerformanceModelCopyWithImpl;
@override @useResult
$Res call({
 String title,@JsonKey(fromJson: intFromJson) int occupancy,@JsonKey(fromJson: intFromJson) int booking,@JsonKey(fromJson: doubleFromJson) double revenue
});




}
/// @nodoc
class __$KosPerformanceModelCopyWithImpl<$Res>
    implements _$KosPerformanceModelCopyWith<$Res> {
  __$KosPerformanceModelCopyWithImpl(this._self, this._then);

  final _KosPerformanceModel _self;
  final $Res Function(_KosPerformanceModel) _then;

/// Create a copy of KosPerformanceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? occupancy = null,Object? booking = null,Object? revenue = null,}) {
  return _then(_KosPerformanceModel(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,occupancy: null == occupancy ? _self.occupancy : occupancy // ignore: cast_nullable_to_non_nullable
as int,booking: null == booking ? _self.booking : booking // ignore: cast_nullable_to_non_nullable
as int,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$OwnerAnalyticsModel {

@JsonKey(fromJson: doubleFromJson) double get totalRevenue;@JsonKey(fromJson: intFromJson) int get totalBookings;@JsonKey(fromJson: intFromJson) int get occupancyRate;@JsonKey(fromJson: doubleFromJson) double get revenueGrowthPct; List<MonthlyRevenuePoint> get monthlyRevenue; List<KosPerformanceModel> get kosPerformance;
/// Create a copy of OwnerAnalyticsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OwnerAnalyticsModelCopyWith<OwnerAnalyticsModel> get copyWith => _$OwnerAnalyticsModelCopyWithImpl<OwnerAnalyticsModel>(this as OwnerAnalyticsModel, _$identity);

  /// Serializes this OwnerAnalyticsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as OwnerAnalyticsModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OwnerAnalyticsModel&&(identical(other.totalRevenue, _this.totalRevenue) || other.totalRevenue == _this.totalRevenue)&&(identical(other.totalBookings, _this.totalBookings) || other.totalBookings == _this.totalBookings)&&(identical(other.occupancyRate, _this.occupancyRate) || other.occupancyRate == _this.occupancyRate)&&(identical(other.revenueGrowthPct, _this.revenueGrowthPct) || other.revenueGrowthPct == _this.revenueGrowthPct)&&const DeepCollectionEquality().equals(other.monthlyRevenue, _this.monthlyRevenue)&&const DeepCollectionEquality().equals(other.kosPerformance, _this.kosPerformance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as OwnerAnalyticsModel;
  return Object.hash(runtimeType,_this.totalRevenue,_this.totalBookings,_this.occupancyRate,_this.revenueGrowthPct,const DeepCollectionEquality().hash(_this.monthlyRevenue),const DeepCollectionEquality().hash(_this.kosPerformance));
}

@override
String toString() {
  final _this = this as OwnerAnalyticsModel;
  return 'OwnerAnalyticsModel(totalRevenue: ${_this.totalRevenue}, totalBookings: ${_this.totalBookings}, occupancyRate: ${_this.occupancyRate}, revenueGrowthPct: ${_this.revenueGrowthPct}, monthlyRevenue: ${_this.monthlyRevenue}, kosPerformance: ${_this.kosPerformance})';
}


}

/// @nodoc
abstract mixin class $OwnerAnalyticsModelCopyWith<$Res>  {
  factory $OwnerAnalyticsModelCopyWith(OwnerAnalyticsModel value, $Res Function(OwnerAnalyticsModel) _then) = _$OwnerAnalyticsModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: doubleFromJson) double totalRevenue,@JsonKey(fromJson: intFromJson) int totalBookings,@JsonKey(fromJson: intFromJson) int occupancyRate,@JsonKey(fromJson: doubleFromJson) double revenueGrowthPct, List<MonthlyRevenuePoint> monthlyRevenue, List<KosPerformanceModel> kosPerformance
});




}
/// @nodoc
class _$OwnerAnalyticsModelCopyWithImpl<$Res>
    implements $OwnerAnalyticsModelCopyWith<$Res> {
  _$OwnerAnalyticsModelCopyWithImpl(this._self, this._then);

  final OwnerAnalyticsModel _self;
  final $Res Function(OwnerAnalyticsModel) _then;

/// Create a copy of OwnerAnalyticsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalRevenue = null,Object? totalBookings = null,Object? occupancyRate = null,Object? revenueGrowthPct = null,Object? monthlyRevenue = null,Object? kosPerformance = null,}) {
  return _then(OwnerAnalyticsModel(
totalRevenue: null == totalRevenue ? _self.totalRevenue : totalRevenue // ignore: cast_nullable_to_non_nullable
as double,totalBookings: null == totalBookings ? _self.totalBookings : totalBookings // ignore: cast_nullable_to_non_nullable
as int,occupancyRate: null == occupancyRate ? _self.occupancyRate : occupancyRate // ignore: cast_nullable_to_non_nullable
as int,revenueGrowthPct: null == revenueGrowthPct ? _self.revenueGrowthPct : revenueGrowthPct // ignore: cast_nullable_to_non_nullable
as double,monthlyRevenue: null == monthlyRevenue ? _self.monthlyRevenue : monthlyRevenue // ignore: cast_nullable_to_non_nullable
as List<MonthlyRevenuePoint>,kosPerformance: null == kosPerformance ? _self.kosPerformance : kosPerformance // ignore: cast_nullable_to_non_nullable
as List<KosPerformanceModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [OwnerAnalyticsModel].
extension OwnerAnalyticsModelPatterns on OwnerAnalyticsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OwnerAnalyticsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OwnerAnalyticsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OwnerAnalyticsModel value)  $default,){
final _that = this;
switch (_that) {
case _OwnerAnalyticsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OwnerAnalyticsModel value)?  $default,){
final _that = this;
switch (_that) {
case _OwnerAnalyticsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: doubleFromJson)  double totalRevenue, @JsonKey(fromJson: intFromJson)  int totalBookings, @JsonKey(fromJson: intFromJson)  int occupancyRate, @JsonKey(fromJson: doubleFromJson)  double revenueGrowthPct,  List<MonthlyRevenuePoint> monthlyRevenue,  List<KosPerformanceModel> kosPerformance)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OwnerAnalyticsModel() when $default != null:
return $default(_that.totalRevenue,_that.totalBookings,_that.occupancyRate,_that.revenueGrowthPct,_that.monthlyRevenue,_that.kosPerformance);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: doubleFromJson)  double totalRevenue, @JsonKey(fromJson: intFromJson)  int totalBookings, @JsonKey(fromJson: intFromJson)  int occupancyRate, @JsonKey(fromJson: doubleFromJson)  double revenueGrowthPct,  List<MonthlyRevenuePoint> monthlyRevenue,  List<KosPerformanceModel> kosPerformance)  $default,) {final _that = this;
switch (_that) {
case _OwnerAnalyticsModel():
return $default(_that.totalRevenue,_that.totalBookings,_that.occupancyRate,_that.revenueGrowthPct,_that.monthlyRevenue,_that.kosPerformance);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: doubleFromJson)  double totalRevenue, @JsonKey(fromJson: intFromJson)  int totalBookings, @JsonKey(fromJson: intFromJson)  int occupancyRate, @JsonKey(fromJson: doubleFromJson)  double revenueGrowthPct,  List<MonthlyRevenuePoint> monthlyRevenue,  List<KosPerformanceModel> kosPerformance)?  $default,) {final _that = this;
switch (_that) {
case _OwnerAnalyticsModel() when $default != null:
return $default(_that.totalRevenue,_that.totalBookings,_that.occupancyRate,_that.revenueGrowthPct,_that.monthlyRevenue,_that.kosPerformance);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OwnerAnalyticsModel implements OwnerAnalyticsModel {
  const _OwnerAnalyticsModel({@JsonKey(fromJson: doubleFromJson) this.totalRevenue = 0.0, @JsonKey(fromJson: intFromJson) this.totalBookings = 0, @JsonKey(fromJson: intFromJson) this.occupancyRate = 0, @JsonKey(fromJson: doubleFromJson) this.revenueGrowthPct = 0.0,  List<MonthlyRevenuePoint> monthlyRevenue = const [],  List<KosPerformanceModel> kosPerformance = const []}): _monthlyRevenue = monthlyRevenue,_kosPerformance = kosPerformance;
  factory _OwnerAnalyticsModel.fromJson(Map<String, dynamic> json) => _$OwnerAnalyticsModelFromJson(json);

@override@JsonKey(fromJson: doubleFromJson) final  double totalRevenue;
@override@JsonKey(fromJson: intFromJson) final  int totalBookings;
@override@JsonKey(fromJson: intFromJson) final  int occupancyRate;
@override@JsonKey(fromJson: doubleFromJson) final  double revenueGrowthPct;
 final  List<MonthlyRevenuePoint> _monthlyRevenue;
@override@JsonKey() List<MonthlyRevenuePoint> get monthlyRevenue {
  if (_monthlyRevenue is EqualUnmodifiableListView) return _monthlyRevenue;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_monthlyRevenue);
}

 final  List<KosPerformanceModel> _kosPerformance;
@override@JsonKey() List<KosPerformanceModel> get kosPerformance {
  if (_kosPerformance is EqualUnmodifiableListView) return _kosPerformance;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_kosPerformance);
}


/// Create a copy of OwnerAnalyticsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OwnerAnalyticsModelCopyWith<_OwnerAnalyticsModel> get copyWith => __$OwnerAnalyticsModelCopyWithImpl<_OwnerAnalyticsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OwnerAnalyticsModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OwnerAnalyticsModel&&(identical(other.totalRevenue, totalRevenue) || other.totalRevenue == totalRevenue)&&(identical(other.totalBookings, totalBookings) || other.totalBookings == totalBookings)&&(identical(other.occupancyRate, occupancyRate) || other.occupancyRate == occupancyRate)&&(identical(other.revenueGrowthPct, revenueGrowthPct) || other.revenueGrowthPct == revenueGrowthPct)&&const DeepCollectionEquality().equals(other.monthlyRevenue, _monthlyRevenue)&&const DeepCollectionEquality().equals(other.kosPerformance, _kosPerformance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,totalRevenue,totalBookings,occupancyRate,revenueGrowthPct,const DeepCollectionEquality().hash(_monthlyRevenue),const DeepCollectionEquality().hash(_kosPerformance));
}

@override
String toString() {
    return 'OwnerAnalyticsModel(totalRevenue: $totalRevenue, totalBookings: $totalBookings, occupancyRate: $occupancyRate, revenueGrowthPct: $revenueGrowthPct, monthlyRevenue: $monthlyRevenue, kosPerformance: $kosPerformance)';
}


}

/// @nodoc
abstract mixin class _$OwnerAnalyticsModelCopyWith<$Res> implements $OwnerAnalyticsModelCopyWith<$Res> {
  factory _$OwnerAnalyticsModelCopyWith(_OwnerAnalyticsModel value, $Res Function(_OwnerAnalyticsModel) _then) = __$OwnerAnalyticsModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: doubleFromJson) double totalRevenue,@JsonKey(fromJson: intFromJson) int totalBookings,@JsonKey(fromJson: intFromJson) int occupancyRate,@JsonKey(fromJson: doubleFromJson) double revenueGrowthPct, List<MonthlyRevenuePoint> monthlyRevenue, List<KosPerformanceModel> kosPerformance
});




}
/// @nodoc
class __$OwnerAnalyticsModelCopyWithImpl<$Res>
    implements _$OwnerAnalyticsModelCopyWith<$Res> {
  __$OwnerAnalyticsModelCopyWithImpl(this._self, this._then);

  final _OwnerAnalyticsModel _self;
  final $Res Function(_OwnerAnalyticsModel) _then;

/// Create a copy of OwnerAnalyticsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalRevenue = null,Object? totalBookings = null,Object? occupancyRate = null,Object? revenueGrowthPct = null,Object? monthlyRevenue = null,Object? kosPerformance = null,}) {
  return _then(_OwnerAnalyticsModel(
totalRevenue: null == totalRevenue ? _self.totalRevenue : totalRevenue // ignore: cast_nullable_to_non_nullable
as double,totalBookings: null == totalBookings ? _self.totalBookings : totalBookings // ignore: cast_nullable_to_non_nullable
as int,occupancyRate: null == occupancyRate ? _self.occupancyRate : occupancyRate // ignore: cast_nullable_to_non_nullable
as int,revenueGrowthPct: null == revenueGrowthPct ? _self.revenueGrowthPct : revenueGrowthPct // ignore: cast_nullable_to_non_nullable
as double,monthlyRevenue: null == monthlyRevenue ? _self._monthlyRevenue : monthlyRevenue // ignore: cast_nullable_to_non_nullable
as List<MonthlyRevenuePoint>,kosPerformance: null == kosPerformance ? _self._kosPerformance : kosPerformance // ignore: cast_nullable_to_non_nullable
as List<KosPerformanceModel>,
  ));
}


}

// dart format on
