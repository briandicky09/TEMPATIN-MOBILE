// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kos_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OwnerSummaryModel _$OwnerSummaryModelFromJson(Map<String, dynamic> json) =>
    _OwnerSummaryModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      phone: json['phone'] as String?,
      avatarUrl: json['avatar_url'] as String?,
    );

Map<String, dynamic> _$OwnerSummaryModelToJson(_OwnerSummaryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'avatar_url': instance.avatarUrl,
    };

_KosPhotoModel _$KosPhotoModelFromJson(Map<String, dynamic> json) =>
    _KosPhotoModel(
      id: (json['id'] as num).toInt(),
      photoUrl: json['photo_url'] as String,
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$KosPhotoModelToJson(_KosPhotoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'photo_url': instance.photoUrl,
      'sort_order': instance.sortOrder,
    };

_RoomModel _$RoomModelFromJson(Map<String, dynamic> json) => _RoomModel(
  id: (json['id'] as num).toInt(),
  roomNumber: json['room_number'] as String,
  floor: json['floor'] as String?,
  roomType: json['room_type'] as String?,
  priceOverride: nullableDoubleFromJson(json['price_override']),
  effectivePrice: json['effective_price'] == null
      ? 0.0
      : doubleFromJson(json['effective_price']),
  status: json['status'] as String? ?? 'available',
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$RoomModelToJson(_RoomModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'room_number': instance.roomNumber,
      'floor': instance.floor,
      'room_type': instance.roomType,
      'price_override': instance.priceOverride,
      'effective_price': instance.effectivePrice,
      'status': instance.status,
      'notes': instance.notes,
    };

_ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => _ReviewModel(
  id: (json['id'] as num).toInt(),
  reviewerName: json['reviewer_name'] as String,
  isVerifiedTenant: json['is_verified_tenant'] as bool? ?? false,
  rating: (json['rating'] as num?)?.toInt() ?? 5,
  comment: json['comment'] as String,
  reply: json['reply'] as String?,
  userAvatarUrl: json['user_avatar_url'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$ReviewModelToJson(_ReviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'reviewer_name': instance.reviewerName,
      'is_verified_tenant': instance.isVerifiedTenant,
      'rating': instance.rating,
      'comment': instance.comment,
      'reply': instance.reply,
      'user_avatar_url': instance.userAvatarUrl,
      'created_at': instance.createdAt?.toIso8601String(),
    };

_KosSummaryModel _$KosSummaryModelFromJson(Map<String, dynamic> json) =>
    _KosSummaryModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      slug: json['slug'] as String,
      price: doubleFromJson(json['price']),
      type: json['type'] as String,
      city: json['city'] as String,
      address: json['address'] as String?,
      thumbnailUrl: json['thumbnail_url'] as String,
      status: json['status'] as String? ?? 'active',
      rating: json['rating'] == null ? 0.0 : doubleFromJson(json['rating']),
      reviewCount: json['review_count'] == null
          ? 0
          : intFromJson(json['review_count']),
      isFavorited: json['is_favorited'] as bool? ?? false,
      availableRoomsCount: (json['available_rooms_count'] as num?)?.toInt(),
      facilities:
          (json['facilities'] as List<dynamic>?)
              ?.map((e) => FacilityModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$KosSummaryModelToJson(_KosSummaryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'slug': instance.slug,
      'price': instance.price,
      'type': instance.type,
      'city': instance.city,
      'address': instance.address,
      'thumbnail_url': instance.thumbnailUrl,
      'status': instance.status,
      'rating': instance.rating,
      'review_count': instance.reviewCount,
      'is_favorited': instance.isFavorited,
      'available_rooms_count': instance.availableRoomsCount,
      'facilities': instance.facilities.map((e) => e.toJson()).toList(),
    };

_KosDetailModel _$KosDetailModelFromJson(Map<String, dynamic> json) =>
    _KosDetailModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      slug: json['slug'] as String,
      description: json['description'] as String?,
      price: doubleFromJson(json['price']),
      type: json['type'] as String,
      city: json['city'] as String,
      address: json['address'] as String?,
      thumbnailUrl: json['thumbnail_url'] as String,
      status: json['status'] as String? ?? 'active',
      area: json['area'] as String?,
      roomsSummary: json['rooms_summary'] as String?,
      bathrooms: json['bathrooms'] as String?,
      bedrooms: json['bedrooms'] as String?,
      garages: json['garages'] as String?,
      latitude: nullableDoubleFromJson(json['latitude']),
      longitude: nullableDoubleFromJson(json['longitude']),
      rating: json['rating'] == null ? 0.0 : doubleFromJson(json['rating']),
      reviewCount: json['review_count'] == null
          ? 0
          : intFromJson(json['review_count']),
      isFavorited: json['is_favorited'] as bool? ?? false,
      canReview: json['can_review'] as bool? ?? false,
      owner: json['owner'] == null
          ? null
          : OwnerSummaryModel.fromJson(json['owner'] as Map<String, dynamic>),
      photos:
          (json['photos'] as List<dynamic>?)
              ?.map((e) => KosPhotoModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      facilities:
          (json['facilities'] as List<dynamic>?)
              ?.map((e) => FacilityModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      availableRooms:
          (json['available_rooms'] as List<dynamic>?)
              ?.map((e) => RoomModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      reviews:
          (json['reviews'] as List<dynamic>?)
              ?.map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      similarKos:
          (json['similar_kos'] as List<dynamic>?)
              ?.map((e) => KosSummaryModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$KosDetailModelToJson(
  _KosDetailModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'slug': instance.slug,
  'description': instance.description,
  'price': instance.price,
  'type': instance.type,
  'city': instance.city,
  'address': instance.address,
  'thumbnail_url': instance.thumbnailUrl,
  'status': instance.status,
  'area': instance.area,
  'rooms_summary': instance.roomsSummary,
  'bathrooms': instance.bathrooms,
  'bedrooms': instance.bedrooms,
  'garages': instance.garages,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'rating': instance.rating,
  'review_count': instance.reviewCount,
  'is_favorited': instance.isFavorited,
  'can_review': instance.canReview,
  'owner': instance.owner?.toJson(),
  'photos': instance.photos.map((e) => e.toJson()).toList(),
  'facilities': instance.facilities.map((e) => e.toJson()).toList(),
  'available_rooms': instance.availableRooms.map((e) => e.toJson()).toList(),
  'reviews': instance.reviews.map((e) => e.toJson()).toList(),
  'similar_kos': instance.similarKos.map((e) => e.toJson()).toList(),
};
