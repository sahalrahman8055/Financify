import 'package:financify/db_functions/income_expenses.dart';
import 'package:financify/db_functions/transaction_db.dart';
import 'package:financify/model/add_data.dart';
import 'package:financify/screens/transaction/transaction_lists.dart';
import 'package:financify/screens/transaction/transactions_screen.dart';
import 'package:financify/widget/uppercase.dart';

import 'package:flutter/material.dart';

class home_screen extends StatefulWidget {
  const home_screen({super.key});

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
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
    final size = MediaQuery.of(context).size;
    double screenWidth = size.width;
    double screenHeight = size.height;
    return Scaffold(
      body: SafeArea(
          child: ValueListenableBuilder(
        valueListenable: TransactionDB.instance.transactionListNotifier,
        builder: (context, value, index) {
          return Column(
            children: [
              SizedBox(
                  height: screenHeight * .44,
                  width: screenWidth,
                  child: _head()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Recent Transactions',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                            color: Color.fromARGB(255, 15, 14, 14))),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Transactions()));
                      },
                      child: const Text('See all',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              color: Color.fromARGB(255, 15, 14, 14))),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white24,
                  height: 300,
                  child: ValueListenableBuilder(
                      valueListenable:
                          TransactionDB.instance.transactionListNotifier,
                      builder: (BuildContext ctx, List<Add_data> addedList,
                          Widget? _) {
                        return (addedList.isEmpty)
                            ? Column(
                                children: [
                                  SizedBox(height: screenHeight / 14),
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
                                  final int lastIndex =
                                      transactionDB.length - 1;
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
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13),
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
                                itemCount:
                                    addedList.length > 4 ? 4 : addedList.length,
                              );
                      }),
                ),
              ),
            ],
          );
        },
      )),
    );
  }
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
                        "Make your money safe",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.grey),
                      ),
                      Text(
                        " ' Track it ' ",
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
