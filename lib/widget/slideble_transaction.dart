import 'package:Financify/db_functions/transaction_db.dart';
import 'package:Financify/model/add_data.dart';
import 'package:Financify/widget/edit_transaction.dart';
import 'package:Financify/widget/uppercase.dart';
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
          onPressed: ((context) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) {
                  return EditTransaction(obj: transaction);
                }),
              ),
            );
          }),
          icon: Icons.edit,
          foregroundColor: const Color(0xFF2E49FB),
        ),
        SlidableAction(
          // onPressed: ((context) async {
          //    TransactionDB().deleteTransaction(transaction);
          // }),
          onPressed: (_) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Delete Transaction'),
                content: const Text(
                    'Are you sure you want to delete this transaction?'),
                actions: [
                  //CANCEL BUTTON
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),

                  //DELETE BUTTON
                  TextButton(
                      onPressed: () async {
                        //post delete
                        TransactionDB().deleteTransaction(transaction);

                        //dismiss the dialoge
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Delete",
                        style: TextStyle(color: Colors.red),
                      ))
                ],
              ),
            );
          },
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
            '₹ ${transaction.amount}',
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
