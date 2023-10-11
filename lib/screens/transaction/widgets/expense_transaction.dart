import 'package:financify/db_functions/transaction_db.dart';
import 'package:financify/model/add_data.dart';
import 'package:financify/screens/transaction/slideble_transaction.dart';

import 'package:flutter/material.dart';

class ExpenseTransaction extends StatelessWidget {
  ExpenseTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: TransactionDB.instance.transactionListNotifier,
      builder: (BuildContext ctx, List<Add_data> transactionList, Widget? _) {
        var expenseList = transactionList
            .where(
              (element) => element.type == 'expense',
            )
            .toList();
        return (expenseList.isEmpty)
            ? Center(child: Text('not yet'))
            : ListView.separated(
                padding: const EdgeInsets.all(5),
                itemBuilder: (ctx, index) {
                  if (index < expenseList.length) {
                    final value = expenseList.reversed.toList()[index];
                    return Column(
                      children: [
                        SlidebleTransaction(
                          transaction: value,
                          key: key,
                        ),
                      ],
                    );
                  } else {
                    return null; // Return a null widget for out-of-bounds indices
                  }
                },
                separatorBuilder: (ctx, index) {
                  return const Divider(
                    height: 4,
                    thickness: 2,
                  );
                },
                itemCount: expenseList.length, // Use the length of expenseList
              );
      },
    );
  }
}
