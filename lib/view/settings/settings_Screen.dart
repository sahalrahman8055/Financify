import 'package:Financify/constants/sizedbox.dart';
import 'package:Financify/helper/colors.dart';
import 'package:Financify/services/transaction_db.dart';
import 'package:Financify/model/add_data.dart';
import 'package:Financify/view/settings/Privacy_Policy.dart';
import 'package:Financify/view/settings/Terms&Conditions.dart';
import 'package:Financify/view/settings/about.dart';
import 'package:Financify/view/start_screen/Login.dart';
import 'package:Financify/view/start_screen/Splash.dart';
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
        backgroundColor: kBlackColor,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          children: [
            kHeight30,
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
                   kHeight30,
                    Text(
                      "About",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
           kHeight30,
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
                   kHeight30,
                    Text(
                      "Reset",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
           kHeight30,
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
                   kHeight30,
                    Text(
                      "Privacy Policy",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
           kHeight30,
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
                   kHeight30,
                    Text(
                      "terms and conditions",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
            kHeight30,
          ],
        ),
      )),
    );
  }

  resetApp(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text(
              'Do you want to Reset the app?',
              style: TextStyle(color: kBlackColor, fontSize: 18),
            ),
            actions: [
              TextButton(
                  onPressed: (() async {
                    Navigator.of(context).pop();
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
                      color: kRedColor,
                    ),
                  )),
              TextButton(
                onPressed: (() {
                  Navigator.of(context).pop();
                }),
                child: const Text(
                  'No',
                  style: TextStyle(color: kGreenColor),
                ),
              ),
            ],
          );
       });
  }
}
