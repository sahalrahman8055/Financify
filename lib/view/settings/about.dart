import 'package:Financify/constants/borderredius.dart';
import 'package:Financify/constants/sizedbox.dart';
import 'package:Financify/helper/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: kGreyColor,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: kBlackColor,
            title: Text("About",
                style: GoogleFonts.ubuntu(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                )),
          ),
          body: Center(
            child: Container(
              width: 250,
              height: 300,
              color: kGreyColor,
              child: Material(
                borderRadius: kRadius20,
                elevation: 10,
                shadowColor: kWhiteColor,
                child: Column(
                  children: [
                    Title(
                        color: kBlackColor,
                        child: const Padding(
                          padding: EdgeInsets.only(top: 30, left: 10),
                          child: Text(
                            'Financify',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w800),
                          ),
                        )),
                 kHeight30,
                    const Padding(
                      padding: EdgeInsets.only(left: 15, right: 10),
                      child: Text(
                        '"This is an app where you can\nadd your daily transactions\naccording to the category which it belongs to."',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                kHeight40,
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Developed by',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const Center(
                      child: Text(
                        'Shahal Rahman.MT',
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
