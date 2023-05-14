import 'dart:convert';

class Transfer {
  final String sendersUsername;
  final String recipientsUsername;
  final int amount;
  final String description;
  Transfer({
    required this.sendersUsername,
    required this.recipientsUsername,
    required this.amount,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'sendersUsername': sendersUsername,
      'recipientsUsername': recipientsUsername,
      'amount': amount,
      'description': description,
    };
  }

  factory Transfer.fromMap(Map<String, dynamic> map) {
    return Transfer(
      sendersUsername: map['sendersUsername'] ?? '',
      recipientsUsername: map['recipientsUsername'] ?? '',
      amount: map['amount']?.toInt() ?? 0,
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Transfer.fromJson(String source) =>
      Transfer.fromMap(json.decode(source));
}
