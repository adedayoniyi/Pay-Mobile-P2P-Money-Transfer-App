// To parse this JSON data, do
//
//     final transactions = transactionsFromJson(jsonString);

import 'dart:convert';

List<Transactions> transactionsFromJson(String str) => List<Transactions>.from(
    json.decode(str).map((x) => Transactions.fromJson(x)));

String transactionsToJson(List<Transactions> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Transactions {
  Transactions({
    required this.trnxType,
    required this.purpose,
    required this.amount,
    required this.username,
    required this.reference,
    required this.balanceBefore,
    required this.balanceAfter,
    required this.description,
    required this.fullNameTransactionEntity,
    required this.createdAt,
    required this.updatedAt,
  });

  String trnxType;
  String purpose;
  int amount;
  String username;
  String reference;
  int balanceBefore;
  int balanceAfter;
  String fullNameTransactionEntity;
  String description;
  DateTime createdAt;
  DateTime updatedAt;

  factory Transactions.fromJson(Map<String, dynamic> json) => Transactions(
        trnxType: json["trnxType"],
        purpose: json["purpose"],
        amount: json["amount"],
        username: json["username"],
        reference: json["reference"],
        balanceBefore: json["balanceBefore"],
        balanceAfter: json["balanceAfter"],
        fullNameTransactionEntity: json["fullNameTransactionEntity"],
        description: json["description"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "trnxType": trnxType,
        "purpose": purpose,
        "amount": amount,
        "username": username,
        "reference": reference,
        "balanceBefore": balanceBefore,
        "balanceAfter": balanceAfter,
        "fullNameTransactionEntity": fullNameTransactionEntity,
        "description": description,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
