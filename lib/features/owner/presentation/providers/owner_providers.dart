import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_response.dart';
import '../../../../shared/models/kos_models.dart';
import '../../../../shared/models/owner_models.dart';
import '../../../../shared/models/transaction_models.dart';
import '../../data/owner_repository.dart';

final ownerDashboardProvider = FutureProvider.autoDispose<OwnerDashboardModel>((
  ref,
) {
  return ref.read(ownerRepositoryProvider).fetchDashboard();
});

typedef OwnerKosQuery = ({String status, String search});

final ownerKosListProvider = FutureProvider.family
    .autoDispose<OwnerKosPageResult, OwnerKosQuery>((ref, query) {
      return ref
          .read(ownerRepositoryProvider)
          .fetchKosList(
            status: query.status,
            search: query.search,
            perPage: 30,
          );
    });

final ownerKosDetailProvider = FutureProvider.family
    .autoDispose<KosDetailModel, String>((ref, slug) {
      return ref.read(ownerRepositoryProvider).fetchKosDetail(slug);
    });

final ownerKosRoomsProvider = FutureProvider.family
    .autoDispose<List<RoomModel>, String>((ref, slug) {
      return ref.read(ownerRepositoryProvider).fetchRooms(slug);
    });

typedef OwnerBookingsQuery = ({String status, String search});

final ownerBookingsProvider = FutureProvider.family
    .autoDispose<OwnerBookingsPageResult, OwnerBookingsQuery>((ref, query) {
      return ref
          .read(ownerRepositoryProvider)
          .fetchBookings(
            status: query.status,
            search: query.search,
            perPage: 30,
          );
    });

final ownerBookingDetailProvider = FutureProvider.family
    .autoDispose<OwnerBookingDetailData, String>((ref, code) {
      return ref.read(ownerRepositoryProvider).fetchBookingDetail(code);
    });

final ownerTenantsProvider = FutureProvider.family
    .autoDispose<({List<BookingModel> items, PaginationMeta meta}), String>((
      ref,
      status,
    ) {
      return ref.read(ownerRepositoryProvider).fetchTenants(status: status);
    });

final ownerSurveysProvider = FutureProvider.family
    .autoDispose<({List<SurveyModel> items, PaginationMeta meta}), String>((
      ref,
      status,
    ) {
      return ref.read(ownerRepositoryProvider).fetchSurveys(status: status);
    });

final ownerMaintenanceProvider = FutureProvider.family
    .autoDispose<
      ({List<MaintenanceReportModel> items, PaginationMeta meta}),
      String
    >((ref, status) {
      return ref.read(ownerRepositoryProvider).fetchMaintenance(status: status);
    });

final ownerReviewsProvider = FutureProvider.autoDispose<OwnerReviewsPageResult>(
  (ref) => ref.read(ownerRepositoryProvider).fetchReviews(perPage: 30),
);

final ownerAnalyticsProvider = FutureProvider.autoDispose<OwnerAnalyticsModel>((
  ref,
) {
  return ref.read(ownerRepositoryProvider).fetchAnalytics();
});
