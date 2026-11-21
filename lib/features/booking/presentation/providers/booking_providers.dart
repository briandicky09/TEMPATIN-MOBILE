import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_response.dart';
import '../../../../shared/models/paginated_list_state.dart';
import '../../../../shared/models/transaction_models.dart';
import '../../../../shared/models/user_model.dart';
import '../../../authentication/presentation/providers/auth_session_provider.dart';
import '../../data/booking_repository.dart';

class MyBookingsNotifier
    extends AsyncNotifier<PaginatedListState<BookingModel>> {
  @override
  Future<PaginatedListState<BookingModel>> build() async {
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
    final res = await ref.read(bookingRepositoryProvider).fetchBookings();
    return PaginatedListState(items: res.items, meta: res.meta);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final res = await ref.read(bookingRepositoryProvider).fetchBookings();
      return PaginatedListState(items: res.items, meta: res.meta);
    });
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.hasMore || current.isLoadingMore) return;

    state = AsyncData(current.copyWith(isLoadingMore: true));
    try {
      final next = await ref
          .read(bookingRepositoryProvider)
          .fetchBookings(
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
}

final myBookingsProvider =
    AsyncNotifierProvider<MyBookingsNotifier, PaginatedListState<BookingModel>>(
      MyBookingsNotifier.new,
    );

final bookingDetailProvider = FutureProvider.family
    .autoDispose<BookingModel, String>((ref, bookingCode) {
      return ref
          .read(bookingRepositoryProvider)
          .fetchBookingDetail(bookingCode);
    });
