
import 'package:Financify/helper/colors.dart';
import 'package:Financify/model/add_data.dart';
import 'package:Financify/view/statistics/Statistics_screen.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class IncomeChart extends StatelessWidget {
  const IncomeChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kRgbwhiteColors,
        body: ValueListenableBuilder(
          valueListenable: overViewGraphNotifier,
          builder: (BuildContext context, List<Add_data> newList,
              Widget? child) {
            var allIncome = newList
                .where((element) => element.type == 'income')
                .toList();
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
                    series: <CircularSeries>[
                      PieSeries<Add_data, String>(
                        dataSource: allIncome,
                        xValueMapper: (Add_data incomeDate, _) =>
                            incomeDate.name,
                        yValueMapper: (Add_data incomeDate, _) =>
                            int.parse(incomeDate.amount),
                        //num.parse(incomeDate.amount),
                        //incomeDate.hashCode,
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
          },
        ),
      ),
    );
  }
}