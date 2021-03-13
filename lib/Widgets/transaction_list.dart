import 'package:MoneyTracker/Models/transaction.dart';
import 'package:flutter/material.dart';

import './transactionItem.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function delete;
  TransactionList(this.transaction, this.delete);
  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
        ? LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Column(
                children: [
                  Container(
                    height: constraints.maxHeight * 0.2,
                    alignment: Alignment.center,
                    child: Card(
                      color: Colors.white70,
                      elevation: 0,
                      child: const Text(
                        'No Transactions Yet',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    height: constraints.maxHeight * 0.8,
                    child: Image.asset(
                      'assets/images/pappu.jpg',
                      alignment: Alignment.center,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView(
            children: transaction.map((e) {
              return TransactionItem(
                key: ValueKey(e.trans_id),
                transaction: e,
                delete: delete,
              );
            }).toList(),
          );
  }
}
