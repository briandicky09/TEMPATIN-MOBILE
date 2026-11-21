// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PaymentModel {

 int get id; String get paymentCode; String? get orderId; String get paymentMethod; String? get paymentChannel; String? get transactionId;@JsonKey(fromJson: doubleFromJson) double get amount; String? get snapToken; String? get snapRedirectUrl; String get status; DateTime? get paidAt; DateTime? get createdAt;
/// Create a copy of PaymentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentModelCopyWith<PaymentModel> get copyWith => _$PaymentModelCopyWithImpl<PaymentModel>(this as PaymentModel, _$identity);

  /// Serializes this PaymentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PaymentModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.paymentCode, _this.paymentCode) || other.paymentCode == _this.paymentCode)&&(identical(other.orderId, _this.orderId) || other.orderId == _this.orderId)&&(identical(other.paymentMethod, _this.paymentMethod) || other.paymentMethod == _this.paymentMethod)&&(identical(other.paymentChannel, _this.paymentChannel) || other.paymentChannel == _this.paymentChannel)&&(identical(other.transactionId, _this.transactionId) || other.transactionId == _this.transactionId)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.snapToken, _this.snapToken) || other.snapToken == _this.snapToken)&&(identical(other.snapRedirectUrl, _this.snapRedirectUrl) || other.snapRedirectUrl == _this.snapRedirectUrl)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.paidAt, _this.paidAt) || other.paidAt == _this.paidAt)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PaymentModel;
  return Object.hash(runtimeType,_this.id,_this.paymentCode,_this.orderId,_this.paymentMethod,_this.paymentChannel,_this.transactionId,_this.amount,_this.snapToken,_this.snapRedirectUrl,_this.status,_this.paidAt,_this.createdAt);
}

