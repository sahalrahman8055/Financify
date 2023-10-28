import 'package:Financify/main.dart';
import 'package:Financify/screens/start_screen/FIrstscreen.dart';
import 'package:Financify/screens/start_screen/Login.dart';
import 'package:Financify/widget/bottomnavigationbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkUserLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Center(
          child: Image.asset(
            'assets/start_Screen/black green gif.gif',
          ),
        ),
      ),
    );
  }

  Future<void> gotologin() async {
    await Future.delayed(const Duration(seconds: 4));
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const StartScreen()));
  }

  Future<void> checkUserLoggedIn() async {
    final sharedPref = await SharedPreferences.getInstance();
    final userLoggedIn = sharedPref.getBool(saveKeyName);
    if (userLoggedIn == null || userLoggedIn == false) {
      gotologin();
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => BottomBar()));
    }
  }
}
