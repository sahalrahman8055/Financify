
import 'package:Financify/constants/borderredius.dart';
import 'package:Financify/helper/colors.dart';
import 'package:Financify/main.dart';
import 'package:Financify/widget/bottomnavigationbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neopop/widgets/buttons/neopop_tilted_button/neopop_tilted_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

final usernameController = TextEditingController();

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [kBlackColor, kBlackColor45])),
      child: Scaffold(
        backgroundColor: kTranparentColor,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.18,
                  ),
                  Text(
                    'Financify',
                    style: GoogleFonts.spaceGrotesk(
                      textStyle: TextStyle(
                        color: kRgbgreenColors,
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
                    height: size.height * 0.4,
                  ),
                  Container(
                    height: 50, // Specify the desired height
                    width: 240, // Specify the desired width
                    decoration: BoxDecoration(
                      border: Border.all(color: kGreyColorShade300),
                      borderRadius: kRadius15,
                      color: kWhiteColor,
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required Name';
                        } else {
                          return null;
                        }
                      },
                      controller: usernameController,
                      decoration: const InputDecoration(
                        hintText: 'Username..',
                        hintStyle: TextStyle(
                          color: kGreyColor,
                          fontSize: 13, // Adjust the font size as needed
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  SingleChildScrollView(
                    child: NeoPopTiltedButton(
                      isFloating: true,
                      onTapUp: () {
                        
                        if (_formKey.currentState!.validate()) {
                          checkLogin(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>const   BottomBar()),
                          );
                        }
                      },
                      decoration: const NeoPopTiltedButtonDecoration(
                        color: kRgbgreenColors,
                        plunkColor: kRgbgreenColors,
                        shadowColor: kGreyColor,
                        showShimmer: true,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 60.0,
                          vertical: 10,
                        ),
                        child: Text(
                          "Log In",
                          style: TextStyle(
                              fontSize: 15,
                              color: kWhiteColor,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  void checkLogin(BuildContext context) async {
    final username = usernameController.text;

    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setBool(saveKeyName, true);
    await sharedPref.setString('username', username);

    Navigator.push(
        context, MaterialPageRoute(builder:(context) => const BottomBar()));
  }
}
