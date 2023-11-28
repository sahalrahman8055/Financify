import 'package:flutter/material.dart';

class AddScreenProvider extends ChangeNotifier {
  final TextEditingController explainController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  FocusNode amount_ = FocusNode();
  DateTime date = DateTime.now();
  FocusNode ex = FocusNode();
  String? selectedCatogary;

  String? selectedType;



  void updateDate(DateTime newDate) {
    date = newDate;
    notifyListeners();
  }

  final List<String> item = ['food', "Transfer", "Transportation", "Education"];

  final List<String> itemei = [
    'income',
    'expense',
  ];

  void updateSelectedType(String value) {
    selectedType = value;
    notifyListeners();
  }

  void updateCtogary(String value) {
    selectedCatogary = value;
    notifyListeners();
  }
}
