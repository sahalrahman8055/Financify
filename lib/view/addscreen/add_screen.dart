import 'package:Financify/constants/borderredius.dart';
import 'package:Financify/constants/sizedbox.dart';
import 'package:Financify/controller/add_screen-provider.dart';
import 'package:Financify/helper/colors.dart';
import 'package:Financify/services/transaction_db.dart';
import 'package:Financify/model/add_data.dart';
import 'package:Financify/view/addscreen/widgets/background_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widget/bottomnavigationbar.dart';

class AddScreen extends StatelessWidget {
   AddScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      body: SafeArea(
          child: Stack(
        alignment: Alignment.center,
        children: [
          const BackgroundContainer(),
          Positioned(
            top: 120,
            child: SingleChildScrollView(child: mainContainer(context)),
          ),
        ],
      )),
    );
  }

  Container mainContainer(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: kRadius20,
        color: kWhiteColor,
      ),
      height: 550,
      width: 340,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            kHeight50,
            name(),
           kHeight30,
            explain(context),
           kHeight30,
            amount(context),
            kHeight30,
            type(),
            kHeight30,
            dateTime(),
            const Spacer(),
            save(context),
            kHeight20
          ],
        ),
      ),
    );
  }

  GestureDetector save(BuildContext context) {
    return GestureDetector(
      onTap: () {
      
          
        if (_formKey.currentState!.validate()) {
          addTransaction(context);
        }
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: kRadius15, color: kBlackColor),
        width: 120,
        height: 50,
        child: const Text(
          'Save',
          style: TextStyle(
              fontFamily: 'f',
              fontWeight: FontWeight.w600,
              color: kWhiteColor,
              fontSize: 17),
        ),
      ),
    );
  }

  Widget dateTime() {
    // final dateProvider = Provider.of<AddScreenProvider>(context, listen: false);
    return Container(
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
          borderRadius: kRadius10,
          border: Border.all(width: 2, color: kBlackColor54)),
      width: 310,
      child: Consumer<AddScreenProvider>(
        builder: (context, dateProvider, child) {
          return TextButton(
            onPressed: () async {
              DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: dateProvider.date,
                firstDate: DateTime(2020),
                lastDate: DateTime(2100),
              );
              if (newDate == null) return;

              dateProvider.updateDate(newDate);
            },
            child: Text(
              'Date : ${dateProvider.date.year} /${dateProvider.date.month} /${dateProvider.date.day}',
              style: const TextStyle(fontSize: 17, color: kBlackColor),
            ),
          );
        },
      ),
    );
  }

  Padding type() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Consumer<AddScreenProvider>(
        builder: (context, typeProvider, child) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: kRadius10,
              border: Border.all(width: 2, color: kBlackColor54),
            ),
            child: DropdownButton<String>(
              value: typeProvider.selectedType,
              onChanged: ((value) {
                typeProvider.updateSelectedType(value!);
              }),
              items: typeProvider.itemei
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Row(
                          children: [
                            Text(
                              e,
                              style: const TextStyle(fontSize: 18),
                            )
                          ],
                        ),
                      ))
                  .toList(),
              selectedItemBuilder: (BuildContext context) => typeProvider.itemei
                  .map((e) => Row(
                        children: [
                          Text(e),
                        ],
                      ))
                  .toList(),
              hint: const Padding(
                padding: EdgeInsets.only(top: 12),
                child: Text(
                  "type",
                  style: TextStyle(color: kGreyColor),
                ),
              ),
              dropdownColor: kWhiteColor,
              isExpanded: true,
              underline: Container(),
            ),
          );
        },
      ),
    );
  }

  Padding amount(BuildContext context) {
    final amountProvider =
        Provider.of<AddScreenProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        keyboardType: TextInputType.number,
        focusNode: amountProvider.amount_,
        controller: amountProvider.amountController,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          labelText: 'amount',
          labelStyle: TextStyle(fontSize: 17, color: kGreyColorShade500),
          enabledBorder: OutlineInputBorder(
              borderRadius: kRadius10,
              borderSide: const BorderSide(width: 2, color: kBlackColor54)),
          focusedBorder: OutlineInputBorder(
              borderRadius: kRadius10,
              borderSide: const BorderSide(width: 2, color: kBlackColor)),
        ),
      ),
    );
  }

  Padding explain(BuildContext context) {
    final exProvider = Provider.of<AddScreenProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        focusNode: exProvider.ex,
        controller: exProvider.explainController,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          labelText: 'explain',
          labelStyle: TextStyle(fontSize: 17, color: kGreyColorShade500),
          enabledBorder: OutlineInputBorder(
              borderRadius: kRadius10,
              borderSide: const BorderSide(width: 2, color: kBlackColor54)),
          focusedBorder: OutlineInputBorder(
              borderRadius:kRadius10,
              borderSide: const BorderSide(width: 2, color: kBlackColor)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Select explain';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Padding name() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Consumer<AddScreenProvider>(
        builder: (context, nameProvider, child) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            width: 300,
            decoration: BoxDecoration(
              borderRadius: kRadius10,
              border: Border.all(
                width: 2,
                color:  kRgbGryColors,
              ),
            ),
            child: DropdownButton<String>(
              value: nameProvider.selectedCatogary,
              onChanged: ((value) {
                nameProvider.updateCtogary(value!);
              }),
              items: nameProvider.item
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Container(
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 40,
                                child: Image.asset('assets/images/$e.png'),
                              ),
                          kwidtht10,
                              Text(
                                e,
                                style: const TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                        ),
                      ))
                  .toList(),
              selectedItemBuilder: (BuildContext context) => nameProvider.item
                  .map((e) => Row(
                        children: [
                          SizedBox(
                            width: 42,
                            child: Image.asset('assets/images/$e.png'),
                          ),
                          kwidtht5,
                          Text(e)
                        ],
                      ))
                  .toList(),
              hint: const Padding(
                padding: EdgeInsets.only(top: 12),
                child: Text(
                  'Name',
                  style: TextStyle(color:kGreenColor),
                ),
              ),
              dropdownColor: kWhiteColor,
              isExpanded: true,
              underline: Container(),
            ),
          );
        },
      ),
    );
  }

  Future addTransaction(BuildContext context) async {
    final dataProvider = Provider.of<AddScreenProvider>(context, listen: false);
    final model = Add_data(
        type: dataProvider.selectedType!,
        amount: dataProvider.amountController.text,
        datetime: dataProvider.date,
        explain: dataProvider.explainController.text,
        name: dataProvider.selectedCatogary!,
        id: DateTime.now().microsecondsSinceEpoch.toString());

    await TransactionDB().addTransaction(model);

    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) =>  BottomBar(),
    ));

    TransactionDB.instance.getAllTransactions();
    dataProvider.explainController.clear();
    dataProvider.amountController.clear();
    dataProvider.selectedCatogary = null;
    dataProvider.selectedType = null;
    dataProvider.date = DateTime.now();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Transaction Added Successfully',
          textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: 3),
        backgroundColor: kGreenColor,
      ),
    );
  }
}
