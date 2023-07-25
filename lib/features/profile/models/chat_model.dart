import 'dart:convert';

class ChatModel {
  String chatName;
  String sender;
  String receiver;
  String id;

  ChatModel({
    required this.chatName,
    required this.sender,
    required this.receiver,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'chatName': chatName,
      'sender': sender,
      'receiver': receiver,
      'id': id,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      chatName: map['chatName'] ?? '',
      sender: map['sender'] ?? '',
      receiver: map['receiver'] ?? '',
      id: map['_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source));
}
