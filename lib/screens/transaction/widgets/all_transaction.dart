import 'package:financify/data/model/add_data.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AllTransaction extends StatelessWidget {
  AllTransaction({super.key});
  final box = Hive.box<Add_data>('data');
  var backupdata;
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
        valueListenable: box.listenable(),
        builder: (context, value, child) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    backupdata = box.values.toList().reversed.toList()[index];
                    return getList(backupdata, index);
                  },
                  childCount: box.length,
                ),
              )
            ],
          );
        },
      )),
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
              color: backupdata.IN == 'income'
                  ? Colors.green.shade300
                  : Colors.redAccent)),
    );
  }
}
