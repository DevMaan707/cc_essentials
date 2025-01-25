import '../utils/uuid.dart';

enum MessageType { bot, user }

enum MessageContentType { text, image, file }

enum MessageStatus { sent, delivered, read, error }

class ChatMessage {
  final String id;
  final String message;
  final MessageType type;
  final MessageContentType contentType;
  final MessageStatus status;
  final DateTime timestamp;
  final String? mediaUrl;
  final Map<String, dynamic>? metadata;

  ChatMessage({
    String? id,
    required this.message,
    required this.type,
    this.contentType = MessageContentType.text,
    this.status = MessageStatus.sent,
    DateTime? timestamp,
    this.mediaUrl,
    this.metadata,
  })  : id = id ?? UUID.generate(),
        timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'id': id,
        'message': message,
        'type': type.toString(),
        'contentType': contentType.toString(),
        'status': status.toString(),
        'timestamp': timestamp.toIso8601String(),
        'mediaUrl': mediaUrl,
        'metadata': metadata,
      };

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        id: json['id'],
        message: json['message'],
        type:
            MessageType.values.firstWhere((e) => e.toString() == json['type']),
        contentType: MessageContentType.values
            .firstWhere((e) => e.toString() == json['contentType']),
        status: MessageStatus.values
            .firstWhere((e) => e.toString() == json['status']),
        timestamp: DateTime.parse(json['timestamp']),
        mediaUrl: json['mediaUrl'],
        metadata: json['metadata'],
      );
}
