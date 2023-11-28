import 'package:Financify/services/transaction_db.dart';
import 'package:Financify/view/transaction/transactions_screen.dart';
import 'package:flutter/material.dart';

class TransactionProvider extends ChangeNotifier{

  transactionProvider(){
     overViewListNotifier.value =
        TransactionDB.instance.transactionListNotifier.value;
  }
}