@override
String toString() {
  final _this = this as PaymentModel;
  return 'PaymentModel(id: ${_this.id}, paymentCode: ${_this.paymentCode}, orderId: ${_this.orderId}, paymentMethod: ${_this.paymentMethod}, paymentChannel: ${_this.paymentChannel}, transactionId: ${_this.transactionId}, amount: ${_this.amount}, snapToken: ${_this.snapToken}, snapRedirectUrl: ${_this.snapRedirectUrl}, status: ${_this.status}, paidAt: ${_this.paidAt}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $PaymentModelCopyWith<$Res>  {
  factory $PaymentModelCopyWith(PaymentModel value, $Res Function(PaymentModel) _then) = _$PaymentModelCopyWithImpl;
@useResult
$Res call({
 int id, String paymentCode, String? orderId, String paymentMethod, String? paymentChannel, String? transactionId,@JsonKey(fromJson: doubleFromJson) double amount, String? snapToken, String? snapRedirectUrl, String status, DateTime? paidAt, DateTime? createdAt
});




}
/// @nodoc
class _$PaymentModelCopyWithImpl<$Res>
    implements $PaymentModelCopyWith<$Res> {
  _$PaymentModelCopyWithImpl(this._self, this._then);

  final PaymentModel _self;
  final $Res Function(PaymentModel) _then;

/// Create a copy of PaymentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? paymentCode = null,Object? orderId = freezed,Object? paymentMethod = null,Object? paymentChannel = freezed,Object? transactionId = freezed,Object? amount = null,Object? snapToken = freezed,Object? snapRedirectUrl = freezed,Object? status = null,Object? paidAt = freezed,Object? createdAt = freezed,}) {
  return _then(PaymentModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,paymentCode: null == paymentCode ? _self.paymentCode : paymentCode // ignore: cast_nullable_to_non_nullable
as String,orderId: freezed == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String?,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String,paymentChannel: freezed == paymentChannel ? _self.paymentChannel : paymentChannel // ignore: cast_nullable_to_non_nullable
as String?,transactionId: freezed == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,snapToken: freezed == snapToken ? _self.snapToken : snapToken // ignore: cast_nullable_to_non_nullable
as String?,snapRedirectUrl: freezed == snapRedirectUrl ? _self.snapRedirectUrl : snapRedirectUrl // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,paidAt: freezed == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentModel].
extension PaymentModelPatterns on PaymentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentModel value)  $default,){
final _that = this;
switch (_that) {
case _PaymentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentModel value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String paymentCode,  String? orderId,  String paymentMethod,  String? paymentChannel,  String? transactionId, @JsonKey(fromJson: doubleFromJson)  double amount,  String? snapToken,  String? snapRedirectUrl,  String status,  DateTime? paidAt,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentModel() when $default != null:
return $default(_that.id,_that.paymentCode,_that.orderId,_that.paymentMethod,_that.paymentChannel,_that.transactionId,_that.amount,_that.snapToken,_that.snapRedirectUrl,_that.status,_that.paidAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String paymentCode,  String? orderId,  String paymentMethod,  String? paymentChannel,  String? transactionId, @JsonKey(fromJson: doubleFromJson)  double amount,  String? snapToken,  String? snapRedirectUrl,  String status,  DateTime? paidAt,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _PaymentModel():
return $default(_that.id,_that.paymentCode,_that.orderId,_that.paymentMethod,_that.paymentChannel,_that.transactionId,_that.amount,_that.snapToken,_that.snapRedirectUrl,_that.status,_that.paidAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String paymentCode,  String? orderId,  String paymentMethod,  String? paymentChannel,  String? transactionId, @JsonKey(fromJson: doubleFromJson)  double amount,  String? snapToken,  String? snapRedirectUrl,  String status,  DateTime? paidAt,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _PaymentModel() when $default != null:
return $default(_that.id,_that.paymentCode,_that.orderId,_that.paymentMethod,_that.paymentChannel,_that.transactionId,_that.amount,_that.snapToken,_that.snapRedirectUrl,_that.status,_that.paidAt,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentModel implements PaymentModel {
  const _PaymentModel({required this.id, required this.paymentCode, this.orderId, required this.paymentMethod, this.paymentChannel, this.transactionId, @JsonKey(fromJson: doubleFromJson) required this.amount, this.snapToken, this.snapRedirectUrl, required this.status, this.paidAt, this.createdAt});
  factory _PaymentModel.fromJson(Map<String, dynamic> json) => _$PaymentModelFromJson(json);

@override final  int id;
@override final  String paymentCode;
@override final  String? orderId;
@override final  String paymentMethod;
@override final  String? paymentChannel;
@override final  String? transactionId;
@override@JsonKey(fromJson: doubleFromJson) final  double amount;
@override final  String? snapToken;
@override final  String? snapRedirectUrl;
@override final  String status;
@override final  DateTime? paidAt;
@override final  DateTime? createdAt;

/// Create a copy of PaymentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentModelCopyWith<_PaymentModel> get copyWith => __$PaymentModelCopyWithImpl<_PaymentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.paymentCode, paymentCode) || other.paymentCode == paymentCode)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.paymentChannel, paymentChannel) || other.paymentChannel == paymentChannel)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.snapToken, snapToken) || other.snapToken == snapToken)&&(identical(other.snapRedirectUrl, snapRedirectUrl) || other.snapRedirectUrl == snapRedirectUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,paymentCode,orderId,paymentMethod,paymentChannel,transactionId,amount,snapToken,snapRedirectUrl,status,paidAt,createdAt);
}

@override
String toString() {
    return 'PaymentModel(id: $id, paymentCode: $paymentCode, orderId: $orderId, paymentMethod: $paymentMethod, paymentChannel: $paymentChannel, transactionId: $transactionId, amount: $amount, snapToken: $snapToken, snapRedirectUrl: $snapRedirectUrl, status: $status, paidAt: $paidAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$PaymentModelCopyWith<$Res> implements $PaymentModelCopyWith<$Res> {
  factory _$PaymentModelCopyWith(_PaymentModel value, $Res Function(_PaymentModel) _then) = __$PaymentModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String paymentCode, String? orderId, String paymentMethod, String? paymentChannel, String? transactionId,@JsonKey(fromJson: doubleFromJson) double amount, String? snapToken, String? snapRedirectUrl, String status, DateTime? paidAt, DateTime? createdAt
});




}
/// @nodoc
class __$PaymentModelCopyWithImpl<$Res>
    implements _$PaymentModelCopyWith<$Res> {
  __$PaymentModelCopyWithImpl(this._self, this._then);

  final _PaymentModel _self;
  final $Res Function(_PaymentModel) _then;

/// Create a copy of PaymentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? paymentCode = null,Object? orderId = freezed,Object? paymentMethod = null,Object? paymentChannel = freezed,Object? transactionId = freezed,Object? amount = null,Object? snapToken = freezed,Object? snapRedirectUrl = freezed,Object? status = null,Object? paidAt = freezed,Object? createdAt = freezed,}) {
  return _then(_PaymentModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,paymentCode: null == paymentCode ? _self.paymentCode : paymentCode // ignore: cast_nullable_to_non_nullable
as String,orderId: freezed == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String?,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String,paymentChannel: freezed == paymentChannel ? _self.paymentChannel : paymentChannel // ignore: cast_nullable_to_non_nullable
as String?,transactionId: freezed == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,snapToken: freezed == snapToken ? _self.snapToken : snapToken // ignore: cast_nullable_to_non_nullable
as String?,snapRedirectUrl: freezed == snapRedirectUrl ? _self.snapRedirectUrl : snapRedirectUrl // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,paidAt: freezed == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$InvoiceModel {

 int get id; String get invoiceNumber; String? get bookingCode; String? get kosTitle; String? get kosSlug;@JsonKey(fromJson: doubleFromJson) double get amount;@JsonKey(fromJson: doubleFromJson) double get adminFee;@JsonKey(fromJson: doubleFromJson) double get tax;@JsonKey(fromJson: doubleFromJson) double get totalAmount; String? get dueDate; DateTime? get paidAt; String get status; String? get statusLabel; List<PaymentModel> get payments; DateTime? get createdAt;
/// Create a copy of InvoiceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvoiceModelCopyWith<InvoiceModel> get copyWith => _$InvoiceModelCopyWithImpl<InvoiceModel>(this as InvoiceModel, _$identity);

  /// Serializes this InvoiceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as InvoiceModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvoiceModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.invoiceNumber, _this.invoiceNumber) || other.invoiceNumber == _this.invoiceNumber)&&(identical(other.bookingCode, _this.bookingCode) || other.bookingCode == _this.bookingCode)&&(identical(other.kosTitle, _this.kosTitle) || other.kosTitle == _this.kosTitle)&&(identical(other.kosSlug, _this.kosSlug) || other.kosSlug == _this.kosSlug)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.adminFee, _this.adminFee) || other.adminFee == _this.adminFee)&&(identical(other.tax, _this.tax) || other.tax == _this.tax)&&(identical(other.totalAmount, _this.totalAmount) || other.totalAmount == _this.totalAmount)&&(identical(other.dueDate, _this.dueDate) || other.dueDate == _this.dueDate)&&(identical(other.paidAt, _this.paidAt) || other.paidAt == _this.paidAt)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.statusLabel, _this.statusLabel) || other.statusLabel == _this.statusLabel)&&const DeepCollectionEquality().equals(other.payments, _this.payments)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as InvoiceModel;
  return Object.hash(runtimeType,_this.id,_this.invoiceNumber,_this.bookingCode,_this.kosTitle,_this.kosSlug,_this.amount,_this.adminFee,_this.tax,_this.totalAmount,_this.dueDate,_this.paidAt,_this.status,_this.statusLabel,const DeepCollectionEquality().hash(_this.payments),_this.createdAt);
}

@override
String toString() {
  final _this = this as InvoiceModel;
  return 'InvoiceModel(id: ${_this.id}, invoiceNumber: ${_this.invoiceNumber}, bookingCode: ${_this.bookingCode}, kosTitle: ${_this.kosTitle}, kosSlug: ${_this.kosSlug}, amount: ${_this.amount}, adminFee: ${_this.adminFee}, tax: ${_this.tax}, totalAmount: ${_this.totalAmount}, dueDate: ${_this.dueDate}, paidAt: ${_this.paidAt}, status: ${_this.status}, statusLabel: ${_this.statusLabel}, payments: ${_this.payments}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $InvoiceModelCopyWith<$Res>  {
  factory $InvoiceModelCopyWith(InvoiceModel value, $Res Function(InvoiceModel) _then) = _$InvoiceModelCopyWithImpl;
@useResult
$Res call({
 int id, String invoiceNumber, String? bookingCode, String? kosTitle, String? kosSlug,@JsonKey(fromJson: doubleFromJson) double amount,@JsonKey(fromJson: doubleFromJson) double adminFee,@JsonKey(fromJson: doubleFromJson) double tax,@JsonKey(fromJson: doubleFromJson) double totalAmount, String? dueDate, DateTime? paidAt, String status, String? statusLabel, List<PaymentModel> payments, DateTime? createdAt
});




}
/// @nodoc
class _$InvoiceModelCopyWithImpl<$Res>
    implements $InvoiceModelCopyWith<$Res> {
  _$InvoiceModelCopyWithImpl(this._self, this._then);

  final InvoiceModel _self;
  final $Res Function(InvoiceModel) _then;

/// Create a copy of InvoiceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? invoiceNumber = null,Object? bookingCode = freezed,Object? kosTitle = freezed,Object? kosSlug = freezed,Object? amount = null,Object? adminFee = null,Object? tax = null,Object? totalAmount = null,Object? dueDate = freezed,Object? paidAt = freezed,Object? status = null,Object? statusLabel = freezed,Object? payments = null,Object? createdAt = freezed,}) {
  return _then(InvoiceModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,invoiceNumber: null == invoiceNumber ? _self.invoiceNumber : invoiceNumber // ignore: cast_nullable_to_non_nullable
as String,bookingCode: freezed == bookingCode ? _self.bookingCode : bookingCode // ignore: cast_nullable_to_non_nullable
as String?,kosTitle: freezed == kosTitle ? _self.kosTitle : kosTitle // ignore: cast_nullable_to_non_nullable
as String?,kosSlug: freezed == kosSlug ? _self.kosSlug : kosSlug // ignore: cast_nullable_to_non_nullable
as String?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,adminFee: null == adminFee ? _self.adminFee : adminFee // ignore: cast_nullable_to_non_nullable
as double,tax: null == tax ? _self.tax : tax // ignore: cast_nullable_to_non_nullable
as double,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as String?,paidAt: freezed == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,statusLabel: freezed == statusLabel ? _self.statusLabel : statusLabel // ignore: cast_nullable_to_non_nullable
as String?,payments: null == payments ? _self.payments : payments // ignore: cast_nullable_to_non_nullable
as List<PaymentModel>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [InvoiceModel].
extension InvoiceModelPatterns on InvoiceModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InvoiceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InvoiceModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InvoiceModel value)  $default,){
final _that = this;
switch (_that) {
case _InvoiceModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InvoiceModel value)?  $default,){
final _that = this;
switch (_that) {
case _InvoiceModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String invoiceNumber,  String? bookingCode,  String? kosTitle,  String? kosSlug, @JsonKey(fromJson: doubleFromJson)  double amount, @JsonKey(fromJson: doubleFromJson)  double adminFee, @JsonKey(fromJson: doubleFromJson)  double tax, @JsonKey(fromJson: doubleFromJson)  double totalAmount,  String? dueDate,  DateTime? paidAt,  String status,  String? statusLabel,  List<PaymentModel> payments,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InvoiceModel() when $default != null:
return $default(_that.id,_that.invoiceNumber,_that.bookingCode,_that.kosTitle,_that.kosSlug,_that.amount,_that.adminFee,_that.tax,_that.totalAmount,_that.dueDate,_that.paidAt,_that.status,_that.statusLabel,_that.payments,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String invoiceNumber,  String? bookingCode,  String? kosTitle,  String? kosSlug, @JsonKey(fromJson: doubleFromJson)  double amount, @JsonKey(fromJson: doubleFromJson)  double adminFee, @JsonKey(fromJson: doubleFromJson)  double tax, @JsonKey(fromJson: doubleFromJson)  double totalAmount,  String? dueDate,  DateTime? paidAt,  String status,  String? statusLabel,  List<PaymentModel> payments,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _InvoiceModel():
return $default(_that.id,_that.invoiceNumber,_that.bookingCode,_that.kosTitle,_that.kosSlug,_that.amount,_that.adminFee,_that.tax,_that.totalAmount,_that.dueDate,_that.paidAt,_that.status,_that.statusLabel,_that.payments,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String invoiceNumber,  String? bookingCode,  String? kosTitle,  String? kosSlug, @JsonKey(fromJson: doubleFromJson)  double amount, @JsonKey(fromJson: doubleFromJson)  double adminFee, @JsonKey(fromJson: doubleFromJson)  double tax, @JsonKey(fromJson: doubleFromJson)  double totalAmount,  String? dueDate,  DateTime? paidAt,  String status,  String? statusLabel,  List<PaymentModel> payments,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _InvoiceModel() when $default != null:
return $default(_that.id,_that.invoiceNumber,_that.bookingCode,_that.kosTitle,_that.kosSlug,_that.amount,_that.adminFee,_that.tax,_that.totalAmount,_that.dueDate,_that.paidAt,_that.status,_that.statusLabel,_that.payments,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InvoiceModel implements InvoiceModel {
  const _InvoiceModel({required this.id, required this.invoiceNumber, this.bookingCode, this.kosTitle, this.kosSlug, @JsonKey(fromJson: doubleFromJson) required this.amount, @JsonKey(fromJson: doubleFromJson) this.adminFee = 25000.0, @JsonKey(fromJson: doubleFromJson) this.tax = 0.0, @JsonKey(fromJson: doubleFromJson) required this.totalAmount, this.dueDate, this.paidAt, required this.status, this.statusLabel,  List<PaymentModel> payments = const [], this.createdAt}): _payments = payments;
  factory _InvoiceModel.fromJson(Map<String, dynamic> json) => _$InvoiceModelFromJson(json);

@override final  int id;
@override final  String invoiceNumber;
@override final  String? bookingCode;
@override final  String? kosTitle;
@override final  String? kosSlug;
@override@JsonKey(fromJson: doubleFromJson) final  double amount;
@override@JsonKey(fromJson: doubleFromJson) final  double adminFee;
@override@JsonKey(fromJson: doubleFromJson) final  double tax;
@override@JsonKey(fromJson: doubleFromJson) final  double totalAmount;
@override final  String? dueDate;
@override final  DateTime? paidAt;
@override final  String status;
@override final  String? statusLabel;
 final  List<PaymentModel> _payments;
@override@JsonKey() List<PaymentModel> get payments {
  if (_payments is EqualUnmodifiableListView) return _payments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_payments);
}

@override final  DateTime? createdAt;

/// Create a copy of InvoiceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InvoiceModelCopyWith<_InvoiceModel> get copyWith => __$InvoiceModelCopyWithImpl<_InvoiceModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InvoiceModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _InvoiceModel&&(identical(other.id, id) || other.id == id)&&(identical(other.invoiceNumber, invoiceNumber) || other.invoiceNumber == invoiceNumber)&&(identical(other.bookingCode, bookingCode) || other.bookingCode == bookingCode)&&(identical(other.kosTitle, kosTitle) || other.kosTitle == kosTitle)&&(identical(other.kosSlug, kosSlug) || other.kosSlug == kosSlug)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.adminFee, adminFee) || other.adminFee == adminFee)&&(identical(other.tax, tax) || other.tax == tax)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.statusLabel, statusLabel) || other.statusLabel == statusLabel)&&const DeepCollectionEquality().equals(other.payments, _payments)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,invoiceNumber,bookingCode,kosTitle,kosSlug,amount,adminFee,tax,totalAmount,dueDate,paidAt,status,statusLabel,const DeepCollectionEquality().hash(_payments),createdAt);
}

@override
String toString() {
    return 'InvoiceModel(id: $id, invoiceNumber: $invoiceNumber, bookingCode: $bookingCode, kosTitle: $kosTitle, kosSlug: $kosSlug, amount: $amount, adminFee: $adminFee, tax: $tax, totalAmount: $totalAmount, dueDate: $dueDate, paidAt: $paidAt, status: $status, statusLabel: $statusLabel, payments: $payments, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$InvoiceModelCopyWith<$Res> implements $InvoiceModelCopyWith<$Res> {
  factory _$InvoiceModelCopyWith(_InvoiceModel value, $Res Function(_InvoiceModel) _then) = __$InvoiceModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String invoiceNumber, String? bookingCode, String? kosTitle, String? kosSlug,@JsonKey(fromJson: doubleFromJson) double amount,@JsonKey(fromJson: doubleFromJson) double adminFee,@JsonKey(fromJson: doubleFromJson) double tax,@JsonKey(fromJson: doubleFromJson) double totalAmount, String? dueDate, DateTime? paidAt, String status, String? statusLabel, List<PaymentModel> payments, DateTime? createdAt
});




}
/// @nodoc
class __$InvoiceModelCopyWithImpl<$Res>
    implements _$InvoiceModelCopyWith<$Res> {
  __$InvoiceModelCopyWithImpl(this._self, this._then);

  final _InvoiceModel _self;
  final $Res Function(_InvoiceModel) _then;

/// Create a copy of InvoiceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? invoiceNumber = null,Object? bookingCode = freezed,Object? kosTitle = freezed,Object? kosSlug = freezed,Object? amount = null,Object? adminFee = null,Object? tax = null,Object? totalAmount = null,Object? dueDate = freezed,Object? paidAt = freezed,Object? status = null,Object? statusLabel = freezed,Object? payments = null,Object? createdAt = freezed,}) {
  return _then(_InvoiceModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,invoiceNumber: null == invoiceNumber ? _self.invoiceNumber : invoiceNumber // ignore: cast_nullable_to_non_nullable
as String,bookingCode: freezed == bookingCode ? _self.bookingCode : bookingCode // ignore: cast_nullable_to_non_nullable
as String?,kosTitle: freezed == kosTitle ? _self.kosTitle : kosTitle // ignore: cast_nullable_to_non_nullable
as String?,kosSlug: freezed == kosSlug ? _self.kosSlug : kosSlug // ignore: cast_nullable_to_non_nullable
as String?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,adminFee: null == adminFee ? _self.adminFee : adminFee // ignore: cast_nullable_to_non_nullable
as double,tax: null == tax ? _self.tax : tax // ignore: cast_nullable_to_non_nullable
as double,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as String?,paidAt: freezed == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,statusLabel: freezed == statusLabel ? _self.statusLabel : statusLabel // ignore: cast_nullable_to_non_nullable
as String?,payments: null == payments ? _self._payments : payments // ignore: cast_nullable_to_non_nullable
as List<PaymentModel>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$RentalContractModel {

 int get id; String get contractNumber; String? get bookingCode; String get terms; String get status; bool get isSigned; DateTime? get signedAt; String? get signerIp; DateTime? get createdAt;
/// Create a copy of RentalContractModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RentalContractModelCopyWith<RentalContractModel> get copyWith => _$RentalContractModelCopyWithImpl<RentalContractModel>(this as RentalContractModel, _$identity);

  /// Serializes this RentalContractModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RentalContractModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RentalContractModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.contractNumber, _this.contractNumber) || other.contractNumber == _this.contractNumber)&&(identical(other.bookingCode, _this.bookingCode) || other.bookingCode == _this.bookingCode)&&(identical(other.terms, _this.terms) || other.terms == _this.terms)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.isSigned, _this.isSigned) || other.isSigned == _this.isSigned)&&(identical(other.signedAt, _this.signedAt) || other.signedAt == _this.signedAt)&&(identical(other.signerIp, _this.signerIp) || other.signerIp == _this.signerIp)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RentalContractModel;
  return Object.hash(runtimeType,_this.id,_this.contractNumber,_this.bookingCode,_this.terms,_this.status,_this.isSigned,_this.signedAt,_this.signerIp,_this.createdAt);
}

@override
String toString() {
  final _this = this as RentalContractModel;
  return 'RentalContractModel(id: ${_this.id}, contractNumber: ${_this.contractNumber}, bookingCode: ${_this.bookingCode}, terms: ${_this.terms}, status: ${_this.status}, isSigned: ${_this.isSigned}, signedAt: ${_this.signedAt}, signerIp: ${_this.signerIp}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $RentalContractModelCopyWith<$Res>  {
  factory $RentalContractModelCopyWith(RentalContractModel value, $Res Function(RentalContractModel) _then) = _$RentalContractModelCopyWithImpl;
@useResult
$Res call({
 int id, String contractNumber, String? bookingCode, String terms, String status, bool isSigned, DateTime? signedAt, String? signerIp, DateTime? createdAt
});




}
/// @nodoc
class _$RentalContractModelCopyWithImpl<$Res>
    implements $RentalContractModelCopyWith<$Res> {
  _$RentalContractModelCopyWithImpl(this._self, this._then);

  final RentalContractModel _self;
  final $Res Function(RentalContractModel) _then;

/// Create a copy of RentalContractModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? contractNumber = null,Object? bookingCode = freezed,Object? terms = null,Object? status = null,Object? isSigned = null,Object? signedAt = freezed,Object? signerIp = freezed,Object? createdAt = freezed,}) {
  return _then(RentalContractModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,contractNumber: null == contractNumber ? _self.contractNumber : contractNumber // ignore: cast_nullable_to_non_nullable
as String,bookingCode: freezed == bookingCode ? _self.bookingCode : bookingCode // ignore: cast_nullable_to_non_nullable
as String?,terms: null == terms ? _self.terms : terms // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,isSigned: null == isSigned ? _self.isSigned : isSigned // ignore: cast_nullable_to_non_nullable
as bool,signedAt: freezed == signedAt ? _self.signedAt : signedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,signerIp: freezed == signerIp ? _self.signerIp : signerIp // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [RentalContractModel].
extension RentalContractModelPatterns on RentalContractModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RentalContractModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RentalContractModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RentalContractModel value)  $default,){
final _that = this;
switch (_that) {
case _RentalContractModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RentalContractModel value)?  $default,){
final _that = this;
switch (_that) {
case _RentalContractModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String contractNumber,  String? bookingCode,  String terms,  String status,  bool isSigned,  DateTime? signedAt,  String? signerIp,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RentalContractModel() when $default != null:
return $default(_that.id,_that.contractNumber,_that.bookingCode,_that.terms,_that.status,_that.isSigned,_that.signedAt,_that.signerIp,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String contractNumber,  String? bookingCode,  String terms,  String status,  bool isSigned,  DateTime? signedAt,  String? signerIp,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _RentalContractModel():
return $default(_that.id,_that.contractNumber,_that.bookingCode,_that.terms,_that.status,_that.isSigned,_that.signedAt,_that.signerIp,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String contractNumber,  String? bookingCode,  String terms,  String status,  bool isSigned,  DateTime? signedAt,  String? signerIp,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _RentalContractModel() when $default != null:
return $default(_that.id,_that.contractNumber,_that.bookingCode,_that.terms,_that.status,_that.isSigned,_that.signedAt,_that.signerIp,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RentalContractModel implements RentalContractModel {
  const _RentalContractModel({required this.id, required this.contractNumber, this.bookingCode, required this.terms, required this.status, this.isSigned = false, this.signedAt, this.signerIp, this.createdAt});
  factory _RentalContractModel.fromJson(Map<String, dynamic> json) => _$RentalContractModelFromJson(json);

@override final  int id;
@override final  String contractNumber;
@override final  String? bookingCode;
@override final  String terms;
@override final  String status;
@override@JsonKey() final  bool isSigned;
@override final  DateTime? signedAt;
@override final  String? signerIp;
@override final  DateTime? createdAt;

/// Create a copy of RentalContractModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RentalContractModelCopyWith<_RentalContractModel> get copyWith => __$RentalContractModelCopyWithImpl<_RentalContractModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RentalContractModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RentalContractModel&&(identical(other.id, id) || other.id == id)&&(identical(other.contractNumber, contractNumber) || other.contractNumber == contractNumber)&&(identical(other.bookingCode, bookingCode) || other.bookingCode == bookingCode)&&(identical(other.terms, terms) || other.terms == terms)&&(identical(other.status, status) || other.status == status)&&(identical(other.isSigned, isSigned) || other.isSigned == isSigned)&&(identical(other.signedAt, signedAt) || other.signedAt == signedAt)&&(identical(other.signerIp, signerIp) || other.signerIp == signerIp)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,contractNumber,bookingCode,terms,status,isSigned,signedAt,signerIp,createdAt);
}

@override
String toString() {
    return 'RentalContractModel(id: $id, contractNumber: $contractNumber, bookingCode: $bookingCode, terms: $terms, status: $status, isSigned: $isSigned, signedAt: $signedAt, signerIp: $signerIp, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$RentalContractModelCopyWith<$Res> implements $RentalContractModelCopyWith<$Res> {
  factory _$RentalContractModelCopyWith(_RentalContractModel value, $Res Function(_RentalContractModel) _then) = __$RentalContractModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String contractNumber, String? bookingCode, String terms, String status, bool isSigned, DateTime? signedAt, String? signerIp, DateTime? createdAt
});




}
/// @nodoc
class __$RentalContractModelCopyWithImpl<$Res>
    implements _$RentalContractModelCopyWith<$Res> {
  __$RentalContractModelCopyWithImpl(this._self, this._then);

  final _RentalContractModel _self;
  final $Res Function(_RentalContractModel) _then;

/// Create a copy of RentalContractModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? contractNumber = null,Object? bookingCode = freezed,Object? terms = null,Object? status = null,Object? isSigned = null,Object? signedAt = freezed,Object? signerIp = freezed,Object? createdAt = freezed,}) {
  return _then(_RentalContractModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,contractNumber: null == contractNumber ? _self.contractNumber : contractNumber // ignore: cast_nullable_to_non_nullable
as String,bookingCode: freezed == bookingCode ? _self.bookingCode : bookingCode // ignore: cast_nullable_to_non_nullable
as String?,terms: null == terms ? _self.terms : terms // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,isSigned: null == isSigned ? _self.isSigned : isSigned // ignore: cast_nullable_to_non_nullable
as bool,signedAt: freezed == signedAt ? _self.signedAt : signedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,signerIp: freezed == signerIp ? _self.signerIp : signerIp // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$BookingModel {

 int get id; String get bookingCode; String get tenantName; String get tenantPhone; String get tenantEmail; String get startDate; String get endDate;@JsonKey(fromJson: intFromJson) int get durationMonths;@JsonKey(fromJson: doubleFromJson) double get kosPrice;@JsonKey(fromJson: doubleFromJson) double get subtotal;@JsonKey(fromJson: doubleFromJson) double get adminFee;@JsonKey(fromJson: doubleFromJson) double get totalAmount; String? get notes; String get status; String? get statusLabel; String? get rejectionReason; KosSummaryModel? get kos; RoomModel? get room; UserModel? get customer; InvoiceModel? get invoice; RentalContractModel? get contract; DateTime? get createdAt;
/// Create a copy of BookingModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingModelCopyWith<BookingModel> get copyWith => _$BookingModelCopyWithImpl<BookingModel>(this as BookingModel, _$identity);

  /// Serializes this BookingModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as BookingModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.bookingCode, _this.bookingCode) || other.bookingCode == _this.bookingCode)&&(identical(other.tenantName, _this.tenantName) || other.tenantName == _this.tenantName)&&(identical(other.tenantPhone, _this.tenantPhone) || other.tenantPhone == _this.tenantPhone)&&(identical(other.tenantEmail, _this.tenantEmail) || other.tenantEmail == _this.tenantEmail)&&(identical(other.startDate, _this.startDate) || other.startDate == _this.startDate)&&(identical(other.endDate, _this.endDate) || other.endDate == _this.endDate)&&(identical(other.durationMonths, _this.durationMonths) || other.durationMonths == _this.durationMonths)&&(identical(other.kosPrice, _this.kosPrice) || other.kosPrice == _this.kosPrice)&&(identical(other.subtotal, _this.subtotal) || other.subtotal == _this.subtotal)&&(identical(other.adminFee, _this.adminFee) || other.adminFee == _this.adminFee)&&(identical(other.totalAmount, _this.totalAmount) || other.totalAmount == _this.totalAmount)&&(identical(other.notes, _this.notes) || other.notes == _this.notes)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.statusLabel, _this.statusLabel) || other.statusLabel == _this.statusLabel)&&(identical(other.rejectionReason, _this.rejectionReason) || other.rejectionReason == _this.rejectionReason)&&(identical(other.kos, _this.kos) || other.kos == _this.kos)&&(identical(other.room, _this.room) || other.room == _this.room)&&(identical(other.customer, _this.customer) || other.customer == _this.customer)&&(identical(other.invoice, _this.invoice) || other.invoice == _this.invoice)&&(identical(other.contract, _this.contract) || other.contract == _this.contract)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BookingModel;
  return Object.hashAll([runtimeType,_this.id,_this.bookingCode,_this.tenantName,_this.tenantPhone,_this.tenantEmail,_this.startDate,_this.endDate,_this.durationMonths,_this.kosPrice,_this.subtotal,_this.adminFee,_this.totalAmount,_this.notes,_this.status,_this.statusLabel,_this.rejectionReason,_this.kos,_this.room,_this.customer,_this.invoice,_this.contract,_this.createdAt]);
}

@override
String toString() {
  final _this = this as BookingModel;
  return 'BookingModel(id: ${_this.id}, bookingCode: ${_this.bookingCode}, tenantName: ${_this.tenantName}, tenantPhone: ${_this.tenantPhone}, tenantEmail: ${_this.tenantEmail}, startDate: ${_this.startDate}, endDate: ${_this.endDate}, durationMonths: ${_this.durationMonths}, kosPrice: ${_this.kosPrice}, subtotal: ${_this.subtotal}, adminFee: ${_this.adminFee}, totalAmount: ${_this.totalAmount}, notes: ${_this.notes}, status: ${_this.status}, statusLabel: ${_this.statusLabel}, rejectionReason: ${_this.rejectionReason}, kos: ${_this.kos}, room: ${_this.room}, customer: ${_this.customer}, invoice: ${_this.invoice}, contract: ${_this.contract}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $BookingModelCopyWith<$Res>  {
  factory $BookingModelCopyWith(BookingModel value, $Res Function(BookingModel) _then) = _$BookingModelCopyWithImpl;
@useResult
$Res call({
 int id, String bookingCode, String tenantName, String tenantPhone, String tenantEmail, String startDate, String endDate,@JsonKey(fromJson: intFromJson) int durationMonths,@JsonKey(fromJson: doubleFromJson) double kosPrice,@JsonKey(fromJson: doubleFromJson) double subtotal,@JsonKey(fromJson: doubleFromJson) double adminFee,@JsonKey(fromJson: doubleFromJson) double totalAmount, String? notes, String status, String? statusLabel, String? rejectionReason, KosSummaryModel? kos, RoomModel? room, UserModel? customer, InvoiceModel? invoice, RentalContractModel? contract, DateTime? createdAt
});


$KosSummaryModelCopyWith<$Res>? get kos;$RoomModelCopyWith<$Res>? get room;$UserModelCopyWith<$Res>? get customer;$InvoiceModelCopyWith<$Res>? get invoice;$RentalContractModelCopyWith<$Res>? get contract;

}
/// @nodoc
class _$BookingModelCopyWithImpl<$Res>
    implements $BookingModelCopyWith<$Res> {
  _$BookingModelCopyWithImpl(this._self, this._then);

  final BookingModel _self;
  final $Res Function(BookingModel) _then;

/// Create a copy of BookingModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? bookingCode = null,Object? tenantName = null,Object? tenantPhone = null,Object? tenantEmail = null,Object? startDate = null,Object? endDate = null,Object? durationMonths = null,Object? kosPrice = null,Object? subtotal = null,Object? adminFee = null,Object? totalAmount = null,Object? notes = freezed,Object? status = null,Object? statusLabel = freezed,Object? rejectionReason = freezed,Object? kos = freezed,Object? room = freezed,Object? customer = freezed,Object? invoice = freezed,Object? contract = freezed,Object? createdAt = freezed,}) {
  return _then(BookingModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,bookingCode: null == bookingCode ? _self.bookingCode : bookingCode // ignore: cast_nullable_to_non_nullable
as String,tenantName: null == tenantName ? _self.tenantName : tenantName // ignore: cast_nullable_to_non_nullable
as String,tenantPhone: null == tenantPhone ? _self.tenantPhone : tenantPhone // ignore: cast_nullable_to_non_nullable
as String,tenantEmail: null == tenantEmail ? _self.tenantEmail : tenantEmail // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String,durationMonths: null == durationMonths ? _self.durationMonths : durationMonths // ignore: cast_nullable_to_non_nullable
as int,kosPrice: null == kosPrice ? _self.kosPrice : kosPrice // ignore: cast_nullable_to_non_nullable
as double,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double,adminFee: null == adminFee ? _self.adminFee : adminFee // ignore: cast_nullable_to_non_nullable
as double,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,statusLabel: freezed == statusLabel ? _self.statusLabel : statusLabel // ignore: cast_nullable_to_non_nullable
as String?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,kos: freezed == kos ? _self.kos : kos // ignore: cast_nullable_to_non_nullable
as KosSummaryModel?,room: freezed == room ? _self.room : room // ignore: cast_nullable_to_non_nullable
as RoomModel?,customer: freezed == customer ? _self.customer : customer // ignore: cast_nullable_to_non_nullable
as UserModel?,invoice: freezed == invoice ? _self.invoice : invoice // ignore: cast_nullable_to_non_nullable
as InvoiceModel?,contract: freezed == contract ? _self.contract : contract // ignore: cast_nullable_to_non_nullable
as RentalContractModel?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of BookingModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KosSummaryModelCopyWith<$Res>? get kos {
    if (_self.kos == null) {
    return null;
  }

  return $KosSummaryModelCopyWith<$Res>(_self.kos!, (value) {
    return _then(_self.copyWith(kos: value));
  });
}/// Create a copy of BookingModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoomModelCopyWith<$Res>? get room {
    if (_self.room == null) {
    return null;
  }

  return $RoomModelCopyWith<$Res>(_self.room!, (value) {
    return _then(_self.copyWith(room: value));
  });
}/// Create a copy of BookingModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserModelCopyWith<$Res>? get customer {
    if (_self.customer == null) {
    return null;
  }

  return $UserModelCopyWith<$Res>(_self.customer!, (value) {
    return _then(_self.copyWith(customer: value));
  });
}/// Create a copy of BookingModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InvoiceModelCopyWith<$Res>? get invoice {
    if (_self.invoice == null) {
    return null;
  }

  return $InvoiceModelCopyWith<$Res>(_self.invoice!, (value) {
    return _then(_self.copyWith(invoice: value));
  });
}/// Create a copy of BookingModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RentalContractModelCopyWith<$Res>? get contract {
    if (_self.contract == null) {
    return null;
  }

  return $RentalContractModelCopyWith<$Res>(_self.contract!, (value) {
    return _then(_self.copyWith(contract: value));
  });
}
}


/// Adds pattern-matching-related methods to [BookingModel].
extension BookingModelPatterns on BookingModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingModel value)  $default,){
final _that = this;
switch (_that) {
case _BookingModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingModel value)?  $default,){
final _that = this;
switch (_that) {
case _BookingModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String bookingCode,  String tenantName,  String tenantPhone,  String tenantEmail,  String startDate,  String endDate, @JsonKey(fromJson: intFromJson)  int durationMonths, @JsonKey(fromJson: doubleFromJson)  double kosPrice, @JsonKey(fromJson: doubleFromJson)  double subtotal, @JsonKey(fromJson: doubleFromJson)  double adminFee, @JsonKey(fromJson: doubleFromJson)  double totalAmount,  String? notes,  String status,  String? statusLabel,  String? rejectionReason,  KosSummaryModel? kos,  RoomModel? room,  UserModel? customer,  InvoiceModel? invoice,  RentalContractModel? contract,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingModel() when $default != null:
return $default(_that.id,_that.bookingCode,_that.tenantName,_that.tenantPhone,_that.tenantEmail,_that.startDate,_that.endDate,_that.durationMonths,_that.kosPrice,_that.subtotal,_that.adminFee,_that.totalAmount,_that.notes,_that.status,_that.statusLabel,_that.rejectionReason,_that.kos,_that.room,_that.customer,_that.invoice,_that.contract,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String bookingCode,  String tenantName,  String tenantPhone,  String tenantEmail,  String startDate,  String endDate, @JsonKey(fromJson: intFromJson)  int durationMonths, @JsonKey(fromJson: doubleFromJson)  double kosPrice, @JsonKey(fromJson: doubleFromJson)  double subtotal, @JsonKey(fromJson: doubleFromJson)  double adminFee, @JsonKey(fromJson: doubleFromJson)  double totalAmount,  String? notes,  String status,  String? statusLabel,  String? rejectionReason,  KosSummaryModel? kos,  RoomModel? room,  UserModel? customer,  InvoiceModel? invoice,  RentalContractModel? contract,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _BookingModel():
return $default(_that.id,_that.bookingCode,_that.tenantName,_that.tenantPhone,_that.tenantEmail,_that.startDate,_that.endDate,_that.durationMonths,_that.kosPrice,_that.subtotal,_that.adminFee,_that.totalAmount,_that.notes,_that.status,_that.statusLabel,_that.rejectionReason,_that.kos,_that.room,_that.customer,_that.invoice,_that.contract,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String bookingCode,  String tenantName,  String tenantPhone,  String tenantEmail,  String startDate,  String endDate, @JsonKey(fromJson: intFromJson)  int durationMonths, @JsonKey(fromJson: doubleFromJson)  double kosPrice, @JsonKey(fromJson: doubleFromJson)  double subtotal, @JsonKey(fromJson: doubleFromJson)  double adminFee, @JsonKey(fromJson: doubleFromJson)  double totalAmount,  String? notes,  String status,  String? statusLabel,  String? rejectionReason,  KosSummaryModel? kos,  RoomModel? room,  UserModel? customer,  InvoiceModel? invoice,  RentalContractModel? contract,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _BookingModel() when $default != null:
return $default(_that.id,_that.bookingCode,_that.tenantName,_that.tenantPhone,_that.tenantEmail,_that.startDate,_that.endDate,_that.durationMonths,_that.kosPrice,_that.subtotal,_that.adminFee,_that.totalAmount,_that.notes,_that.status,_that.statusLabel,_that.rejectionReason,_that.kos,_that.room,_that.customer,_that.invoice,_that.contract,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookingModel implements BookingModel {
  const _BookingModel({required this.id, required this.bookingCode, required this.tenantName, required this.tenantPhone, required this.tenantEmail, required this.startDate, required this.endDate, @JsonKey(fromJson: intFromJson) this.durationMonths = 1, @JsonKey(fromJson: doubleFromJson) required this.kosPrice, @JsonKey(fromJson: doubleFromJson) required this.subtotal, @JsonKey(fromJson: doubleFromJson) this.adminFee = 25000.0, @JsonKey(fromJson: doubleFromJson) required this.totalAmount, this.notes, required this.status, this.statusLabel, this.rejectionReason, this.kos, this.room, this.customer, this.invoice, this.contract, this.createdAt});
  factory _BookingModel.fromJson(Map<String, dynamic> json) => _$BookingModelFromJson(json);

@override final  int id;
@override final  String bookingCode;
@override final  String tenantName;
@override final  String tenantPhone;
@override final  String tenantEmail;
@override final  String startDate;
@override final  String endDate;
@override@JsonKey(fromJson: intFromJson) final  int durationMonths;
@override@JsonKey(fromJson: doubleFromJson) final  double kosPrice;
@override@JsonKey(fromJson: doubleFromJson) final  double subtotal;
@override@JsonKey(fromJson: doubleFromJson) final  double adminFee;
@override@JsonKey(fromJson: doubleFromJson) final  double totalAmount;
@override final  String? notes;
@override final  String status;
@override final  String? statusLabel;
@override final  String? rejectionReason;
@override final  KosSummaryModel? kos;
@override final  RoomModel? room;
@override final  UserModel? customer;
@override final  InvoiceModel? invoice;
@override final  RentalContractModel? contract;
@override final  DateTime? createdAt;

/// Create a copy of BookingModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingModelCopyWith<_BookingModel> get copyWith => __$BookingModelCopyWithImpl<_BookingModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookingModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingModel&&(identical(other.id, id) || other.id == id)&&(identical(other.bookingCode, bookingCode) || other.bookingCode == bookingCode)&&(identical(other.tenantName, tenantName) || other.tenantName == tenantName)&&(identical(other.tenantPhone, tenantPhone) || other.tenantPhone == tenantPhone)&&(identical(other.tenantEmail, tenantEmail) || other.tenantEmail == tenantEmail)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.durationMonths, durationMonths) || other.durationMonths == durationMonths)&&(identical(other.kosPrice, kosPrice) || other.kosPrice == kosPrice)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.adminFee, adminFee) || other.adminFee == adminFee)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.status, status) || other.status == status)&&(identical(other.statusLabel, statusLabel) || other.statusLabel == statusLabel)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.kos, kos) || other.kos == kos)&&(identical(other.room, room) || other.room == room)&&(identical(other.customer, customer) || other.customer == customer)&&(identical(other.invoice, invoice) || other.invoice == invoice)&&(identical(other.contract, contract) || other.contract == contract)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,id,bookingCode,tenantName,tenantPhone,tenantEmail,startDate,endDate,durationMonths,kosPrice,subtotal,adminFee,totalAmount,notes,status,statusLabel,rejectionReason,kos,room,customer,invoice,contract,createdAt]);
}

@override
String toString() {
    return 'BookingModel(id: $id, bookingCode: $bookingCode, tenantName: $tenantName, tenantPhone: $tenantPhone, tenantEmail: $tenantEmail, startDate: $startDate, endDate: $endDate, durationMonths: $durationMonths, kosPrice: $kosPrice, subtotal: $subtotal, adminFee: $adminFee, totalAmount: $totalAmount, notes: $notes, status: $status, statusLabel: $statusLabel, rejectionReason: $rejectionReason, kos: $kos, room: $room, customer: $customer, invoice: $invoice, contract: $contract, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$BookingModelCopyWith<$Res> implements $BookingModelCopyWith<$Res> {
  factory _$BookingModelCopyWith(_BookingModel value, $Res Function(_BookingModel) _then) = __$BookingModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String bookingCode, String tenantName, String tenantPhone, String tenantEmail, String startDate, String endDate,@JsonKey(fromJson: intFromJson) int durationMonths,@JsonKey(fromJson: doubleFromJson) double kosPrice,@JsonKey(fromJson: doubleFromJson) double subtotal,@JsonKey(fromJson: doubleFromJson) double adminFee,@JsonKey(fromJson: doubleFromJson) double totalAmount, String? notes, String status, String? statusLabel, String? rejectionReason, KosSummaryModel? kos, RoomModel? room, UserModel? customer, InvoiceModel? invoice, RentalContractModel? contract, DateTime? createdAt
});


@override $KosSummaryModelCopyWith<$Res>? get kos;@override $RoomModelCopyWith<$Res>? get room;@override $UserModelCopyWith<$Res>? get customer;@override $InvoiceModelCopyWith<$Res>? get invoice;@override $RentalContractModelCopyWith<$Res>? get contract;

}
/// @nodoc
class __$BookingModelCopyWithImpl<$Res>
    implements _$BookingModelCopyWith<$Res> {
  __$BookingModelCopyWithImpl(this._self, this._then);

  final _BookingModel _self;
  final $Res Function(_BookingModel) _then;

/// Create a copy of BookingModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? bookingCode = null,Object? tenantName = null,Object? tenantPhone = null,Object? tenantEmail = null,Object? startDate = null,Object? endDate = null,Object? durationMonths = null,Object? kosPrice = null,Object? subtotal = null,Object? adminFee = null,Object? totalAmount = null,Object? notes = freezed,Object? status = null,Object? statusLabel = freezed,Object? rejectionReason = freezed,Object? kos = freezed,Object? room = freezed,Object? customer = freezed,Object? invoice = freezed,Object? contract = freezed,Object? createdAt = freezed,}) {
  return _then(_BookingModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,bookingCode: null == bookingCode ? _self.bookingCode : bookingCode // ignore: cast_nullable_to_non_nullable
as String,tenantName: null == tenantName ? _self.tenantName : tenantName // ignore: cast_nullable_to_non_nullable
as String,tenantPhone: null == tenantPhone ? _self.tenantPhone : tenantPhone // ignore: cast_nullable_to_non_nullable
as String,tenantEmail: null == tenantEmail ? _self.tenantEmail : tenantEmail // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String,durationMonths: null == durationMonths ? _self.durationMonths : durationMonths // ignore: cast_nullable_to_non_nullable
as int,kosPrice: null == kosPrice ? _self.kosPrice : kosPrice // ignore: cast_nullable_to_non_nullable
as double,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double,adminFee: null == adminFee ? _self.adminFee : adminFee // ignore: cast_nullable_to_non_nullable
as double,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,statusLabel: freezed == statusLabel ? _self.statusLabel : statusLabel // ignore: cast_nullable_to_non_nullable
as String?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,kos: freezed == kos ? _self.kos : kos // ignore: cast_nullable_to_non_nullable
as KosSummaryModel?,room: freezed == room ? _self.room : room // ignore: cast_nullable_to_non_nullable
as RoomModel?,customer: freezed == customer ? _self.customer : customer // ignore: cast_nullable_to_non_nullable
as UserModel?,invoice: freezed == invoice ? _self.invoice : invoice // ignore: cast_nullable_to_non_nullable
as InvoiceModel?,contract: freezed == contract ? _self.contract : contract // ignore: cast_nullable_to_non_nullable
as RentalContractModel?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of BookingModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KosSummaryModelCopyWith<$Res>? get kos {
    if (_self.kos == null) {
    return null;
  }

  return $KosSummaryModelCopyWith<$Res>(_self.kos!, (value) {
    return _then(_self.copyWith(kos: value));
  });
}/// Create a copy of BookingModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoomModelCopyWith<$Res>? get room {
    if (_self.room == null) {
    return null;
  }

  return $RoomModelCopyWith<$Res>(_self.room!, (value) {
    return _then(_self.copyWith(room: value));
  });
}/// Create a copy of BookingModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserModelCopyWith<$Res>? get customer {
    if (_self.customer == null) {
    return null;
  }

  return $UserModelCopyWith<$Res>(_self.customer!, (value) {
    return _then(_self.copyWith(customer: value));
  });
}/// Create a copy of BookingModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InvoiceModelCopyWith<$Res>? get invoice {
    if (_self.invoice == null) {
    return null;
  }

  return $InvoiceModelCopyWith<$Res>(_self.invoice!, (value) {
    return _then(_self.copyWith(invoice: value));
  });
}/// Create a copy of BookingModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RentalContractModelCopyWith<$Res>? get contract {
    if (_self.contract == null) {
    return null;
  }

  return $RentalContractModelCopyWith<$Res>(_self.contract!, (value) {
    return _then(_self.copyWith(contract: value));
  });
}
}


/// @nodoc
mixin _$SurveyModel {

 int get id; String get surveyDate; String get surveyTime; String? get notes; String get status; String? get statusLabel; String? get rejectionReason; KosSummaryModel? get kos; UserModel? get customer; DateTime? get createdAt;
/// Create a copy of SurveyModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurveyModelCopyWith<SurveyModel> get copyWith => _$SurveyModelCopyWithImpl<SurveyModel>(this as SurveyModel, _$identity);

  /// Serializes this SurveyModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SurveyModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SurveyModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.surveyDate, _this.surveyDate) || other.surveyDate == _this.surveyDate)&&(identical(other.surveyTime, _this.surveyTime) || other.surveyTime == _this.surveyTime)&&(identical(other.notes, _this.notes) || other.notes == _this.notes)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.statusLabel, _this.statusLabel) || other.statusLabel == _this.statusLabel)&&(identical(other.rejectionReason, _this.rejectionReason) || other.rejectionReason == _this.rejectionReason)&&(identical(other.kos, _this.kos) || other.kos == _this.kos)&&(identical(other.customer, _this.customer) || other.customer == _this.customer)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SurveyModel;
  return Object.hash(runtimeType,_this.id,_this.surveyDate,_this.surveyTime,_this.notes,_this.status,_this.statusLabel,_this.rejectionReason,_this.kos,_this.customer,_this.createdAt);
}

@override
String toString() {
  final _this = this as SurveyModel;
  return 'SurveyModel(id: ${_this.id}, surveyDate: ${_this.surveyDate}, surveyTime: ${_this.surveyTime}, notes: ${_this.notes}, status: ${_this.status}, statusLabel: ${_this.statusLabel}, rejectionReason: ${_this.rejectionReason}, kos: ${_this.kos}, customer: ${_this.customer}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $SurveyModelCopyWith<$Res>  {
  factory $SurveyModelCopyWith(SurveyModel value, $Res Function(SurveyModel) _then) = _$SurveyModelCopyWithImpl;
@useResult
$Res call({
 int id, String surveyDate, String surveyTime, String? notes, String status, String? statusLabel, String? rejectionReason, KosSummaryModel? kos, UserModel? customer, DateTime? createdAt
});


$KosSummaryModelCopyWith<$Res>? get kos;$UserModelCopyWith<$Res>? get customer;

}
/// @nodoc
class _$SurveyModelCopyWithImpl<$Res>
    implements $SurveyModelCopyWith<$Res> {
  _$SurveyModelCopyWithImpl(this._self, this._then);

  final SurveyModel _self;
  final $Res Function(SurveyModel) _then;

/// Create a copy of SurveyModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? surveyDate = null,Object? surveyTime = null,Object? notes = freezed,Object? status = null,Object? statusLabel = freezed,Object? rejectionReason = freezed,Object? kos = freezed,Object? customer = freezed,Object? createdAt = freezed,}) {
  return _then(SurveyModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,surveyDate: null == surveyDate ? _self.surveyDate : surveyDate // ignore: cast_nullable_to_non_nullable
as String,surveyTime: null == surveyTime ? _self.surveyTime : surveyTime // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,statusLabel: freezed == statusLabel ? _self.statusLabel : statusLabel // ignore: cast_nullable_to_non_nullable
as String?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,kos: freezed == kos ? _self.kos : kos // ignore: cast_nullable_to_non_nullable
as KosSummaryModel?,customer: freezed == customer ? _self.customer : customer // ignore: cast_nullable_to_non_nullable
as UserModel?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of SurveyModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KosSummaryModelCopyWith<$Res>? get kos {
    if (_self.kos == null) {
    return null;
  }

  return $KosSummaryModelCopyWith<$Res>(_self.kos!, (value) {
    return _then(_self.copyWith(kos: value));
  });
}/// Create a copy of SurveyModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserModelCopyWith<$Res>? get customer {
    if (_self.customer == null) {
    return null;
  }

  return $UserModelCopyWith<$Res>(_self.customer!, (value) {
    return _then(_self.copyWith(customer: value));
  });
}
}


/// Adds pattern-matching-related methods to [SurveyModel].
extension SurveyModelPatterns on SurveyModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SurveyModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SurveyModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SurveyModel value)  $default,){
final _that = this;
switch (_that) {
case _SurveyModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SurveyModel value)?  $default,){
final _that = this;
switch (_that) {
case _SurveyModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String surveyDate,  String surveyTime,  String? notes,  String status,  String? statusLabel,  String? rejectionReason,  KosSummaryModel? kos,  UserModel? customer,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SurveyModel() when $default != null:
return $default(_that.id,_that.surveyDate,_that.surveyTime,_that.notes,_that.status,_that.statusLabel,_that.rejectionReason,_that.kos,_that.customer,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String surveyDate,  String surveyTime,  String? notes,  String status,  String? statusLabel,  String? rejectionReason,  KosSummaryModel? kos,  UserModel? customer,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _SurveyModel():
return $default(_that.id,_that.surveyDate,_that.surveyTime,_that.notes,_that.status,_that.statusLabel,_that.rejectionReason,_that.kos,_that.customer,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String surveyDate,  String surveyTime,  String? notes,  String status,  String? statusLabel,  String? rejectionReason,  KosSummaryModel? kos,  UserModel? customer,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _SurveyModel() when $default != null:
return $default(_that.id,_that.surveyDate,_that.surveyTime,_that.notes,_that.status,_that.statusLabel,_that.rejectionReason,_that.kos,_that.customer,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SurveyModel implements SurveyModel {
  const _SurveyModel({required this.id, required this.surveyDate, required this.surveyTime, this.notes, required this.status, this.statusLabel, this.rejectionReason, this.kos, this.customer, this.createdAt});
  factory _SurveyModel.fromJson(Map<String, dynamic> json) => _$SurveyModelFromJson(json);

@override final  int id;
@override final  String surveyDate;
@override final  String surveyTime;
@override final  String? notes;
@override final  String status;
@override final  String? statusLabel;
@override final  String? rejectionReason;
@override final  KosSummaryModel? kos;
@override final  UserModel? customer;
@override final  DateTime? createdAt;

/// Create a copy of SurveyModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SurveyModelCopyWith<_SurveyModel> get copyWith => __$SurveyModelCopyWithImpl<_SurveyModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SurveyModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SurveyModel&&(identical(other.id, id) || other.id == id)&&(identical(other.surveyDate, surveyDate) || other.surveyDate == surveyDate)&&(identical(other.surveyTime, surveyTime) || other.surveyTime == surveyTime)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.status, status) || other.status == status)&&(identical(other.statusLabel, statusLabel) || other.statusLabel == statusLabel)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.kos, kos) || other.kos == kos)&&(identical(other.customer, customer) || other.customer == customer)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,surveyDate,surveyTime,notes,status,statusLabel,rejectionReason,kos,customer,createdAt);
}

@override
String toString() {
    return 'SurveyModel(id: $id, surveyDate: $surveyDate, surveyTime: $surveyTime, notes: $notes, status: $status, statusLabel: $statusLabel, rejectionReason: $rejectionReason, kos: $kos, customer: $customer, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$SurveyModelCopyWith<$Res> implements $SurveyModelCopyWith<$Res> {
  factory _$SurveyModelCopyWith(_SurveyModel value, $Res Function(_SurveyModel) _then) = __$SurveyModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String surveyDate, String surveyTime, String? notes, String status, String? statusLabel, String? rejectionReason, KosSummaryModel? kos, UserModel? customer, DateTime? createdAt
});


@override $KosSummaryModelCopyWith<$Res>? get kos;@override $UserModelCopyWith<$Res>? get customer;

}
/// @nodoc
class __$SurveyModelCopyWithImpl<$Res>
    implements _$SurveyModelCopyWith<$Res> {
  __$SurveyModelCopyWithImpl(this._self, this._then);

  final _SurveyModel _self;
  final $Res Function(_SurveyModel) _then;

/// Create a copy of SurveyModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? surveyDate = null,Object? surveyTime = null,Object? notes = freezed,Object? status = null,Object? statusLabel = freezed,Object? rejectionReason = freezed,Object? kos = freezed,Object? customer = freezed,Object? createdAt = freezed,}) {
  return _then(_SurveyModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,surveyDate: null == surveyDate ? _self.surveyDate : surveyDate // ignore: cast_nullable_to_non_nullable
as String,surveyTime: null == surveyTime ? _self.surveyTime : surveyTime // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,statusLabel: freezed == statusLabel ? _self.statusLabel : statusLabel // ignore: cast_nullable_to_non_nullable
as String?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,kos: freezed == kos ? _self.kos : kos // ignore: cast_nullable_to_non_nullable
as KosSummaryModel?,customer: freezed == customer ? _self.customer : customer // ignore: cast_nullable_to_non_nullable
as UserModel?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of SurveyModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KosSummaryModelCopyWith<$Res>? get kos {
    if (_self.kos == null) {
    return null;
  }

  return $KosSummaryModelCopyWith<$Res>(_self.kos!, (value) {
    return _then(_self.copyWith(kos: value));
  });
}/// Create a copy of SurveyModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserModelCopyWith<$Res>? get customer {
    if (_self.customer == null) {
    return null;
  }

  return $UserModelCopyWith<$Res>(_self.customer!, (value) {
    return _then(_self.copyWith(customer: value));
  });
}
}


/// @nodoc
mixin _$MaintenanceReportModel {

 int get id; int get bookingId; String? get bookingCode; String get title; String get description; String? get photoUrl; String get status; String? get statusLabel; String? get ownerNotes; KosSummaryModel? get kos; RoomModel? get room; UserModel? get customer; DateTime? get createdAt;
/// Create a copy of MaintenanceReportModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MaintenanceReportModelCopyWith<MaintenanceReportModel> get copyWith => _$MaintenanceReportModelCopyWithImpl<MaintenanceReportModel>(this as MaintenanceReportModel, _$identity);

  /// Serializes this MaintenanceReportModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MaintenanceReportModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MaintenanceReportModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.bookingId, _this.bookingId) || other.bookingId == _this.bookingId)&&(identical(other.bookingCode, _this.bookingCode) || other.bookingCode == _this.bookingCode)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.photoUrl, _this.photoUrl) || other.photoUrl == _this.photoUrl)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.statusLabel, _this.statusLabel) || other.statusLabel == _this.statusLabel)&&(identical(other.ownerNotes, _this.ownerNotes) || other.ownerNotes == _this.ownerNotes)&&(identical(other.kos, _this.kos) || other.kos == _this.kos)&&(identical(other.room, _this.room) || other.room == _this.room)&&(identical(other.customer, _this.customer) || other.customer == _this.customer)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MaintenanceReportModel;
  return Object.hash(runtimeType,_this.id,_this.bookingId,_this.bookingCode,_this.title,_this.description,_this.photoUrl,_this.status,_this.statusLabel,_this.ownerNotes,_this.kos,_this.room,_this.customer,_this.createdAt);
}

@override
String toString() {
  final _this = this as MaintenanceReportModel;
  return 'MaintenanceReportModel(id: ${_this.id}, bookingId: ${_this.bookingId}, bookingCode: ${_this.bookingCode}, title: ${_this.title}, description: ${_this.description}, photoUrl: ${_this.photoUrl}, status: ${_this.status}, statusLabel: ${_this.statusLabel}, ownerNotes: ${_this.ownerNotes}, kos: ${_this.kos}, room: ${_this.room}, customer: ${_this.customer}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $MaintenanceReportModelCopyWith<$Res>  {
  factory $MaintenanceReportModelCopyWith(MaintenanceReportModel value, $Res Function(MaintenanceReportModel) _then) = _$MaintenanceReportModelCopyWithImpl;
@useResult
$Res call({
 int id, int bookingId, String? bookingCode, String title, String description, String? photoUrl, String status, String? statusLabel, String? ownerNotes, KosSummaryModel? kos, RoomModel? room, UserModel? customer, DateTime? createdAt
});


$KosSummaryModelCopyWith<$Res>? get kos;$RoomModelCopyWith<$Res>? get room;$UserModelCopyWith<$Res>? get customer;

}
/// @nodoc
class _$MaintenanceReportModelCopyWithImpl<$Res>
    implements $MaintenanceReportModelCopyWith<$Res> {
  _$MaintenanceReportModelCopyWithImpl(this._self, this._then);

  final MaintenanceReportModel _self;
  final $Res Function(MaintenanceReportModel) _then;

/// Create a copy of MaintenanceReportModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? bookingId = null,Object? bookingCode = freezed,Object? title = null,Object? description = null,Object? photoUrl = freezed,Object? status = null,Object? statusLabel = freezed,Object? ownerNotes = freezed,Object? kos = freezed,Object? room = freezed,Object? customer = freezed,Object? createdAt = freezed,}) {
  return _then(MaintenanceReportModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,bookingId: null == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as int,bookingCode: freezed == bookingCode ? _self.bookingCode : bookingCode // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,statusLabel: freezed == statusLabel ? _self.statusLabel : statusLabel // ignore: cast_nullable_to_non_nullable
as String?,ownerNotes: freezed == ownerNotes ? _self.ownerNotes : ownerNotes // ignore: cast_nullable_to_non_nullable
as String?,kos: freezed == kos ? _self.kos : kos // ignore: cast_nullable_to_non_nullable
as KosSummaryModel?,room: freezed == room ? _self.room : room // ignore: cast_nullable_to_non_nullable
as RoomModel?,customer: freezed == customer ? _self.customer : customer // ignore: cast_nullable_to_non_nullable
as UserModel?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of MaintenanceReportModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KosSummaryModelCopyWith<$Res>? get kos {
    if (_self.kos == null) {
    return null;
  }

  return $KosSummaryModelCopyWith<$Res>(_self.kos!, (value) {
    return _then(_self.copyWith(kos: value));
  });
}/// Create a copy of MaintenanceReportModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoomModelCopyWith<$Res>? get room {
    if (_self.room == null) {
    return null;
  }

  return $RoomModelCopyWith<$Res>(_self.room!, (value) {
    return _then(_self.copyWith(room: value));
  });
}/// Create a copy of MaintenanceReportModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserModelCopyWith<$Res>? get customer {
    if (_self.customer == null) {
    return null;
  }

  return $UserModelCopyWith<$Res>(_self.customer!, (value) {
    return _then(_self.copyWith(customer: value));
  });
}
}


/// Adds pattern-matching-related methods to [MaintenanceReportModel].
extension MaintenanceReportModelPatterns on MaintenanceReportModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MaintenanceReportModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MaintenanceReportModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MaintenanceReportModel value)  $default,){
final _that = this;
switch (_that) {
case _MaintenanceReportModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MaintenanceReportModel value)?  $default,){
final _that = this;
switch (_that) {
case _MaintenanceReportModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int bookingId,  String? bookingCode,  String title,  String description,  String? photoUrl,  String status,  String? statusLabel,  String? ownerNotes,  KosSummaryModel? kos,  RoomModel? room,  UserModel? customer,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MaintenanceReportModel() when $default != null:
return $default(_that.id,_that.bookingId,_that.bookingCode,_that.title,_that.description,_that.photoUrl,_that.status,_that.statusLabel,_that.ownerNotes,_that.kos,_that.room,_that.customer,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int bookingId,  String? bookingCode,  String title,  String description,  String? photoUrl,  String status,  String? statusLabel,  String? ownerNotes,  KosSummaryModel? kos,  RoomModel? room,  UserModel? customer,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _MaintenanceReportModel():
return $default(_that.id,_that.bookingId,_that.bookingCode,_that.title,_that.description,_that.photoUrl,_that.status,_that.statusLabel,_that.ownerNotes,_that.kos,_that.room,_that.customer,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int bookingId,  String? bookingCode,  String title,  String description,  String? photoUrl,  String status,  String? statusLabel,  String? ownerNotes,  KosSummaryModel? kos,  RoomModel? room,  UserModel? customer,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _MaintenanceReportModel() when $default != null:
return $default(_that.id,_that.bookingId,_that.bookingCode,_that.title,_that.description,_that.photoUrl,_that.status,_that.statusLabel,_that.ownerNotes,_that.kos,_that.room,_that.customer,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MaintenanceReportModel implements MaintenanceReportModel {
  const _MaintenanceReportModel({required this.id, required this.bookingId, this.bookingCode, required this.title, required this.description, this.photoUrl, required this.status, this.statusLabel, this.ownerNotes, this.kos, this.room, this.customer, this.createdAt});
  factory _MaintenanceReportModel.fromJson(Map<String, dynamic> json) => _$MaintenanceReportModelFromJson(json);

@override final  int id;
@override final  int bookingId;
@override final  String? bookingCode;
@override final  String title;
@override final  String description;
@override final  String? photoUrl;
@override final  String status;
@override final  String? statusLabel;
@override final  String? ownerNotes;
@override final  KosSummaryModel? kos;
@override final  RoomModel? room;
@override final  UserModel? customer;
@override final  DateTime? createdAt;

/// Create a copy of MaintenanceReportModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MaintenanceReportModelCopyWith<_MaintenanceReportModel> get copyWith => __$MaintenanceReportModelCopyWithImpl<_MaintenanceReportModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MaintenanceReportModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MaintenanceReportModel&&(identical(other.id, id) || other.id == id)&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.bookingCode, bookingCode) || other.bookingCode == bookingCode)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.statusLabel, statusLabel) || other.statusLabel == statusLabel)&&(identical(other.ownerNotes, ownerNotes) || other.ownerNotes == ownerNotes)&&(identical(other.kos, kos) || other.kos == kos)&&(identical(other.room, room) || other.room == room)&&(identical(other.customer, customer) || other.customer == customer)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,bookingId,bookingCode,title,description,photoUrl,status,statusLabel,ownerNotes,kos,room,customer,createdAt);
}

@override
String toString() {
    return 'MaintenanceReportModel(id: $id, bookingId: $bookingId, bookingCode: $bookingCode, title: $title, description: $description, photoUrl: $photoUrl, status: $status, statusLabel: $statusLabel, ownerNotes: $ownerNotes, kos: $kos, room: $room, customer: $customer, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$MaintenanceReportModelCopyWith<$Res> implements $MaintenanceReportModelCopyWith<$Res> {
  factory _$MaintenanceReportModelCopyWith(_MaintenanceReportModel value, $Res Function(_MaintenanceReportModel) _then) = __$MaintenanceReportModelCopyWithImpl;
@override @useResult
$Res call({
 int id, int bookingId, String? bookingCode, String title, String description, String? photoUrl, String status, String? statusLabel, String? ownerNotes, KosSummaryModel? kos, RoomModel? room, UserModel? customer, DateTime? createdAt
});


@override $KosSummaryModelCopyWith<$Res>? get kos;@override $RoomModelCopyWith<$Res>? get room;@override $UserModelCopyWith<$Res>? get customer;

}
/// @nodoc
class __$MaintenanceReportModelCopyWithImpl<$Res>
    implements _$MaintenanceReportModelCopyWith<$Res> {
  __$MaintenanceReportModelCopyWithImpl(this._self, this._then);

  final _MaintenanceReportModel _self;
  final $Res Function(_MaintenanceReportModel) _then;

/// Create a copy of MaintenanceReportModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? bookingId = null,Object? bookingCode = freezed,Object? title = null,Object? description = null,Object? photoUrl = freezed,Object? status = null,Object? statusLabel = freezed,Object? ownerNotes = freezed,Object? kos = freezed,Object? room = freezed,Object? customer = freezed,Object? createdAt = freezed,}) {
  return _then(_MaintenanceReportModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,bookingId: null == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as int,bookingCode: freezed == bookingCode ? _self.bookingCode : bookingCode // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,statusLabel: freezed == statusLabel ? _self.statusLabel : statusLabel // ignore: cast_nullable_to_non_nullable
as String?,ownerNotes: freezed == ownerNotes ? _self.ownerNotes : ownerNotes // ignore: cast_nullable_to_non_nullable
as String?,kos: freezed == kos ? _self.kos : kos // ignore: cast_nullable_to_non_nullable
as KosSummaryModel?,room: freezed == room ? _self.room : room // ignore: cast_nullable_to_non_nullable
as RoomModel?,customer: freezed == customer ? _self.customer : customer // ignore: cast_nullable_to_non_nullable
as UserModel?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of MaintenanceReportModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KosSummaryModelCopyWith<$Res>? get kos {
    if (_self.kos == null) {
    return null;
  }

  return $KosSummaryModelCopyWith<$Res>(_self.kos!, (value) {
    return _then(_self.copyWith(kos: value));
  });
}/// Create a copy of MaintenanceReportModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoomModelCopyWith<$Res>? get room {
    if (_self.room == null) {
    return null;
  }

  return $RoomModelCopyWith<$Res>(_self.room!, (value) {
    return _then(_self.copyWith(room: value));
  });
}/// Create a copy of MaintenanceReportModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserModelCopyWith<$Res>? get customer {
    if (_self.customer == null) {
    return null;
  }

  return $UserModelCopyWith<$Res>(_self.customer!, (value) {
    return _then(_self.copyWith(customer: value));
  });
}
}

// dart format on
