import 'package:Financify/controller/add_screen-provider.dart';
import 'package:Financify/controller/bottomnavigation_provider.dart';
import 'package:Financify/controller/edit_provider.dart';
import 'package:Financify/controller/home_provider.dart';
import 'package:Financify/controller/search_provider.dart';
import 'package:Financify/controller/slideble_provider.dart';
import 'package:Financify/controller/splash_provider.dart';
import 'package:Financify/controller/statistics_provider.dart';
import 'package:Financify/controller/transaction_provider.dart';
import 'package:Financify/services/transaction_db.dart';
import 'package:Financify/model/add_data.dart';
import 'package:Financify/view/start_screen/Splash.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => StatisticsProvider(),
        ),
        ChangeNotifierProvider(create: (context) => SplashScreenModel(context)),
        ChangeNotifierProvider(create: (context) => TransactionProvider()),
        ChangeNotifierProvider(create: (context) => BottomProvider()),
        ChangeNotifierProvider(create: (context) => EditTransactionProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
        ChangeNotifierProvider(create: (context) => SlidebleProvider()),

      ],
      child: const MaterialApp(
          debugShowCheckedModeBanner: false, home: SplashScreen()),
    );
  }
}
