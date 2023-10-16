
import 'package:financify/db_functions/income_expenses.dart';
import 'package:financify/db_functions/transaction_db.dart';
import 'package:financify/model/add_data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

ValueNotifier<List<Add_data>> overViewGraphNotifier =
    ValueNotifier(TransactionDB.instance.transactionListNotifier.value);

class AllChart extends StatefulWidget {
   const AllChart({super.key});

  @override
  State<AllChart> createState() => _AllChart();
}

class _AllChart extends State<AllChart> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 246, 245, 245),
        //Color.fromARGB(255, 205, 204, 204),
        body: ValueListenableBuilder(
          valueListenable: overViewGraphNotifier,
          builder: (BuildContext context, List<Add_data> newList,
              Widget? child) {
            Map incomeMap = {
              'name': 'Income', "amount":  IncomeAndExpence().income(),
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
                    tooltipBehavior: _tooltipBehavior,
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
                    legend: Legend(
                      isVisible: true,
                      overflowMode: LegendItemOverflowMode.scroll,
                      alignment: ChartAlignment.center,
                    ),
                  );
          },
        ),
      ),
    );
  }
}