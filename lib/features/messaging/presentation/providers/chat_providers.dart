import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/models/chat_models.dart';
import '../../../authentication/presentation/providers/auth_session_provider.dart';
import '../../data/chat_repository.dart';

final conversationsProvider =
    FutureProvider.autoDispose<List<ConversationModel>>((ref) async {
      final auth = ref.watch(authSessionProvider);
      if (!auth.isAuthenticated) return const [];
      final res = await ref.read(chatRepositoryProvider).fetchConversations();
      return res.items;
    });
