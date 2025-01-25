import 'package:get_storage/get_storage.dart';
import '../models/chat_message.dart';

class ChatStorageService {
  final GetStorage _storage = GetStorage();
  final String _key = 'chat_messages';

  Future<void> saveMessages(List<ChatMessage> messages) async {
    final jsonMessages = messages.map((m) => m.toJson()).toList();
    await _storage.write(_key, jsonMessages);
  }

  Future<List<ChatMessage>> loadMessages() async {
    final jsonMessages = await _storage.read(_key);
    if (jsonMessages == null) return [];
    return (jsonMessages as List).map((m) => ChatMessage.fromJson(m)).toList();
  }

  Future<void> clearMessages() async {
    await _storage.remove(_key);
  }
}
