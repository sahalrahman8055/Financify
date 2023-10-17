import 'package:buttons_tabbar/buttons_tabbar.dart';

import 'package:financify/db_functions/transaction_db.dart';
import 'package:financify/model/add_data.dart';
import 'package:financify/screens/statistics/statistics_all.dart';
import 'package:financify/screens/statistics/statistics_expense.dart';
import 'package:financify/screens/statistics/statistics_income.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ValueNotifier<List<Add_data>> overViewGraphNotifier =
    ValueNotifier(TransactionDB.instance.transactionListNotifier.value);

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _TransactionInsightsAllState();
}

class _TransactionInsightsAllState extends State<StatisticsScreen> {
  String dateFilterTitle = "All";

  @override
  void initState() {
    super.initState();
    overViewGraphNotifier.value =
        TransactionDB.instance.transactionListNotifier.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 245, 245),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text("Statistics",
            style: GoogleFonts.ubuntu(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: DefaultTabController(
              length: 3,
              initialIndex: 0,
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    // transformAlignment: Alignment.center,

                    width: double.infinity,
                    child: ButtonsTabBar(
                      backgroundColor: Colors.black,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 40),
                      tabs: const [
                        Tab(
                          iconMargin: EdgeInsets.all(30),
                          text: 'All',
                        ),
                        Tab(
                          text: 'Income',
                        ),
                        Tab(
                          text: 'Expense',
                        ),
                      ],
                    ),
                  ),
                  const Expanded(
                      child: TabBarView(children: [
                    AllChart(),
                    IncomeChart(),
                    ExpenseChart(),
                  ]))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
