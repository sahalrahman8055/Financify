import 'package:Financify/model/add_data.dart';
import 'package:Financify/view/transaction/transactions_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
const transactionDBName = 'Transaction_database';

class TransactionDB extends ChangeNotifier {
  // there is no return type
  TransactionDB.internal();
 ////?????
  static TransactionDB instance = TransactionDB.internal();

  factory TransactionDB() {
    return instance;
  }
  ValueNotifier<List<Add_data>> transactionListNotifier = ValueNotifier([]);

  Future<void> getAllTransactions() async {
    final transactionDB = await Hive.openBox<Add_data>(transactionDBName);
    transactionListNotifier.value.clear();

    transactionListNotifier.value.addAll(transactionDB.values);

    transactionListNotifier.notifyListeners();
  }

  Future<void> addTransaction(Add_data obj) async {
    final transactionDB = await Hive.openBox<Add_data>(transactionDBName);
    await transactionDB.put(obj.id, obj);
    getAllTransactions();
  }// add vs put crud

  Future<void> deleteTransaction(Add_data transactionModel) async {
    final transactionDB = await Hive.openBox<Add_data>(transactionDBName);
    transactionDB.delete(transactionModel.id);
    overViewListNotifier.notifyListeners();
    getAllTransactions();
  }

  Future<void> editTransaction(Add_data value) async {
    final transactionDB = await Hive.openBox<Add_data>(transactionDBName);
    transactionDB.put(value.id, value);//??
    overViewListNotifier.notifyListeners();
    getAllTransactions();
  }
}



