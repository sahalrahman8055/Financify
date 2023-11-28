import 'package:Financify/services/transaction_db.dart';
import 'package:Financify/model/add_data.dart';
import 'package:Financify/widget/slideble_transaction.dart';
import 'package:Financify/view/transaction/transaction_lists.dart';
import 'package:flutter/material.dart';

ValueNotifier<List<Add_data>> overViewListNotifier =
    ValueNotifier(TransactionDB.instance.transactionListNotifier.value);

class Transactions extends StatelessWidget {
  const Transactions({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final double screenHeight = size.height;
    TransactionDB().getAllTransactions();
    return ValueListenableBuilder(
        valueListenable: overViewListNotifier,
        builder: (BuildContext context, newList, Widget? _) {
          return ValueListenableBuilder(
              valueListenable: showCategory,
              builder: (context, showcategorylist, child) {
             
                var displayList = [];

                if (showCategory.value == 'income') {
                  
                  List<Add_data> incomeTransactionList = [];
                 
                  incomeTransactionList = newList
                      .where((element) => element.type == 'income')
                      .toList();
                 
                  displayList = incomeTransactionList;
                } else if (showCategory.value == "Expense") {
                  List<Add_data> expenseTransactionList = [];
                  expenseTransactionList = newList
                      .where((element) => element.type == 'expense')
                      .toList();
                  displayList = expenseTransactionList;
                } else {
                  displayList = newList;
                }

                return (displayList.isEmpty)
                    ? SingleChildScrollView(
                        child: Column(
                        children: [
                          SizedBox(height: screenHeight / 10),
                          const Center(
                            child: Text('No transactions added yet'),
                          ),
                        ],
                      ))
                    : ListView.separated(
                        padding: const EdgeInsets.all(5),
                        itemBuilder: (ctx, index) {
                          final transaction = displayList[index];
                          return SlidebleTransaction(transaction: transaction);
                        },
                        separatorBuilder: (ctx, index) {
                          return const Divider(
                            height: 5,
                            thickness: 5,
                          );
                        },
                        itemCount: displayList.length);
              });
        });
  }
}
