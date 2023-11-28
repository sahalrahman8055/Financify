import 'package:Financify/constants/sizedbox.dart';
import 'package:Financify/controller/transaction_provider.dart';
import 'package:Financify/filter/type_filter.dart';
import 'package:Financify/helper/colors.dart';
import 'package:Financify/view/transaction/transactions_screen.dart';
import 'package:Financify/widget/bottomnavigationbar.dart';
import 'package:Financify/widget/searchfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

ValueNotifier showCategory = ValueNotifier('All');

class TransactionList extends StatelessWidget {
  const TransactionList({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context) => TransactionProvider(),
      child: Consumer<TransactionProvider>(builder: (context, model, child) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              actions: const [
                TypeFilterClass(),
               kHeight20,
              ],
              backgroundColor: kBlackColor,
              leading: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => BottomBar()));
                  },
                  child: const Icon(Icons.arrow_back_outlined)),
              title: Center(
                  child: Text('Transaction History',
                      style: GoogleFonts.ubuntu(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ))),
            ),
            body: Column(
              children: [
                SearchField(),
                const Expanded(
                  child: Transactions(),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
