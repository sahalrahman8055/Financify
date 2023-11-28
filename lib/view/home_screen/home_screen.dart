import 'package:Financify/constants/borderredius.dart';
import 'package:Financify/constants/sizedbox.dart';
import 'package:Financify/controller/home_provider.dart';
import 'package:Financify/helper/colors.dart';
import 'package:Financify/services/income_expenses.dart';
import 'package:Financify/services/transaction_db.dart';
import 'package:Financify/model/add_data.dart';
import 'package:Financify/view/transaction/transaction_lists.dart';
import 'package:Financify/widget/uppercase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});



  @override
  Widget build(BuildContext context) {
    final daysprovider = Provider.of<HomeProvider>(context,listen: false);
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
                            color: kRgbBlackColors)),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const TransactionList()));
                      },
                      child: const Text('See all',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              color: kRgbBlackColors)),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color:kWhiteColor24,
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
                                    color: kTranparentColor,
                                    elevation: 0,
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: kTranparentColor,
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
                                        '${value.datetime.year}-${value.datetime.day}-${value.datetime.month}  ${daysprovider.day[value.datetime.weekday - 1]}',
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
                                              ? kGreenColor
                                              : kRedColor,
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
            decoration: const BoxDecoration(
              // color: Colors.greenAccent,
              color: kBlackColor,
              borderRadius: kRadius,
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 20,
                  left: 330,
                  child: ClipRRect(
                    borderRadius: kRadius7,
                    child: Container(
                        height: 35,
                        width: 35,
                        color:  kRgboColors,
                        child: const Icon(
                          Icons.notification_add_outlined,
                          size: 25,
                          color: kWhiteColor,
                        )),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 30, left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Make your money safe",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: kGreyColor),
                      ),
                      Text(
                        " ' Track it ' ",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: kWhiteColor),
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
          padding: const EdgeInsets.only(top: 120),
          child: Container(
            height: 160,
            width: 330,
            decoration: BoxDecoration(
              // color: Color.fromARGB(255, 196, 196, 196),
              color: kWhiteColor,
              borderRadius: kRadius15,
              boxShadow: [
                BoxShadow(
                  color: kGreyColor
                      .withOpacity(0.5), // You can customize the shadow color
                  spreadRadius: 5, // Adjust the spread radius for the shadow
                  blurRadius: 7, // Adjust the blur radius for the shadow
                  offset: const Offset(
                      0, 3), // Offset of the shadow from the container
                ),
              ],
            ),
            child: Column(
              children: [
               kHeight10,
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'total balance',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: kBlackColor54,
                        ),
                      ),
                      Icon(
                        Icons.more_horiz,
                        color: kBlackColor,
                      )
                    ],
                  ),
                ),
               kHeight7,
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Text(
                        '₹ ${IncomeAndExpence().total()}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: kBlackColor,
                        ),
                      ),
                    ],
                  ),
                ),
               kHeight25,
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: kBlackColor,
                            child: Icon(
                              Icons.arrow_downward,
                              size: 19,
                              // color: Colors.red,
                            ),
                          ),
                          kwidtht7,
                          Text(
                            'Income',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: kBlackColor54,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: kBlackColor,
                            child: Icon(
                              Icons.arrow_upward,
                              size: 19,
                              // color: Colors.greenAccent,
                            ),
                          ),
                         kwidtht7,
                          Text(
                            'Expenses',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: kBlackColor54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              kHeight7,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₹ ${IncomeAndExpence().income()}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: kBlackColor,
                        ),
                      ),
                      Text(
                        '₹ ${IncomeAndExpence().expense()}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: kBlackColor,
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
