import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/error_mapper.dart';
import '../../../../shared/models/facility_model.dart';
import '../../../../shared/models/kos_models.dart';
import '../../../../shared/models/paginated_list_state.dart';

import 'package:dio/dio.dart';

import '../../data/property_repository.dart';
import '../../domain/kos_filter.dart';

final facilitiesProvider = FutureProvider<List<FacilityModel>>((ref) {
  return ref.read(propertyRepositoryProvider).fetchFacilities();
});

class ExploreFilterNotifier extends Notifier<KosFilter> {
  @override
  KosFilter build() => const KosFilter();

  void update(KosFilter filter) {
    state = filter;
  }

  void setKeyword(String keyword) {
    state = state.copyWith(keyword: keyword);
  }

  void setCity(String? city) {
    state = state.copyWith(city: () => city);
  }

  void setType(String? type) {
    state = state.copyWith(type: () => type);
  }

  void reset() {
    state = const KosFilter();
  }
}

final exploreFilterProvider =
    NotifierProvider<ExploreFilterNotifier, KosFilter>(
      ExploreFilterNotifier.new,
    );

class ExploreKosNotifier
    extends AsyncNotifier<PaginatedListState<KosSummaryModel>> {
  @override
  Future<PaginatedListState<KosSummaryModel>> build() async {
    final filter = ref.watch(exploreFilterProvider);
    final res = await ref
        .read(propertyRepositoryProvider)
        .searchKos(filter: filter, page: 1, perPage: 10);
    return PaginatedListState(items: res.items, meta: res.meta);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final filter = ref.read(exploreFilterProvider);
      final res = await ref
          .read(propertyRepositoryProvider)
          .searchKos(filter: filter, page: 1, perPage: 10);
      return PaginatedListState(items: res.items, meta: res.meta);
    });
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.hasMore || current.isLoadingMore) return;

    state = AsyncData(
      current.copyWith(isLoadingMore: true, loadMoreError: () => null),
    );

    try {
      final filter = ref.read(exploreFilterProvider);
      final next = await ref
          .read(propertyRepositoryProvider)
          .searchKos(
            filter: filter,
            page: current.meta.currentPage + 1,
            perPage: current.meta.perPage,
          );
      state = AsyncData(
        current.copyWith(
          items: [...current.items, ...next.items],
          meta: next.meta,
          isLoadingMore: false,
        ),
      );
    } on DioException catch (e) {
      state = AsyncData(
        current.copyWith(
          isLoadingMore: false,
          loadMoreError: () => ErrorMapper.fromDio(e).message,
        ),
      );
    } catch (e) {
      state = AsyncData(
        current.copyWith(
          isLoadingMore: false,
          loadMoreError: () => e.toString(),
        ),
      );
    }
  }

  void setFavoriteStatus(String slug, bool isFavorited) {
    final current = state.value;
    if (current == null) return;
    final updated = current.items
        .map((k) => k.slug == slug ? k.copyWith(isFavorited: isFavorited) : k)
        .toList();
    state = AsyncData(current.copyWith(items: updated));
  }
}

final exploreKosProvider =
    AsyncNotifierProvider<
      ExploreKosNotifier,
      PaginatedListState<KosSummaryModel>
    >(ExploreKosNotifier.new);

final kosDetailProvider = FutureProvider.family
    .autoDispose<KosDetailModel, String>((ref, slug) {
      return ref.read(propertyRepositoryProvider).fetchKosDetail(slug);
    });
