import 'package:flutter/material.dart';

class EditTransactionProvider extends ChangeNotifier{

    DateTime? selectedDateTime;
  String? selectedtype;
  // ignore: unused_field
  String? selectedCategory;
  // CategoryModel? _selectedCategoryModel;
  //String? _categoryID;
  // ignore: unused_field
  int value = 0;
  TextEditingController amountTextEditingController = TextEditingController();
  TextEditingController explainTextEditingController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final List<String> iteminex = ['income', 'expense'];

  final List<String> item = [
    'food',
    "Transfer",
    "Transportation",
    "Education"
  ];


  DateTime date = DateTime.now();


    void editDate(DateTime newDate) {
    date = newDate;
    notifyListeners();
  }

  void editselectedType (String value){
       selectedtype = value;
  }
  void editcategory (String value){
     selectedCategory = value;
  }
  
}