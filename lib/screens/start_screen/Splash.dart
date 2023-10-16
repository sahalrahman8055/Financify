import 'package:financify/widget/bottomnavigationbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neopop/widgets/buttons/neopop_tilted_button/neopop_tilted_button.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Colors.white, Colors.black])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          heightFactor: 6,
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.06,
              ),
              Container(
                child: Text(
                  'Financify',
                  style: GoogleFonts.spaceGrotesk(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.w800,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 3,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: size.height * 0.6,
                width: size.width * 0.9,
                child: Image.asset(
                  'assets/start_Screen/buy.png',
                ),
              ),
              SizedBox(
                height: size.height * 0.06,
              ),
              NeoPopTiltedButton(
                isFloating: true,
                onTapUp: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => BottomBar()));
                },
                decoration: NeoPopTiltedButtonDecoration(
                  color: Colors.black,
                  plunkColor: Colors.black,
                  shadowColor: Colors.black,
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
                        color: Colors.white,
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
