import 'package:Financify/constants/sizedbox.dart';
import 'package:Financify/controller/bottomnavigation_provider.dart';
import 'package:Financify/helper/colors.dart';
import 'package:Financify/view/addscreen/add_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomProvider>(
      builder: (context, bottomProvider, child) {
        return Scaffold(
          body: bottomProvider.screens[bottomProvider.indexColor],
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddScreen(),
              ));
            },
            backgroundColor: kBlackColor,
            elevation: 10,
            child: const Icon(
              Icons.add,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      bottomProvider.indexColors(0);
                    },
                    child: Icon(
                      Icons.home_rounded,
                      size: 30,
                      color: bottomProvider.indexColor == 0
                          ? kBlackColor
                          : kGreyColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      bottomProvider.indexColors(1);
                    },
                    child: Icon(
                      Icons.bar_chart_rounded,
                      size: 30,
                      color: bottomProvider.indexColor == 1
                          ? kBlackColor
                          : kGreyColor,
                    ),
                  ),
                kHeight20,
                  GestureDetector(
                    onTap: () {
                      bottomProvider.indexColors(2);
                    },
                    child: Icon(
                      Icons.find_replace_outlined,
                      size: 30,
                      color: bottomProvider.indexColor == 2
                          ? kBlackColor
                          : kGreyColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      bottomProvider.indexColors(3);
                    },
                    child: Icon(
                      Icons.settings,
                      size: 30,
                      color: bottomProvider.indexColor == 3
                          ?kBlackColor
                          : kGreyColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
