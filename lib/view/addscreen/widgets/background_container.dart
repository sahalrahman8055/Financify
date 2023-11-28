import 'package:Financify/constants/borderredius.dart';
import 'package:Financify/constants/sizedbox.dart';
import 'package:Financify/helper/colors.dart';
import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  const BackgroundContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 240,
          decoration: const BoxDecoration(
              color: kWhiteColor30,
              borderRadius:kRadius),
          child: Column(
            children: [
             kHeight40,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(
                          Icons.arrow_back_rounded,
                          color: kWhiteColor,
                        )),
                    const Text(
                      "Adding",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: kWhiteColor),
                    ),
                    const Icon(
                      Icons.attach_file_outlined,
                      color: kWhiteColor,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
