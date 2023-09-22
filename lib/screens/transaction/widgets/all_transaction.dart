import 'package:financify/db_functions/income_expenses.dart';
import 'package:financify/db_functions/transaction_db.dart';
import 'package:financify/model/add_data.dart';
import 'package:financify/screens/transaction/slideble_transaction.dart';
import 'package:financify/widget/uppercase.dart';
import 'package:flutter/material.dart';

class AllTransaction extends StatelessWidget {
  AllTransaction({super.key});

  final List<String> day = [
    'Monday',
    "Tuesday",
    "Wednesday",
    "Thursday",
    'friday',
    'saturday',
    'sunday'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: TransactionDB.instance.transactionListNotifier,
            builder: (BuildContext ctx, List<Add_data> addedList, Widget? _) {
              return (addedList.isEmpty)
                  ? Column(
                      children: [
                        Center(
                            // child: Image.asset(
                            //   "photos/Empty Box.png",
                            //   fit: BoxFit.fill,
                            // ),
                            ),
                        const Center(
                          child: Text('No transactions added yet'),
                        ),
                      ],
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(5),
                      itemBuilder: (ctx, index) {
                        final int lastIndex = transactionDB.length - 1;
                        final int reversedIndex = lastIndex - index;
                        final value = addedList[reversedIndex];
                        return Column(
                          children: [
                            SlidebleTransaction(
                              transaction: value,
                              key: key,
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (ctx, index) {
                        return const Divider(
                          height: 4,
                          thickness: 2,
                        );
                      },
                      itemCount: addedList.length > 4 ? 4 : addedList.length,
                    );
            }),
      ),
    );
  }
}
