import 'package:Financify/services/transaction_db.dart';
import 'package:Financify/model/add_data.dart';
import 'package:hive/hive.dart';

int totals = 0;

final transactionDB = Hive.box<Add_data>(transactionDBName);


class IncomeAndExpence {
  int total() {
    var backup2 = transactionDB.values.toList();
    List a = [0, 0];
    for (var i = 0; i < backup2.length; i++) {
      a.add(backup2[i].type == 'income'
          ? int.parse(backup2[i].amount)
          : int.parse(backup2[i].amount) * -1);
    } 
    totals = a.reduce((value, element) => value + element);
    return totals;
  }

  int income() {
    var backup2 = transactionDB.values.toList();
    List a = [0, 0];
    for (var i = 0; i < backup2.length; i++) {
      a.add(backup2[i].type == 'income' ? int.parse(backup2[i].amount) : 0);
    }
    totals = a.reduce((value, element) => value + element);
    return totals;
  }

  int expense() {
    var backup2 = transactionDB.values.toList();
    List a = [0, 0];
    for (var i = 0; i < backup2.length; i++) {
      a.add(backup2[i].type == 'income' ? 0 : int.parse(backup2[i].amount));
    }
    totals = a.reduce((value, element) => value + element);
    return totals;
  } 
}
