import 'package:Financify/constants/sizedbox.dart';
import 'package:Financify/controller/statistics_provider.dart';
import 'package:Financify/helper/colors.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:Financify/services/transaction_db.dart';
import 'package:Financify/model/add_data.dart';
import 'package:Financify/view/statistics/statistics_all.dart';
import 'package:Financify/view/statistics/statistics_expense.dart';
import 'package:Financify/view/statistics/statistics_income.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

ValueNotifier<List<Add_data>> overViewGraphNotifier =
    ValueNotifier(TransactionDB.instance.transactionListNotifier.value);

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StatisticsProvider(),
      child: Consumer<StatisticsProvider>(
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: kRgbwhiteColors,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: kBlackColor,
              title: Text("Statistics",
                  style: GoogleFonts.ubuntu(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            body: Column(
              children: [
           kHeight30,
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
                            backgroundColor: kBlackColor,
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
        },
      ),
    );
  }
}
