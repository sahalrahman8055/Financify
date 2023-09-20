import 'package:financify/db_functions/income_expenses.dart';
import 'package:financify/db_functions/transaction_db.dart';
import 'package:financify/model/add_data.dart';
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
                        return Card(
                          color: Colors.transparent,
                          elevation: 0,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 50,
                              child: Image.asset(
                                  'assets/images/${value.name}.png',
                                  height: 40),
                            ),
                            title: Text(
                              value.explain.capitalize(),
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              '${value.datetime.year}-${value.datetime.day}-${value.datetime.month}  ${day[value.datetime.weekday - 1]}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 13),
                            ),
                            trailing: Text(
                              '₹ ${value.amount}',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                                color: value.type == 'income'
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                          ),
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

  Widget getList(Add_data backupdata, int index) {
    return Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          backupdata.delete();
        },
        child: get(index, backupdata));
  }

  ListTile get(int index, Add_data backupdata) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.asset(
          'assets/images/${backupdata.name}.png',
          height: 40,
        ),
      ),
      title: Text(
        backupdata.name,
        style: TextStyle(
            fontWeight: FontWeight.w600, fontSize: 17, color: Colors.black54),
      ),
      subtitle: Text(
        '${day[backupdata.datetime.weekday - 1]}  ${backupdata.datetime.year}-${backupdata.datetime.day}-${backupdata.datetime.month}',
        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black54),
      ),
      trailing: Text(backupdata.amount,
          style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w600,
              color: backupdata.type == 'income'
                  ? Colors.green.shade300
                  : Colors.redAccent)),
    );
  }
}
