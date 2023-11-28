import 'package:Financify/services/transaction_db.dart';
import 'package:Financify/view/statistics/Statistics_screen.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticsProvider extends ChangeNotifier {
    String dateFilterTitle = "All";
  late TooltipBehavior tooltipBehavior;

  StatisticsProvider() {
    tooltipBehavior = TooltipBehavior(enable: true);
    
   overViewGraphNotifier.value =
        TransactionDB.instance.transactionListNotifier.value; 
  }

  
}
