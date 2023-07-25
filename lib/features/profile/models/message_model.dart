
import 'dart:convert';

List<MessageModel> messageModelFromJson(String str) => List<MessageModel>.from(
    json.decode(str).map((x) => MessageModel.fromJson(x)));

String messageModelToJson(List<MessageModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MessageModel {
  String id;
  String sender;
  String content;
  String receiver;
  String chat;
  List<dynamic> readBy;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  MessageModel({
    required this.id,
    required this.sender,
    required this.content,
    required this.receiver,
    required this.chat,
    required this.readBy,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        id: json["_id"],
        sender: json["sender"],
        content: json["content"],
        receiver: json["receiver"],
        chat: json["chat"],
        readBy: List<dynamic>.from(json["readBy"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "sender": sender,
        "content": content,
        "receiver": receiver,
        "chat": chat,
        "readBy": List<dynamic>.from(readBy.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
