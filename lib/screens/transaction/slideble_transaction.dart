import 'package:financify/db_functions/transaction_db.dart';
import 'package:financify/model/add_data.dart';
import 'package:financify/widget/uppercase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidebleTransaction extends StatelessWidget {
  SlidebleTransaction({super.key, required this.transaction});

  final List<String> days = ['mon', 'tue', 'wed', 'thur', 'fri', 'sat', 'sun'];
  final Add_data transaction;
  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: const StretchMotion(), children: [
        SlidableAction(
          onPressed: ((context) async {
            await TransactionDB().deleteTransaction(transaction);
          }),
          icon: Icons.delete,
          foregroundColor: Colors.red,
        ),
      ]),
      child: Card(
        color: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          //<-- SEE HERE
          // side: BorderSide(width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset('assets/images/${transaction.name}.png',
                height: 40),
          ),
          title: Text(
            transaction.explain.capitalize(),
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            '${transaction.datetime.year}-${transaction.datetime.day}-${transaction.datetime.month}  ${days[transaction.datetime.weekday - 1]}',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
          trailing: Text(
            transaction.amount,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 19,
              color: transaction.type == 'income' ? Colors.green : Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
