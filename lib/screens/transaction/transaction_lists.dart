import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:financify/db_functions/transaction_db.dart';
import 'package:financify/screens/addscreen/add_screen.dart';
import 'package:financify/screens/transaction/widgets/all_transaction.dart';
import 'package:financify/screens/transaction/widgets/expense_transaction.dart';
import 'package:financify/screens/transaction/widgets/income_transaction.dart';
import 'package:financify/widget/bottomnavigationbar.dart';
import 'package:financify/widget/searchfield.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class TransactionList extends StatefulWidget {
  TransactionList({
    super.key,
  });

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    overViewListNotifier.value =
        TransactionDB.instance.transactionListNotifier.value;
    super.initState();
  }

  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => BottomBar()));
              },
              child: Icon(Icons.arrow_back_outlined)),
          title: Center(
              child: Text('Transaction History',
                  style: GoogleFonts.ubuntu(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ))),
        ),
        body: Container(
          child: Column(
            children: [
              SearchField(),
              SizedBox(
                height: size.height * 0.03,
              ),
              Expanded(
                  child: DefaultTabController(
                      length: 3,
                      initialIndex: 0,
                      child: Column(
                        children: <Widget>[
                          ButtonsTabBar(
                              backgroundColor: Colors.black,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.1),
                              tabs: const [
                                Tab(
                                  iconMargin: EdgeInsets.all(30),
                                  text: 'All',
                                ),
                                Tab(
                                  text: "Income",
                                ),
                                Tab(
                                  text: "Expense",
                                ),
                              ]),
                          Expanded(
                              child: TabBarView(children: [
                            AllTransaction(),
                            IncomeTransaction(),
                            ExpenseTransaction()
                          ]))
                        ],
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
