import 'package:financify/data/model/add_data.dart';
import 'package:financify/data/utility.dart';
import 'package:financify/screens/transaction/transaction_lists.dart';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class home_screen extends StatefulWidget {
  const home_screen({super.key});

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  var backupdata;
  final box = Hive.box<Add_data>('data');
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
    final size = MediaQuery.of(context).size;
    double screenWidth = size.width;
    double screenHeight = size.height;
    return Scaffold(
      body: SafeArea(
          child: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, value, child) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(height: 355, child: _head()),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Transaction history',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 19,
                            color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TransactionList(),
                            ),
                          );
                        },
                        child: Text(
                          'See all',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 19,
                              color: Colors.black54),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                backupdata = box.values.toList().reversed.toList()[index];
                return getList(backupdata, index);
              }, childCount: box.length > 4 ? 4 : box.length))
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

  Widget _head() {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              height: 240,
              decoration: BoxDecoration(
                // color: Colors.greenAccent,
                color: Colors.black,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 20,
                    left: 330,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: Container(
                          height: 35,
                          width: 35,
                          color: Color.fromRGBO(250, 250, 250, 0.2),
                          child: Icon(
                            Icons.notification_add_outlined,
                            size: 25,
                            color: Colors.white,
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "good afternoon",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.grey),
                        ),
                        Text(
                          "good afternoon",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.only(top: 120),
            child: Container(
              height: 160,
              width: 330,
              decoration: BoxDecoration(
                // color: Color.fromARGB(255, 196, 196, 196),
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey
                        .withOpacity(0.5), // You can customize the shadow color
                    spreadRadius: 5, // Adjust the spread radius for the shadow
                    blurRadius: 7, // Adjust the blur radius for the shadow
                    offset:
                        Offset(0, 3), // Offset of the shadow from the container
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'total balance',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.black54,
                          ),
                        ),
                        Icon(
                          Icons.more_horiz,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 7),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        Text(
                          '\₹ ${IncomeAndExpence().total()}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 12,
                              backgroundColor: Colors.black,
                              child: Icon(
                                Icons.arrow_downward,
                                size: 19,
                                // color: Colors.red,
                              ),
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              'Income',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 12,
                              backgroundColor: Colors.black,
                              child: Icon(
                                Icons.arrow_upward,
                                size: 19,
                                // color: Colors.greenAccent,
                              ),
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              'Expenses',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\₹ ${IncomeAndExpence().income()}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '\₹ ${IncomeAndExpence().expense()}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
