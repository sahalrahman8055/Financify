import 'package:Financify/constants/borderredius.dart';
import 'package:Financify/controller/slideble_provider.dart';
import 'package:Financify/helper/colors.dart';
import 'package:Financify/services/transaction_db.dart';
import 'package:Financify/model/add_data.dart';
import 'package:Financify/widget/edit_transaction.dart';
import 'package:Financify/widget/uppercase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class SlidebleTransaction extends StatelessWidget {
  const SlidebleTransaction({super.key, required this.transaction});

  final Add_data transaction;
  @override
  Widget build(BuildContext context) {
    final DaysProvider = Provider.of<SlidebleProvider>(context, listen: false);
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
          foregroundColor:  kRgbblueColors,
        ),
        SlidableAction(
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
                      style: TextStyle(color: kRedColor),
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
                        style: TextStyle(color: kRedColor),
                      ))
                ],
              ),
            );
          },
          icon: Icons.delete,
          foregroundColor: kRedColor,
        ),
      ]),
      child: Card(
        color: kWhiteColor,
        elevation: 3,
        shape: RoundedRectangleBorder(
          //<-- SEE HERE
          // side: BorderSide(width: 1),
          borderRadius: kRadius20,
        ),
        child: ListTile(
          leading: ClipRRect(
            borderRadius:kRadius5,
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
            '${transaction.datetime.year}-${transaction.datetime.day}-${transaction.datetime.month}  ${DaysProvider.days[transaction.datetime.weekday - 1]}',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
          trailing: Text(
            '₹ ${transaction.amount}',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 19,
              color: transaction.type == 'income' ? kGreenColor : kRedColor,
            ),
          ),
        ),
      ),
    );
  }
}
