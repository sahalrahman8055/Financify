import 'package:Financify/constants/borderredius.dart';
import 'package:Financify/constants/sizedbox.dart';
import 'package:Financify/controller/edit_provider.dart';
import 'package:Financify/helper/colors.dart';
import 'package:Financify/services/transaction_db.dart';
import 'package:Financify/model/add_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditTransaction extends StatefulWidget {
  final String? id;
  final Add_data obj;

  const EditTransaction({
    super.key,
    required this.obj,
    this.id,
  });

  @override
  State<EditTransaction> createState() => _EditTransactionState();
}

class _EditTransactionState extends State<EditTransaction> {
  // ignore: unused_field

  @override
  void initState() {
    super.initState();
    final controllersProvider =
        Provider.of<EditTransactionProvider>(context, listen: false);
    controllersProvider.value = int.parse(widget.obj.id);
    controllersProvider.amountTextEditingController =
        TextEditingController(text: widget.obj.amount);
    controllersProvider.explainTextEditingController =
        TextEditingController(text: widget.obj.explain);
    controllersProvider.selectedDateTime = widget.obj.datetime;
    controllersProvider.selectedtype = widget.obj.type;
    controllersProvider.selectedCategory = widget.obj.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      body: SafeArea(
          child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          backgroundContainer(context),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              child: mainContainer(),
            ),
          )
        ],
      )),
    );
  }

  Container mainContainer() {
    final formkeyProvider =
        Provider.of<EditTransactionProvider>(context, listen: false);
    final Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          borderRadius: kRadius20, color: kWhiteColor),
      /*  height: 550,
      width: 340, */
      height: size.height * 0.7,
      width: size.width * 0.9,
      child: Form(
        key: formkeyProvider.formKey,
        child: Column(
          children: [
            kHeight30,
            type(),
           kHeight20,
            name(),
           kHeight20,
            explain(),
           kHeight20,
            amount(),
           kHeight20,
            dateTime(),
           kHeight20,
            const Spacer(),
            GestureDetector(
              onTap: () {
                if (formkeyProvider.formKey.currentState!.validate()) {
                  submitEditIncomeTransaction();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        backgroundColor: kGreenColor,
                        content: Center(
                            child: Text('Transaction Edited Successfully'))),
                  );
                }
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: kRadius15,
                    color: kBlackColor),
                width: 120,
                height: 50,
                child: const Text(
                  'Save',
                  style: TextStyle(
                    fontFamily: 'f',
                    fontWeight: FontWeight.w600,
                    color: kWhiteColor,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            kHeight20,
          ],
        ),
      ),
    );
  }

  Container dateTime() {
    return Container(
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
          borderRadius:kRadius10,
          border: Border.all(width: 2, color: kGreyColor)),
      width: 300,
      child: Consumer<EditTransactionProvider>(
        builder: (context, dateProvider, child) {
          return TextButton(
            //child: Text('${widget.obj.datetime}'),
            onPressed: () async {
              DateTime? newDate = await showDatePicker(
                  context: context,
                  initialDate: widget.obj.datetime,
                  //initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100));
              // ignore: unrelated_type_equality_checks
              if (newDate == Null) return;
              dateProvider.editDate(newDate!);
            },

            child: Text(
              'Date : ${dateProvider.date.year}/${dateProvider.date.month}/${dateProvider.date.day}',
              style: const TextStyle(
                  fontSize: 16,
                  //fontWeight: FontWeight.normal,
                  color: kBlackColor),
            ),
          );
        },
      ),
    );
  }

  Padding type() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 15),
          width: 300,
          decoration: BoxDecoration(
            borderRadius: kRadius10,
            border: Border.all(
              width: 2,
              color: kGreyColor,
            ),
          ),
          child: SingleChildScrollView(
            child: Consumer<EditTransactionProvider>(
              builder: (context, typeProvider, child) {
                return DropdownButtonFormField<String>(
                  hint: Row(
                    children: [
                      // ignore: sized_bkWhiteColorspace
                      Container(
                        width: 40,
                        child:
                            Image.asset('assets/images/${widget.obj.type}.png'),
                      ),
                      // ignore: unnecessary_string_interpolations
                      Text('${widget.obj.type}',
                          style: const TextStyle(color: kBlackColor)),
                    ],
                  ),
                  value: typeProvider.selectedtype,
                  onChanged: ((value) {
                    typeProvider.selectedtype = value!;
                  }),
                  items: typeProvider.iteminex
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Row(
                              children: [
                                kwidtht10,
                                Text(
                                  e,
                                  style: const TextStyle(fontSize: 17),
                                )
                              ],
                            ),
                          ))
                      .toList(),
                  dropdownColor: kWhiteColor,
                  isExpanded: true,
                );
              },
            ),
          )),
    );
  }

  Padding amount() {
    final amountProvider =
        Provider.of<EditTransactionProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        width: 300,
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Required Name';
            } else {
              return null;
            }
          },
          keyboardType: TextInputType.number,
          //focusNode: amount,
          controller: amountProvider.amountTextEditingController,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            labelText: 'Amount',
            labelStyle: const TextStyle(fontSize: 17, color: kGreyColor),
            border: OutlineInputBorder(
              borderRadius: kRadius10,
              borderSide: const BorderSide(width: 2, color: kBlackColor),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: kRadius10,
                borderSide: const BorderSide(width: 2, color: kGreyColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: kRadius15,
                borderSide: const BorderSide(width: 2, color: kBlackColor)),
          ),
        ),
      ),
    );
  }

  Padding explain() {
    final explainProvider =
        Provider.of<EditTransactionProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        width: 300,
        child: TextField(
          //focusNode: ex,
          controller: explainProvider.explainTextEditingController,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            labelText: 'explain',
            labelStyle: const TextStyle(fontSize: 17, color: kGreyColor),
            border: OutlineInputBorder(
              borderRadius: kRadius10,
              borderSide: const BorderSide(width: 2, color: kBlackColor),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: kRadius10,
                borderSide: const BorderSide(width: 2, color: kGreyColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: kRadius15,
                borderSide: const BorderSide(width: 2, color: kBlackColor)),
          ),
        ),
      ),
    );
  }

  Padding name() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: 300,
        decoration: BoxDecoration(
          borderRadius:kRadius10,
          border: Border.all(
            width: 2,
            color: const Color(0xffC5C5C5),
          ),
        ),
        child: Consumer<EditTransactionProvider>(
          builder: (context, categoryProvider, child) {
            return DropdownButtonFormField<String>(
              hint: Row(
                children: [
                  // ignore: sized_bkWhiteColorspace
                  Container(
                    width: 40,
                    child: Image.asset('assets/images/${widget.obj.name}.png'),
                  ),
                  Text('${widget.obj.name} ',
                      style: const TextStyle(color: kBlackColor)),
                ],
              ),
              // value: selctedItem,
              onChanged: (value) {
                categoryProvider.selectedCategory = value!;
              },
              items: categoryProvider.item
                  .map(
                    (e) => DropdownMenuItem<String>(
                      value: e,
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 40,
                              child: Image.asset('assets/images/${e}.png'),
                            ),
                           kwidtht10,
                            Text(
                              e,
                              style: const TextStyle(fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
              selectedItemBuilder: (BuildContext context) =>
                  categoryProvider.item
                      .map(
                        (e) => Row(
                          children: [
                            SizedBox(
                              width: 42,
                              child: Image.asset('assets/images/$e.png'),
                            ),
                            kwidtht5,
                            Text(e),
                          ],
                        ),
                      )
                      .toList(),
              decoration: const InputDecoration(
                hintText: 'Category',
                hintStyle: TextStyle(color: kGreyColor),
                border: InputBorder.none,
              ),
              dropdownColor: kWhiteColor,
              isExpanded: true,
            );
          },
        ),
      ),
    );
  }

  Column backgroundContainer(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 240,
          decoration: const BoxDecoration(
            color: kBlackColor,
            borderRadius: kRadius
          ),
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
                      child: const Icon(Icons.arrow_back, color: kWhiteColor),
                    ),
                    const Center(
                      child: Text(
                        'Edit Transaction',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: kWhiteColor),
                      ),
                    ),
                    const Icon(Icons.add_task_rounded, color: kWhiteColor)
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Future<void> submitEditIncomeTransaction() async {
    final SubmitProvider =
        Provider.of<EditTransactionProvider>(context, listen: false);

    final _explainText = SubmitProvider.explainTextEditingController.text;
    final _amountText = SubmitProvider.amountTextEditingController.text;

    final model = Add_data(
        type: SubmitProvider.selectedtype!,
        amount: _amountText,
        datetime: SubmitProvider.date,
        explain: _explainText,
        name: SubmitProvider.selectedCategory!,
        id: widget.obj.id);

    await TransactionDB.instance.editTransaction(model);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }
}
