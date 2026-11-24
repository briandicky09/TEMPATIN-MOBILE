import '../database/app_database.dart';

class AuthenticatedUser {
  const AuthenticatedUser({required this.user, this.profile});

  final User user;
  final UserProfile? profile;

  bool get isOwner => user.role == 'owner';
  bool get isMember => user.role == 'member';
}

class KosFilterParams {
  const KosFilterParams({
    this.query = '',
    this.type,
    this.minPrice,
    this.maxPrice,
    this.facilityIds = const {},
    this.sortBy = 'newest',
  });

  final String query;
  final String? type;
  final double? minPrice;
  final double? maxPrice;
  final Set<int> facilityIds;
  final String sortBy; // newest, price_asc, price_desc, rating_desc

  KosFilterParams copyWith({
    String? query,
    String? Function()? type,
    double? Function()? minPrice,
    double? Function()? maxPrice,
    Set<int>? facilityIds,
    String? sortBy,
  }) {
    return KosFilterParams(
      query: query ?? this.query,
      type: type != null ? type() : this.type,
      minPrice: minPrice != null ? minPrice() : this.minPrice,
      maxPrice: maxPrice != null ? maxPrice() : this.maxPrice,
      facilityIds: facilityIds ?? this.facilityIds,
      sortBy: sortBy ?? this.sortBy,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KosFilterParams &&
          query == other.query &&
          type == other.type &&
          minPrice == other.minPrice &&
          maxPrice == other.maxPrice &&
          sortBy == other.sortBy &&
          facilityIds.length == other.facilityIds.length &&
          facilityIds.containsAll(other.facilityIds);

  @override
  int get hashCode => Object.hash(
    query,
    type,
    minPrice,
    maxPrice,
    sortBy,
    Object.hashAllUnordered(facilityIds),
  );
}

class KosCardData {
  const KosCardData({
    required this.kos,
    required this.averageRating,
    required this.reviewCount,
    required this.facilityNames,
    this.isFavorited = false,
  });

  final KosProperty kos;
  final double averageRating;
  final int reviewCount;
  final List<String> facilityNames;
  final bool isFavorited;
}

class KosDetailData {
  const KosDetailData({
    required this.kos,
    required this.images,
    required this.facilities,
    required this.reviews,
    required this.ownerName,
    required this.ownerPhone,
    required this.averageRating,
    required this.isFavorited,
  });

  final KosProperty kos;
  final List<KosImage> images;
  final List<Facility> facilities;
  final List<Review> reviews;
  final String ownerName;
  final String ownerPhone;
  final double averageRating;
  final bool isFavorited;
}

class BookingWithDetails {
  const BookingWithDetails({
    required this.booking,
    required this.kosTitle,
    required this.kosCity,
    required this.kosThumbnail,
    this.invoice,
  });

  final Booking booking;
  final String kosTitle;
  final String kosCity;
  final String kosThumbnail;
  final Invoice? invoice;
}

class InvoiceWithDetails {
  const InvoiceWithDetails({
    required this.invoice,
    required this.bookingCode,
    required this.kosTitle,
    required this.tenantName,
    required this.durationMonths,
    required this.startDate,
    required this.endDate,
  });

  final Invoice invoice;
  final String bookingCode;
  final String kosTitle;
  final String tenantName;
  final int durationMonths;
  final String startDate;
  final String endDate;
}

class OwnerDashboardStats {
  const OwnerDashboardStats({
    required this.totalProperties,
    required this.activeProperties,
    required this.totalBookings,
    required this.pendingBookings,
    required this.paidRevenue,
    required this.unreadNotifications,
    required this.properties,
  });

  final int totalProperties;
  final int activeProperties;
  final int totalBookings;
  final int pendingBookings;
  final double paidRevenue;
  final int unreadNotifications;
  final List<KosCardData> properties;
}
