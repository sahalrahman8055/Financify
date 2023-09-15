import 'package:flutter/material.dart';

class settings extends StatelessWidget {
  const settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Settings")),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                child: Row(
                  children: [
                    Icon(
                      Icons.warning_amber_outlined,
                      size: 30,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      "About",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                child: Row(
                  children: [
                    Icon(
                      Icons.restore,
                      size: 30,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      "Reset",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                child: Row(
                  children: [
                    Icon(
                      Icons.policy,
                      size: 30,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      "Privacy Policy",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                child: Row(
                  children: [
                    Icon(
                      Icons.note_add,
                      size: 30,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      "terms and conditions",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                child: Row(
                  children: [
                    Icon(
                      Icons.share,
                      size: 30,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      "Share",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      )),
    );
  }
}
