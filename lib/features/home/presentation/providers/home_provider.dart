import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/models/home_data_model.dart';
import '../../../../shared/models/kos_models.dart';
import '../../data/home_repository.dart';

class HomeNotifier extends AsyncNotifier<HomeDataModel> {
  @override
  Future<HomeDataModel> build() => _fetch();

  Future<HomeDataModel> _fetch() =>
      ref.read(homeRepositoryProvider).fetchHomeData();

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_fetch);
  }

  void setFavoriteStatus(String slug, bool isFavorited) {
    final current = state.value;
    if (current == null) return;
    final updated = current.featuredKos
        .map(
          (KosSummaryModel k) =>
              k.slug == slug ? k.copyWith(isFavorited: isFavorited) : k,
        )
        .toList();
    state = AsyncData(current.copyWith(featuredKos: updated));
  }
}

final homeProvider = AsyncNotifierProvider<HomeNotifier, HomeDataModel>(
  HomeNotifier.new,
);
