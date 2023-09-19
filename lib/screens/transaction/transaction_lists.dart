import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:financify/screens/transaction/widgets/all_transaction.dart';
import 'package:financify/screens/transaction/widgets/expense_transaction.dart';
import 'package:financify/screens/transaction/widgets/income_transaction.dart';
import 'package:financify/widget/bottomnavigationbar.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class TransactionList extends StatelessWidget {
  TransactionList({
    super.key,
  });

  TextEditingController searchController = TextEditingController();

  @override
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
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          ],
        ),
        body: Container(
          child: Column(
            children: [
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
