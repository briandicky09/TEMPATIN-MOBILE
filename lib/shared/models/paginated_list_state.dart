import '../../core/network/api_response.dart';

/// Shared immutable pagination state for scrollable lists.
class PaginatedListState<T> {
  const PaginatedListState({
    required this.items,
    required this.meta,
    this.isLoadingMore = false,
    this.loadMoreError,
  });

  final List<T> items;
  final PaginationMeta meta;
  final bool isLoadingMore;
  final String? loadMoreError;

  bool get hasMore => meta.hasMore;

  PaginatedListState<T> copyWith({
    List<T>? items,
    PaginationMeta? meta,
    bool? isLoadingMore,
    String? Function()? loadMoreError,
  }) {
    return PaginatedListState<T>(
      items: items ?? this.items,
      meta: meta ?? this.meta,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      loadMoreError: loadMoreError != null
          ? loadMoreError()
          : this.loadMoreError,
    );
  }
}
