import 'package:Financify/constants/borderredius.dart';
import 'package:Financify/controller/search_provider.dart';
import 'package:Financify/services/transaction_db.dart';
import 'package:Financify/view/transaction/transactions_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    final searchControllerProvider =
        Provider.of<SearchProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        elevation: 9,
        shape: RoundedRectangleBorder(
          borderRadius:kRadius20,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextField(
            controller: searchControllerProvider.searchQueryController,
            onChanged: (query) {
              searchResult(query);
            },
            decoration: InputDecoration(
                hintText: 'Search..',
                border: InputBorder.none,
                icon: const Icon(
                  Icons.search,
                ),
                suffixIcon: IconButton(
                    onPressed: () {
                      overViewListNotifier.value =
                          TransactionDB.instance.transactionListNotifier.value;
                      searchControllerProvider.searchQueryController.clear();
                    },
                    icon: const Icon(
                      Icons.close,
                    ))),
          ),
        ),
      ),
    );
  }

  searchResult(String query) {
    if (query.isEmpty || query == '') {
      debugPrint(query);

      overViewListNotifier.value =
          TransactionDB.instance.transactionListNotifier.value;
    } else {
      overViewListNotifier.value = overViewListNotifier.value
          .where((element) =>
              element.name.toLowerCase().contains(query.trim().toLowerCase()) ||
              element.explain.contains(query.trim().toLowerCase()) ||
              element.amount.contains(query.trim()))
          .toList();
    }
  }
}
