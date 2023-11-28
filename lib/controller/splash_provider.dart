import 'package:Financify/main.dart';
import 'package:Financify/view/start_screen/FIrstscreen.dart';
import 'package:Financify/widget/bottomnavigationbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenModel extends ChangeNotifier {
  SplashScreenModel(BuildContext context) {
    checkUserLoggedIn(context);
  }

  Future<void> gotologin(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 4));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (ctx) => const StartScreen()),
    );
  }

  Future<void> checkUserLoggedIn(BuildContext context) async {
    final sharedPref = await SharedPreferences.getInstance();
    final userLoggedIn = sharedPref.getBool(saveKeyName);
    if (userLoggedIn == null || userLoggedIn == false) {
      gotologin(context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => BottomBar()),
      );
    }
    notifyListeners();
  }
}
