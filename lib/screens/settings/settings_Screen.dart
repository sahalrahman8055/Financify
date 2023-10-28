import 'package:Financify/db_functions/transaction_db.dart';
import 'package:Financify/model/add_data.dart';
import 'package:Financify/screens/settings/Privacy_Policy.dart';
import 'package:Financify/screens/settings/Terms&Conditions.dart';
import 'package:Financify/screens/settings/about.dart';
import 'package:Financify/screens/start_screen/Login.dart';
import 'package:Financify/screens/start_screen/Splash.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('settings',
            style: GoogleFonts.ubuntu(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const About()),
                );
              },
              child: Container(
                child: const Row(
                  children: [
                    Icon(
                      Icons.warning_amber_outlined,
                      size: 30,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      "About",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                resetApp(context);
                usernameController.clear();
              },
              child: Container(
                child: const Row(
                  children: [
                    Icon(
                      Icons.restore,
                      size: 30,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      "Reset",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const PrivacyPolicy()));
              },
              child: Container(
                child: const Row(
                  children: [
                    Icon(
                      Icons.policy,
                      size: 30,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      "Privacy Policy",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const Terms()));
              },
              child: Container(
                child: const Row(
                  children: [
                    Icon(
                      Icons.note_add,
                      size: 30,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      "terms and conditions",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      )),
    );
  }

  resetApp(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            content: const Text(
              'Do you want to Reset the app?',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            actions: [
              TextButton(
                  onPressed: (() async {
                    Navigator.of(context).pop();

                    // final categoryDB =
                    //     await Hive.openBox<CategoryModel>(categoryDBName);

                    // categoryDB.clear();

                    final transactionDb =
                        await Hive.openBox<Add_data>(transactionDBName);

                    transactionDb.clear();

                    TransactionDB().transactionListNotifier.value.clear();
                    TransactionDB().transactionListNotifier.notifyListeners();

                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const SplashScreen(),
                      ),
                    );

                    // CategoryDB().categoryNotifier.notifyListeners();
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    await pref.clear();
                  }),
                  child: const Text(
                    'Yes',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  )),
              TextButton(
                onPressed: (() {
                  Navigator.of(context).pop();
                }),
                child: const Text(
                  'No',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
          );
       });
  }
}
