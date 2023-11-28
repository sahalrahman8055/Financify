import 'package:Financify/helper/colors.dart';
import 'package:Financify/view/start_screen/Login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neopop/widgets/buttons/neopop_tilted_button/neopop_tilted_button.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [kBlackColor, kBlackColor])),
      child: Scaffold(
        backgroundColor: kTranparentColor,
        body: Center(
          heightFactor: 6,
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.06,
              ),
              Text(
                'Financify',
                style: GoogleFonts.spaceGrotesk(
                  textStyle: TextStyle(
                    color:  kRgbgreenColors,
                    fontSize: 35,
                    fontWeight: FontWeight.w800,
                    shadows: [
                      Shadow(
                        color: kBlackColor.withOpacity(0.2),
                        blurRadius: 3, 
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.6,
                width: size.width * 0.9,
                child: Image.asset(
                  'assets/start_Screen/splash.png',
                ),
              ),
              SizedBox(
                height: size.height * 0.06,
              ),
              NeoPopTiltedButton(
                isFloating: true,
                onTapUp: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) =>  LoginScreen()));
                },
                decoration: const NeoPopTiltedButtonDecoration(
                  color: kRgbgreenColors,
                  plunkColor: kRgbgreenColors,
                  shadowColor: kGreyColor,
                  showShimmer: true,
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 50.0,
                    vertical: 10,
                  ),
                  child: Text(
                    "Let's Start..",
                    style: TextStyle(
                        fontSize: 15,
                        color: kBlackColor,
                        fontStyle: FontStyle.italic),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
