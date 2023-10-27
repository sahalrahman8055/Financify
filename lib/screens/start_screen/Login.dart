import 'package:financify/main.dart';
import 'package:financify/widget/bottomnavigationbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neopop/widgets/buttons/neopop_tilted_button/neopop_tilted_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

final usernameController = TextEditingController();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


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
              colors: [Colors.black, Colors.black45])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.18,
                  ),
                  Container(
                    child: Text(
                      'Financify',
                      style: GoogleFonts.spaceGrotesk(
                        textStyle: TextStyle(
                          color: Color.fromARGB(255, 31, 247, 175),
                          fontSize: 35,
                          fontWeight: FontWeight.w800,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 3,
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),
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
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
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
                      decoration: InputDecoration(
                        hintText: 'Username..',
                        hintStyle: TextStyle(
                          color: Colors.grey,
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
                        // if (_formKey.currentState !=null && _formKey.currentState!.validate() ) {
                        //   checkLogin(context);
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(builder: (context) => BottomBar()),
                        //   );
                        // }
                        if (_formKey.currentState!.validate()) {
                          checkLogin(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomBar()),
                          );
                        }
                      },
                      decoration: const NeoPopTiltedButtonDecoration(
                        color: Color.fromARGB(255, 31, 247, 175),
                        plunkColor: Color.fromARGB(255, 31, 247, 175),
                        shadowColor: Colors.grey,
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
                              color: Colors.white,
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

  void checkLogin(BuildContext ctx) async {
    final username = usernameController.text;

    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setBool(saveKeyName, true);
    await sharedPref.setString('username', username);
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        ctx, MaterialPageRoute(builder: (ctx1) => BottomBar()));
  }
}
