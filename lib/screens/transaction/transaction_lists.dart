import 'package:financify/db_functions/transaction_db.dart';
import 'package:financify/filter/type_filter.dart';

import 'package:financify/screens/transaction/transactions_screen.dart';

import 'package:financify/widget/bottomnavigationbar.dart';
import 'package:financify/widget/searchfield.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

ValueNotifier showCategory = ValueNotifier('All');

class TransactionList extends StatefulWidget {
  TransactionList({
    super.key,
  });

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  void initState() {
    overViewListNotifier.value =
        TransactionDB.instance.transactionListNotifier.value;
    super.initState();
  }

  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: const [
            TypeFilterClass(),
            SizedBox(
              width: 20,
            ),
          ],
          backgroundColor: Colors.black,
          leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => BottomBar()));
              },
              child: Icon(Icons.arrow_back_outlined)),
          title: Center(
              child: Text('Transaction History',
                  style: GoogleFonts.ubuntu(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ))),
        ),
        body: Container(
          child: Column(
            children: [
              SearchField(),
              Expanded(
                child: Transactions(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
