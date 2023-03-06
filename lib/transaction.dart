import 'package:flutter/material.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  const TransactionItem({Key? key, required this.transaction})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${transaction.type == TransactionType.DEPOSIT ? '+' : '-'} ${transaction.amount}",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: transaction.type == TransactionType.DEPOSIT
                          ? Colors.green
                          : Colors.red),
                ),
                Text(
                  "${transaction.createdAt}",
                  style: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.w300),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(transaction.type == TransactionType.DEPOSIT
                ? Icons.arrow_circle_up
                : Icons.arrow_circle_down_outlined),
          )
        ],
      ),
    );
  }
}

class Transaction {
  String id;
  String accountId;
  double amount;
  String createdAt;
  TransactionType type;
  Transaction(
      {required this.accountId,
        required this.id,
        required this.createdAt,
        required this.amount,
        required this.type});
}

enum TransactionType { WITHDRAWAL, DEPOSIT }
