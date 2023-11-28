import 'package:Financify/model/add_data.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  List<Add_data> allValue = [];

  final List<String> day = [
    'Monday',
    "Tuesday",
    "Wednesday",
    "Thursday",
    'friday',
    'saturday',
    'sunday'
  ];

  @override
  notifyListeners();
}
