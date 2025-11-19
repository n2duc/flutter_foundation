import 'package:bloc/bloc.dart';
import 'package:flutter_base/message/message.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

part 'message_cubit.freezed.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit({required this.messageRepositories})
    : super(const MessageState.loading());

  static final log = Logger('MessageCubit');

  @visibleForTesting
  final MessageRepositories messageRepositories;

  final List<String> _autoReplies = const [
    'Great, I will update the plan.',
    'Sure thing! Let me know if you need anything else.',
    'Copy that. I will send over the details shortly.',
  ];
  int _autoReplyIndex = 0;

  Future<void> loadConversation() async {
    emit(const MessageState.loading());
    try {
      final data = await messageRepositories.getConversation();
      final contact = Map<String, dynamic>.from(data['contact']);
      final messages = List<Map<String, dynamic>>.from(data['messages'])
        ..sort(
          (a, b) => (a['timestamp'] as DateTime).compareTo(
            b['timestamp'] as DateTime,
          ),
        );
      emit(MessageState.success(contact: contact, messages: messages));
    } catch (error, stackTrace) {
      log.severe('Error while trying to load MessageCubit', error, stackTrace);
      emit(
        const MessageState.error(
          errorMessage:
              'Somthing went wrong. Please check your internet connection and try again.',
        ),
      );
    }
  }

  void sendMessage(String content) {
    final trimmedContent = content.trim();
    final currentState = state;
    if (trimmedContent.isEmpty || currentState is! MessageStateSuccess) {
      return;
    }

    final messageId = 'local-${DateTime.now().millisecondsSinceEpoch}';
    final newMessage = <String, dynamic>{
      'id': messageId,
      'text': trimmedContent,
      'isMine': true,
      'timestamp': DateTime.now(),
      'status': 'sending',
      'type': 'text',
    };

    emit(
      currentState.copyWith(
        messages: List<Map<String, dynamic>>.from(currentState.messages)
          ..add(newMessage),
      ),
    );

    Future<void>.delayed(const Duration(milliseconds: 450)).then((_) {
      final latestState = state;
      if (isClosed || latestState is! MessageStateSuccess) {
        return;
      }

      final updatedMessages = List<Map<String, dynamic>>.from(
        latestState.messages,
      );
      final index = updatedMessages.indexWhere(
        (message) => message['id'] == messageId,
      );
      if (index == -1) {
        return;
      }

      updatedMessages[index] = {...updatedMessages[index], 'status': 'sent'};

      emit(latestState.copyWith(messages: updatedMessages));
    });

    if (_autoReplyIndex >= _autoReplies.length) {
      return;
    }

    Future<void>.delayed(const Duration(seconds: 2)).then((_) {
      if (isClosed || _autoReplyIndex >= _autoReplies.length) {
        return;
      }
      receiveMessage(message: _autoReplies[_autoReplyIndex]);
      _autoReplyIndex += 1;
    });
  }

  void sendImage(String path) {
    final currentState = state;
    if (currentState is! MessageStateSuccess) {
      return;
    }

    final messageId = 'local-${DateTime.now().millisecondsSinceEpoch}';
    final newMessage = <String, dynamic>{
      'id': messageId,
      'text': path,
      'isMine': true,
      'timestamp': DateTime.now(),
      'status': 'sending',
      'type': 'image',
    };

    emit(
      currentState.copyWith(
        messages: List<Map<String, dynamic>>.from(currentState.messages)
          ..add(newMessage),
      ),
    );

    Future<void>.delayed(const Duration(milliseconds: 450)).then((_) {
      final latestState = state;
      if (isClosed || latestState is! MessageStateSuccess) {
        return;
      }

      final updatedMessages = List<Map<String, dynamic>>.from(
        latestState.messages,
      );
      final index = updatedMessages.indexWhere(
        (message) => message['id'] == messageId,
      );
      if (index == -1) {
        return;
      }

      updatedMessages[index] = {...updatedMessages[index], 'status': 'sent'};

      emit(latestState.copyWith(messages: updatedMessages));
    });
  }

  void receiveMessage({required String message, bool markOnline = true}) {
    final currentState = state;
    if (currentState is! MessageStateSuccess) {
      return;
    }

    final newMessage = <String, dynamic>{
      'id': 'remote-${DateTime.now().millisecondsSinceEpoch}',
      'text': message,
      'isMine': false,
      'timestamp': DateTime.now(),
      'status': 'sent',
      'type': 'text',
    };

    emit(
      currentState.copyWith(
        contact: {
          ...currentState.contact,
          if (markOnline) 'isOnline': true,
          'lastSeen': DateTime.now(),
        },
        messages: List<Map<String, dynamic>>.from(currentState.messages)
          ..add(newMessage),
      ),
    );
  }
}

@freezed
sealed class MessageState with _$MessageState {
  const factory MessageState.loading() = MessageStateLoading;
  const factory MessageState.success({
    required Map<String, dynamic> contact,
    required List<Map<String, dynamic>> messages,
  }) = MessageStateSuccess;
  const factory MessageState.error({required String errorMessage}) =
      MessageStateError;
}
