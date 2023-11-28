import 'package:Financify/view/home_screen/home_screen.dart';
import 'package:Financify/view/settings/settings_Screen.dart';
import 'package:Financify/view/statistics/Statistics_screen.dart';
import 'package:Financify/view/transaction/transaction_lists.dart';
import 'package:flutter/material.dart';

class BottomProvider extends ChangeNotifier {

  BottomProvider();
  List screens = [
    const HomeScreen(),
    const StatisticsScreen(),
    const TransactionList(),
    const Settings(),
  ];

  int indexColor = 0;

  // get indexColor => _indexColor; // Set the default index to 0

  void indexColors(int newIndexColor) {
    indexColor = newIndexColor;
    notifyListeners();
  }

  Future function() async{
    indexColor == 0;
  }
}
