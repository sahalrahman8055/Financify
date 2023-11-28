import 'package:Financify/controller/splash_provider.dart';
import 'package:Financify/helper/colors.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return ChangeNotifierProvider(
      create: (context) => SplashScreenModel(context),
      child: Consumer<SplashScreenModel>(
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: kBlackColor,
            body: Center(
              child: Image.asset(
                'assets/start_Screen/black green gif.gif',
              ),
            ),
          );
        },
      ),
    );
  }
}

