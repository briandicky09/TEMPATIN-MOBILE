/// Sort options supported by Laravel `GET /api/v1/kos`.
enum KosSortOption {
  newest('newest', 'Terbaru'),
  priceAsc('price_asc', 'Harga Terendah'),
  priceDesc('price_desc', 'Harga Tertinggi'),
  ratingDesc('rating_desc', 'Rating Tertinggi');

  const KosSortOption(this.apiValue, this.label);
  final String apiValue;
  final String label;
}

/// Filter parameters for exploring kos properties (`GET /api/v1/kos`).
class KosFilter {
  const KosFilter({
    this.keyword = '',
    this.type,
    this.city,
    this.minPrice,
    this.maxPrice,
    this.facilityIds = const [],
    this.sort = KosSortOption.newest,
  });

  final String keyword;
  final String? type;
  final String? city;
  final double? minPrice;
  final double? maxPrice;
  final List<int> facilityIds;
  final KosSortOption sort;

  int get activeFilterCount {
    int count = 0;
    if (type != null && type!.isNotEmpty) count++;
    if (city != null && city!.isNotEmpty) count++;
    if (minPrice != null) count++;
    if (maxPrice != null) count++;
    if (facilityIds.isNotEmpty) count++;
    if (sort != KosSortOption.newest) count++;
    return count;
  }

  bool get hasAnyFilter => keyword.trim().isNotEmpty || activeFilterCount > 0;

  KosFilter copyWith({
    String? keyword,
    String? Function()? type,
    String? Function()? city,
    double? Function()? minPrice,
    double? Function()? maxPrice,
    List<int>? facilityIds,
    KosSortOption? sort,
  }) {
    return KosFilter(
      keyword: keyword ?? this.keyword,
      type: type != null ? type() : this.type,
      city: city != null ? city() : this.city,
      minPrice: minPrice != null ? minPrice() : this.minPrice,
      maxPrice: maxPrice != null ? maxPrice() : this.maxPrice,
      facilityIds: facilityIds ?? this.facilityIds,
      sort: sort ?? this.sort,
    );
  }

  Map<String, dynamic> toQueryParams({int page = 1, int perPage = 10}) {
    return {
      'page': page,
      'per_page': perPage,
      'sort': sort.apiValue,
      if (keyword.trim().isNotEmpty) 'keyword': keyword.trim(),
      if (type != null && type!.isNotEmpty) 'type': type,
      if (city != null && city!.isNotEmpty) 'city': city,
      if (minPrice != null) 'min_price': minPrice!.toInt(),
      if (maxPrice != null) 'max_price': maxPrice!.toInt(),
      if (facilityIds.isNotEmpty) 'facilities[]': facilityIds,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is KosFilter &&
        other.keyword == keyword &&
        other.type == type &&
        other.city == city &&
        other.minPrice == minPrice &&
        other.maxPrice == maxPrice &&
        other.sort == sort &&
        _listEquals(other.facilityIds, facilityIds);
  }

  @override
  int get hashCode => Object.hash(
    keyword,
    type,
    city,
    minPrice,
    maxPrice,
    sort,
    Object.hashAll(facilityIds),
  );

  static bool _listEquals(List<int> a, List<int> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
