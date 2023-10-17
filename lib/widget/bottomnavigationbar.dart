import 'package:financify/screens/settings/settings_Screen.dart';
import 'package:financify/screens/statistics/Statistics_screen.dart';
import 'package:financify/screens/addscreen/add_screen.dart';
import 'package:financify/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

import '../screens/transaction/transaction_lists.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _Bottom_BarState();
}

class _Bottom_BarState extends State<BottomBar> {
  int index_color = 0;
  List Screen = [
    const home_screen(),
    const StatisticsScreen(),
    TransactionList(),
    const settings(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screen[index_color],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const AddScreen()));
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.black,
        elevation:
            10, // Adjust the elevation value to control the shadow's depth
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 0;
                  });
                },
                child: Icon(
                  Icons.home_rounded,
                  size: 30,
                  color: index_color == 0 ? Colors.black : Colors.grey,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 1;
                  });
                },
                child: Icon(
                  Icons.bar_chart_rounded,
                  size: 30,
                  color: index_color == 1 ? Colors.black : Colors.grey,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 2;
                  });
                },
                child: Icon(
                  Icons.find_replace_outlined,
                  size: 30,
                  color: index_color == 2 ? Colors.black : Colors.grey,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 3;
                  });
                },
                child: Icon(
                  Icons.settings,
                  size: 30,
                  color: index_color == 3 ? Colors.black : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
