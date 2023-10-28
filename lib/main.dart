import 'package:Financify/db_functions/transaction_db.dart';
import 'package:Financify/model/add_data.dart';

import 'package:Financify/screens/start_screen/Splash.dart';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

const saveKeyName = 'User logged in';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(AdddataAdapter().typeId)) {
    Hive.registerAdapter(AdddataAdapter());
  }

  await Hive.openBox<Add_data>(transactionDBName);

  runApp(const MyApp());
  TransactionDB().getAllTransactions();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}
