import 'package:Financify/controller/statistics_provider.dart';
import 'package:Financify/helper/colors.dart';
import 'package:Financify/services/income_expenses.dart';
import 'package:Financify/services/transaction_db.dart';
import 'package:Financify/model/add_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

ValueNotifier<List<Add_data>> overViewGraphNotifier =
    ValueNotifier(TransactionDB.instance.transactionListNotifier.value);

class AllChart extends StatelessWidget {
  const AllChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:  kRgbwhiteColors,
        //Color.fromARGB(255, 205, 204, 204),
        // valueListenable: overViewGraphNotifier,
        // builder: (BuildContext context, List<Add_data> newList,
        //     Widget? child) {
        body: Consumer<StatisticsProvider>(
            builder: (context, staticProvider, child) {
          Map incomeMap = {
            'name': 'Income', "amount": IncomeAndExpence().income(),
            // income()
            // incomeTotal.value
          };
          Map expenseMap = {
            "name": "Expense", "amount": IncomeAndExpence().expense()
            //expenseTotal.value
          };
          List<Map> totalMap = [incomeMap, expenseMap];
          //List<Map> totalMap = [incomeMap, expenseMap];
          return overViewGraphNotifier.value.isEmpty
              ? const SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Center(child: Text('No data Found')),
                      ],
                    ),
                  ),
                )
              : SfCircularChart(
                  tooltipBehavior: staticProvider.tooltipBehavior,
                  series: <CircularSeries>[
                    PieSeries<Map, String>(
                      dataSource: totalMap,
                      xValueMapper: (Map data, _) => data['name'],
                      yValueMapper: (Map data, _) => data['amount'],
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                      ),
                    )
                  ],
                  legend: const Legend(
                    isVisible: true,
                    overflowMode: LegendItemOverflowMode.scroll,
                    alignment: ChartAlignment.center,
                  ),
                );
        }),
      ),
    );
  }
}
