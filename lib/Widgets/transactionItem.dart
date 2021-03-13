import 'package:MoneyTracker/Models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.delete,
  }) : super(key: key);

  final Transaction transaction;
  final Function delete;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[350],
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        leading: CircleAvatar(
          backgroundColor:
              transaction.type == 'Expense' ? Colors.red : Colors.green,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                '৳${transaction.amount}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue[900],
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              transaction.type,
              style: TextStyle(
                fontSize: 14,
                color:
                    transaction.type == 'Expense' ? Colors.red : Colors.green,
              ),
            ),
            Text(
              DateFormat('E, MMM d, y').format(transaction.date),
              style: TextStyle(
                fontSize: 14,
                color: Colors.black38,
              ),
            ),
          ],
        ),
        trailing: MediaQuery.of(context).size.width > 400
            ? FlatButton.icon(
                onPressed: () => delete(transaction.trans_id),
                textColor: Colors.redAccent,
                icon: Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                  size: 32,
                ),
                label: Text('Delete'),
              )
            : IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                  size: 32,
                ),
                onPressed: () => delete(transaction.trans_id),
              ),
      ),
    );
  }
}
