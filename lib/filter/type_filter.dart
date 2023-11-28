import 'package:Financify/constants/borderredius.dart';
import 'package:Financify/view/transaction/transaction_lists.dart';
import 'package:flutter/material.dart';

class TypeFilterClass extends StatelessWidget {
  const TypeFilterClass({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        shape: ContinuousRectangleBorder(
          borderRadius:kRadius20
        ),
        itemBuilder: ((context) => [
              PopupMenuItem(
                value: 1,
                onTap: () => showCategory.value = "All",
                child: const Text("All"),
              ),
              PopupMenuItem(
                value: 2,
                onTap: () => showCategory.value = "income",
                child: const Text("Income"),
              ),
              PopupMenuItem(
                value: 3,
                onTap: () => showCategory.value = "Expense",
                child: const Text("Expense"),
              ),
            ]),
        child: const Icon(
          Icons.filter_list_sharp,
          size: 30,
        ));
  }
}