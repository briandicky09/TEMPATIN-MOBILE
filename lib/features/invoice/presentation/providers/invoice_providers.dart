import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_response.dart';
import '../../../../shared/models/paginated_list_state.dart';
import '../../../../shared/models/transaction_models.dart';
import '../../../../shared/models/user_model.dart';
import '../../../authentication/presentation/providers/auth_session_provider.dart';
import '../../data/invoice_repository.dart';

class MyInvoicesNotifier
    extends AsyncNotifier<PaginatedListState<InvoiceModel>> {
  @override
  Future<PaginatedListState<InvoiceModel>> build() async {
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
    final res = await ref.read(invoiceRepositoryProvider).fetchInvoices();
    return PaginatedListState(items: res.items, meta: res.meta);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final res = await ref.read(invoiceRepositoryProvider).fetchInvoices();
      return PaginatedListState(items: res.items, meta: res.meta);
    });
  }
}

final myInvoicesProvider =
    AsyncNotifierProvider<MyInvoicesNotifier, PaginatedListState<InvoiceModel>>(
      MyInvoicesNotifier.new,
    );

final invoiceDetailProvider = FutureProvider.family
    .autoDispose<InvoiceModel, String>((ref, invoiceNumber) {
      return ref
          .read(invoiceRepositoryProvider)
          .fetchInvoiceDetail(invoiceNumber);
    });
