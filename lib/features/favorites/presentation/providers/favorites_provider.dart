import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_response.dart';
import '../../../../shared/models/kos_models.dart';
import '../../../../shared/models/paginated_list_state.dart';
import '../../../../shared/models/user_model.dart';
import '../../../authentication/presentation/providers/auth_session_provider.dart';
import '../../../home/presentation/providers/home_provider.dart';
import '../../../property/presentation/providers/property_providers.dart';
import '../../data/favorites_repository.dart';

class FavoritesNotifier
    extends AsyncNotifier<PaginatedListState<KosSummaryModel>> {
  @override
  Future<PaginatedListState<KosSummaryModel>> build() async {
    final auth = ref.watch(authSessionProvider);
    if (!auth.isAuthenticated || auth.role != UserRole.customer) {
      return const PaginatedListState(
        items: [],
        meta: PaginationMeta(
          currentPage: 1,
          lastPage: 1,
          perPage: 10,
          total: 0,
        ),
      );
    }
    final res = await ref
        .read(favoritesRepositoryProvider)
        .fetchFavorites(page: 1, perPage: 10);
    return PaginatedListState(items: res.items, meta: res.meta);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final res = await ref
          .read(favoritesRepositoryProvider)
          .fetchFavorites(page: 1, perPage: 10);
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
      final next = await ref
          .read(favoritesRepositoryProvider)
          .fetchFavorites(
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
    } catch (e) {
      state = AsyncData(
        current.copyWith(
          isLoadingMore: false,
          loadMoreError: () => e.toString(),
        ),
      );
    }
  }

  /// Toggles favorite optimistically across Home, Explore, and Favorites lists.
  Future<bool> toggleFavorite(KosSummaryModel kos) async {
    final nextFavorite = !kos.isFavorited;
    _syncAcrossScreens(kos.slug, nextFavorite);

    final currentList = state.value;
    if (currentList != null) {
      final updatedItems = nextFavorite
          ? [
              kos.copyWith(isFavorited: true),
              ...currentList.items.where((e) => e.slug != kos.slug),
            ]
          : currentList.items.where((e) => e.slug != kos.slug).toList();
      state = AsyncData(currentList.copyWith(items: updatedItems));
    }

    try {
      final res = await ref
          .read(favoritesRepositoryProvider)
          .toggleFavorite(kos.slug);
      _syncAcrossScreens(kos.slug, res.isFavorite);
      ref.invalidate(kosDetailProvider(kos.slug));
      return res.isFavorite;
    } catch (e) {
      // Revert optimistic state on error
      _syncAcrossScreens(kos.slug, kos.isFavorited);
      if (currentList != null) state = AsyncData(currentList);
      rethrow;
    }
  }

  void _syncAcrossScreens(String slug, bool isFavorited) {
    ref.read(homeProvider.notifier).setFavoriteStatus(slug, isFavorited);
    ref.read(exploreKosProvider.notifier).setFavoriteStatus(slug, isFavorited);
  }
}

final favoritesProvider =
    AsyncNotifierProvider<
      FavoritesNotifier,
      PaginatedListState<KosSummaryModel>
    >(FavoritesNotifier.new);
