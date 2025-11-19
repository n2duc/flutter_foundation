import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';
import 'package:flutter_base/message/ui/cubit/message_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  static const routeName = 'message';

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  late final MessageCubit _bloc;
  late final TextEditingController _messageController;
  late final ScrollController _scrollController;
  int _lastMessageCount = 0;

  @override
  void initState() {
    super.initState();
    _bloc = getIt<MessageCubit>();
    _messageController = TextEditingController();
    _scrollController = ScrollController();
    _bloc.loadConversation();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _handleSend() {
    final text = _messageController.text;
    if (text.trim().isEmpty) {
      return;
    }
    _bloc.sendMessage(text);
    _messageController.clear();
    FocusScope.of(context).unfocus();
  }

  Future<void> _handleImageSelection(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      _bloc.sendImage(image.path);
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) {
        return;
      }
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MessageCubit, MessageState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is MessageStateSuccess &&
            state.messages.length != _lastMessageCount) {
          _lastMessageCount = state.messages.length;
          _scrollToBottom();
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: RFXColors.lightSurfaceContainerLowest,
          appBar: _buildAppBar(state),
          body: Column(
            children: [
              Expanded(child: _buildBody(state)),
              _buildComposer(enabled: state is MessageStateSuccess),
            ],
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(MessageState state) {
    final theme = Theme.of(context);
    String title = 'Messages';
    String subtitle = 'Connecting to conversation';
    Color subtitleColor = RFXColors.lightOnSurfaceVariant;
    String avatarUrl = '';

    if (state is MessageStateSuccess) {
      final contact = state.contact;
      title = contact['name'] as String? ?? 'Travel Buddy';
      avatarUrl = contact['avatarUrl'] as String? ?? '';
      subtitle = _formatPresence(contact);
      subtitleColor = (contact['isOnline'] as bool? ?? false)
          ? Colors.green
          : RFXColors.lightOnSurfaceVariant;
    } else if (state is MessageStateError) {
      subtitle = 'Failed to load conversation';
      subtitleColor = RFXColors.lightError;
    }

    return AppBar(
      backgroundColor: RFXColors.lightOnPrimary,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(RFXSpacing.spacing20),
        ),
      ),
      leading: IconButton(
        icon: const Icon(
          Iconsax.arrow_left_2_copy,
          color: RFXColors.lightPrimary,
          size: RFXSpacing.spacing24,
        ),
        onPressed: () => Navigator.of(context).maybePop(),
      ),
      titleSpacing: 0,
      title: Row(
        children: [
          CircleAvatar(
            radius: RFXSpacing.spacing20,
            backgroundColor: RFXColors.lightPrimary.withValues(alpha: 0.1),
            backgroundImage: avatarUrl.isNotEmpty
                ? NetworkImage(avatarUrl)
                : null,
            child: avatarUrl.isEmpty
                ? const Icon(Iconsax.user, color: RFXColors.lightPrimary)
                : null,
          ),
          const SizedBox(width: RFXSpacing.spacing12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: RFXColors.lightPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: RFXSpacing.spacing4),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: subtitleColor,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Iconsax.video_copy)),
        IconButton(onPressed: () {}, icon: const Icon(Iconsax.call_copy)),
        const SizedBox(width: RFXSpacing.spacing8),
      ],
    );
  }

  Widget _buildBody(MessageState state) {
    if (state is MessageStateLoading) {
      return const Center(
        child: CircularProgressIndicator(color: RFXColors.lightPrimary),
      );
    }

    if (state is MessageStateError) {
      return _buildError(state.errorMessage);
    }

    if (state is MessageStateSuccess) {
      if (state.messages.isEmpty) {
        return _buildEmptyState(state.contact);
      }
      return _buildMessageList(state);
    }

    return const SizedBox.shrink();
  }

  Widget _buildMessageList(MessageStateSuccess state) {
    final textTheme = Theme.of(context).textTheme;
    final dateFormat = DateFormat('EEEE, MMM d');
    final timeFormat = DateFormat('HH:mm');

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.fromLTRB(
        RFXSpacing.spacing16,
        RFXSpacing.spacing16,
        RFXSpacing.spacing16,
        RFXSpacing.spacing96,
      ),
      physics: const BouncingScrollPhysics(),
      itemCount: state.messages.length,
      itemBuilder: (context, index) {
        final message = state.messages[index];
        final timestamp = message['timestamp'] as DateTime;
        final showDateLabel =
            index == 0 ||
            !_isSameDay(
              timestamp,
              state.messages[index - 1]['timestamp'] as DateTime,
            );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (showDateLabel)
              Padding(
                padding: const EdgeInsets.only(bottom: RFXSpacing.spacing12),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: RFXSpacing.spacing16,
                      vertical: RFXSpacing.spacing6,
                    ),
                    decoration: BoxDecoration(
                      color: RFXColors.lightPrimary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(RFXSpacing.spacing24),
                    ),
                    child: Text(
                      dateFormat.format(timestamp),
                      style: textTheme.bodySmall?.copyWith(
                        color: RFXColors.lightPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            Align(
              alignment: (message['isMine'] as bool? ?? false)
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: _MessageBubble(
                message: message,
                timeLabel: timeFormat.format(timestamp),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildComposer({required bool enabled}) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: RFXSpacing.spacing16,
          vertical: RFXSpacing.spacing12,
        ),
        decoration: BoxDecoration(
          color: RFXColors.lightOnPrimary,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(RFXSpacing.spacing24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                enabled: enabled,
                minLines: 1,
                maxLines: 4,
                textInputAction: TextInputAction.send,
                decoration: InputDecoration(
                  hintText: 'Type your message...',
                  filled: true,
                  fillColor: RFXColors.lightSurfaceContainer,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: RFXSpacing.spacing20,
                    vertical: RFXSpacing.spacing14,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(RFXSpacing.spacing28),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(RFXSpacing.spacing28),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSubmitted: (_) => _handleSend(),
              ),
            ),
            const SizedBox(width: RFXSpacing.spacing12),
            IconButton(
              onPressed: enabled
                  ? () => _handleImageSelection(ImageSource.camera)
                  : null,
              icon: const Icon(Iconsax.camera_copy),
            ),
            IconButton(
              onPressed: enabled
                  ? () => _handleImageSelection(ImageSource.gallery)
                  : null,
              icon: const Icon(Iconsax.image_copy),
            ),
            const SizedBox(width: RFXSpacing.spacing4),
            _SendButton(enabled: enabled, onTap: _handleSend),
          ],
        ),
      ),
    );
  }

  Widget _buildError(String message) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: RFXSpacing.spacing32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Iconsax.info_circle_copy,
              size: RFXSpacing.spacing40,
              color: RFXColors.lightError,
            ),
            const SizedBox(height: RFXSpacing.spacing12),
            Text(
              'Could not load conversation',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: RFXSpacing.spacing8),
            Text(
              message,
              style: textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: RFXSpacing.spacing16),
            RFXPrimaryButton.small(
              title: 'Try again',
              onPressed: _bloc.loadConversation,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(Map<String, dynamic> contact) {
    final textTheme = Theme.of(context).textTheme;
    final name = contact['name'] as String? ?? 'your travel buddy';
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: RFXSpacing.spacing32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Iconsax.messages_2_copy,
              size: RFXSpacing.spacing40,
              color: RFXColors.lightPrimary,
            ),
            const SizedBox(height: RFXSpacing.spacing12),
            Text(
              'Start something good',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: RFXSpacing.spacing8),
            Text(
              'Say hello to $name and plan the journey together.',
              style: textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  String _formatPresence(Map<String, dynamic> contact) {
    final isOnline = contact['isOnline'] as bool? ?? false;
    if (isOnline) {
      return 'Online';
    }
    final lastSeen = contact['lastSeen'] as DateTime?;
    if (lastSeen == null) {
      return 'Offline';
    }
    final difference = DateTime.now().difference(lastSeen);
    if (difference.inMinutes <= 1) {
      return 'Last seen moments ago';
    }
    if (difference.inMinutes < 60) {
      return 'Last seen ${difference.inMinutes}m ago';
    }
    if (difference.inHours < 24) {
      return 'Last seen ${difference.inHours}h ago';
    }
    return 'Last seen on ${DateFormat('MMM d').format(lastSeen)}';
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message, required this.timeLabel});

  final Map<String, dynamic> message;
  final String timeLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMine = message['isMine'] as bool? ?? false;
    final textColor = isMine
        ? RFXColors.lightOnPrimary
        : RFXColors.lightOnSurface;
    final backgroundColor = isMine
        ? RFXColors.lightPrimary
        : RFXColors.lightSurfaceContainer;

    return Container(
      margin: EdgeInsets.only(
        top: RFXSpacing.spacing6,
        bottom: RFXSpacing.spacing6,
        left: isMine ? RFXSpacing.spacing72 : 0,
        right: isMine ? 0 : RFXSpacing.spacing72,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: RFXSpacing.spacing16,
        vertical: RFXSpacing.spacing12,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(RFXSpacing.spacing20),
          topRight: const Radius.circular(RFXSpacing.spacing20),
          bottomLeft: Radius.circular(
            isMine ? RFXSpacing.spacing20 : RFXSpacing.spacing6,
          ),
          bottomRight: Radius.circular(
            isMine ? RFXSpacing.spacing6 : RFXSpacing.spacing20,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: isMine
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
            message['type'] == 'image'
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(RFXSpacing.spacing12),
                    child: Image.file(
                      File(message['text'] as String),
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          width: 200,
                          color: RFXColors.lightSurfaceContainerHigh,
                          child: const Icon(
                            Iconsax.image_copy,
                            color: RFXColors.lightOnSurfaceVariant,
                          ),
                        );
                      },
                    ),
                  )
                : Text(
                    message['text'] as String? ?? '',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: textColor,
                      height: 1.4,
                    ),
                  ),
          const SizedBox(height: RFXSpacing.spacing6),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                timeLabel,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: textColor.withValues(alpha: 0.8),
                  fontSize: 11,
                ),
              ),
              if (isMine)
                ..._buildStatus(
                  theme,
                  message['status'] as String?,
                  textColor.withValues(alpha: 0.8),
                ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildStatus(ThemeData theme, String? status, Color color) {
    final label = switch (status) {
      'sending' => 'Sending...',
      'sent' => 'Sent',
      'delivered' => 'Delivered',
      'read' => 'Read',
      _ => null,
    };
    if (label == null) {
      return const [];
    }
    return [
      const SizedBox(width: RFXSpacing.spacing6),
      Text(
        label,
        style: theme.textTheme.bodySmall?.copyWith(color: color, fontSize: 11),
      ),
    ];
  }
}

class _SendButton extends StatelessWidget {
  const _SendButton({required this.enabled, required this.onTap});

  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = enabled
        ? RFXColors.lightPrimary
        : RFXColors.lightOutlineVariant;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(RFXSpacing.spacing28),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(RFXSpacing.spacing28),
          ),
          padding: const EdgeInsets.all(RFXSpacing.spacing12),
          child: const Icon(
            Iconsax.send_2,
            color: RFXColors.lightOnPrimary,
            size: RFXSpacing.spacing20,
          ),
        ),
      ),
    );
  }
}
