import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/config/app_mode_provider.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../../core/widgets/tempatin_card.dart';
import '../../../../shared/models/chat_models.dart';
import '../../../authentication/presentation/providers/auth_session_provider.dart';
import '../../data/chat_repository.dart';
import '../providers/chat_providers.dart';

/// Shared inbox listing conversations for Customer & Owner (`GET /api/v1/conversations`).
class ChatListScreen extends ConsumerWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final convsAsync = ref.watch(conversationsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Pesan')),
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () async => ref.invalidate(conversationsProvider),
        child: convsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => AppErrorState(
            message: err.toString(),
            onRetry: () => ref.invalidate(conversationsProvider),
          ),
          data: (items) {
            if (items.isEmpty) {
              return ListView(
                children: const [
                  SizedBox(height: 48),
                  AppEmptyState(
                    icon: LucideIcons.messageSquare,
                    title: 'Belum Ada Percakapan',
                    description: 'Pesan dengan pemilik kos atau calon penyewa akan tampil di sini.',
                  ),
                ],
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.lg),
              itemCount: items.length,
              separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
              itemBuilder: (context, index) {
                final c = items[index];
                final title = c.counterpart?.name ?? 'Pengguna';
                final kosTitle = c.kos?.title ?? 'Properti Kos';
                final preview =
                    c.lastMessage?.message ?? 'Ketuk untuk membuka percakapan';

                return TempatinCard(
                  onTap: () =>
                      context.push(RoutePaths.chatDetail(c.id), extra: c),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: AppColors.primaryTint,
                        child: Text(
                          title.isNotEmpty ? title[0].toUpperCase() : 'T',
                          style: AppTypography.label.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTypography.label.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                if (c.unreadCount > 0)
                                  StatusBadge(
                                    label: '${c.unreadCount}',
                                    tone: StatusTone.info,
                                  ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              kosTitle,
                              style: AppTypography.caption.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              preview,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.bodySm,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

/// Real-time polled conversation thread using `after_id` ONLY while mounted.
class ChatDetailScreen extends ConsumerStatefulWidget {
  const ChatDetailScreen({
    super.key,
    required this.conversationId,
    this.initialConversation,
  });

  final int conversationId;
  final ConversationModel? initialConversation;

  @override
  ConsumerState<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends ConsumerState<ChatDetailScreen> {
  final _inputController = TextEditingController();
  final _scrollController = ScrollController();
  final List<MessageModel> _messages = [];
  Timer? _pollTimer;
  bool _isLoading = true;
  bool _isSending = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadInitial();
    if (!ref.read(appModeProvider).isOfflineDemo) {
      _pollTimer = Timer.periodic(
        const Duration(seconds: 6),
        (_) => _pollNewMessages(),
      );
    }
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadInitial() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final list = await ref
          .read(chatRepositoryProvider)
          .fetchMessages(widget.conversationId);
      if (!mounted) return;
      setState(() {
        _messages
          ..clear()
          ..addAll(list);
        _isLoading = false;
      });
      ref.invalidate(conversationsProvider);
      _scrollToBottom();
    } on AppException catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.message;
        _isLoading = false;
      });
    }
  }

  Future<void> _pollNewMessages() async {
    if (!mounted || _isLoading) return;
    final lastId = _messages.isNotEmpty ? _messages.last.id : null;
    if (lastId == null) {
      await _loadInitial();
      return;
    }
    try {
      final fresh = await ref
          .read(chatRepositoryProvider)
          .fetchMessages(widget.conversationId, afterId: lastId);
      if (!mounted || fresh.isEmpty) return;
      final existingIds = _messages.map((m) => m.id).toSet();
      final appended = fresh.where((m) => !existingIds.contains(m.id)).toList();
      if (appended.isEmpty) return;
      setState(() => _messages.addAll(appended));
      ref.invalidate(conversationsProvider);
      _scrollToBottom();
    } catch (_) {
      // Silent background poll failure keeps thread responsive
    }
  }

  Future<void> _send() async {
    final text = _inputController.text.trim();
    if (text.isEmpty || _isSending) return;

    setState(() => _isSending = true);
    try {
      final msg = await ref
          .read(chatRepositoryProvider)
          .sendMessage(widget.conversationId, text);
      if (!mounted) return;
      _inputController.clear();
      if (!_messages.any((m) => m.id == msg.id)) {
        setState(() => _messages.add(msg));
      }
      ref.invalidate(conversationsProvider);
      _scrollToBottom();
    } on AppException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final myId = ref.watch(authSessionProvider).user?.id;
    final title = widget.initialConversation?.counterpart?.name ?? 'Percakapan';
    final subtitle = widget.initialConversation?.kos?.title;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            if (subtitle != null) Text(subtitle, style: AppTypography.caption),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _error != null
                ? AppErrorState(message: _error!, onRetry: _loadInitial)
                : _messages.isEmpty
                ? const AppEmptyState(
                    icon: LucideIcons.messageSquare,
                    title: 'Mulai Percakapan',
                    description: 'Tulis pesan Anda di bawah ini.',
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final m = _messages[index];
                      final isMine = myId != null && m.senderId == myId;
                      return _MessageBubble(message: m, isMine: isMine);
                    },
                  ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.sm,
              AppSpacing.md,
              AppSpacing.md,
            ),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              border: Border(top: BorderSide(color: AppColors.borderHairline)),
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _inputController,
                      minLines: 1,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        hintText: 'Tulis pesan...',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  IconButton.filled(
                    onPressed: _isSending ? null : _send,
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    icon: _isSending
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(LucideIcons.send, size: 18),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message, required this.isMine});

  final MessageModel message;
  final bool isMine;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.76,
        ),
        decoration: BoxDecoration(
          color: isMine ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: isMine ? null : Border.all(color: AppColors.borderHairline),
        ),
        child: Column(
          crossAxisAlignment: isMine
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(
              message.message,
              style: AppTypography.body.copyWith(
                color: isMine ? Colors.white : AppColors.inkCharcoal,
              ),
            ),
            if (message.createdAt != null) ...[
              const SizedBox(height: 4),
              Text(
                DateFormatter.dateTime(message.createdAt!),
                style: AppTypography.caption.copyWith(
                  fontSize: 10,
                  color: isMine
                      ? Colors.white.withValues(alpha: 0.78)
                      : AppColors.inkMuted,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
