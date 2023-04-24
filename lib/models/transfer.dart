import 'dart:convert';

class Transfer {
  final String fromUsername;
  final String toUsername;
  final int amount;
  final String summary;
  Transfer({
    required this.fromUsername,
    required this.toUsername,
    required this.amount,
    required this.summary,
  });

  Map<String, dynamic> toMap() {
    return {
      'fromUsername': fromUsername,
      'toUsername': toUsername,
      'amount': amount,
      'summary': summary,
    };
  }

  factory Transfer.fromMap(Map<String, dynamic> map) {
    return Transfer(
      fromUsername: map['fromUsername'] ?? '',
      toUsername: map['toUsername'] ?? '',
      amount: map['amount']?.toInt() ?? 0,
      summary: map['summary'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Transfer.fromJson(String source) =>
      Transfer.fromMap(json.decode(source));
}
