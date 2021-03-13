import 'package:MoneyTracker/Models/transaction.dart';
import 'package:MoneyTracker/Widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double expended = 0;
      double earned = 0;
      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekDay.day &&
            recentTransaction[i].date.month == weekDay.month &&
            recentTransaction[i].date.year == weekDay.year) {
          if (recentTransaction[i].type == 'Expense')
            expended += recentTransaction[i].amount;
          else
            earned += recentTransaction[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay),
        'Expended': expended,
        'Earned': earned,
      };
    }).reversed.toList();
  }

  double get totalExpense {
    return groupedTransactionValues.fold(0.0, (total, item) {
      return total + item['Expended'];
    });
  }

  double get totalEarned {
    return groupedTransactionValues.fold(0.0, (total, item) {
      return total + item['Earned'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        //padding: EdgeInsets.symmetric(h5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                e['Earned'],
                e['day'],
                e['Expended'],
                totalExpense == 0
                    ? 0.0
                    : (e['Expended'] as double) / totalExpense,
                totalEarned == 0 ? 0.0 : (e['Earned'] as double) / totalEarned,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
