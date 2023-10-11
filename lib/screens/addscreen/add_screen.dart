import 'package:financify/db_functions/transaction_db.dart';
import 'package:financify/model/add_data.dart';
import 'package:financify/screens/addscreen/widgets/background_container.dart';
import 'package:flutter/material.dart';
import '../../widget/bottomnavigationbar.dart';

ValueNotifier<List<Add_data>> overViewListNotifier =
    ValueNotifier(TransactionDB.instance.transactionListNotifier.value);

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  DateTime date = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  String? selectedCatogary;
  String? selectedType;
  final TextEditingController explainController = TextEditingController();
  FocusNode ex = FocusNode();
  final TextEditingController amountController = TextEditingController();
  FocusNode amount_ = FocusNode();
  final List<String> _item = [
    'food',
    "Transfer",
    "Transportation",
    "Education"
  ];
  final List<String> _itemei = [
    'income',
    'expense',
  ];

  @override
  // void initState() {

  // }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Stack(
        alignment: Alignment.center,
        children: [
          BackgroundContainer(),
          Positioned(
            top: 120,
            child: SingleChildScrollView(child: main_container()),
          ),
        ],
      )),
    );
  }

  Container main_container() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      height: 550,
      width: 340,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 50),
            name(),
            SizedBox(height: 30),
            explain(),
            SizedBox(height: 30),
            amount(),
            SizedBox(height: 30),
            type(),
            SizedBox(height: 30),
            date_time(),
            Spacer(),
            save(),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  GestureDetector save() {
    return GestureDetector(
      onTap: () {
        if (_formKey.currentState!.validate()) {
          addTransaction();
        }
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.black),
        width: 120,
        height: 50,
        child: Text(
          'Save',
          style: TextStyle(
              fontFamily: 'f',
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: 17),
        ),
      ),
    );
  }

  Widget date_time() {
    return Container(
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: Colors.black54)),
      width: 310,
      child: TextButton(
          onPressed: () async {
            DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: date,
                firstDate: DateTime(2020),
                lastDate: DateTime(2100));
            if (newDate == null) return;
            setState(() {
              date = newDate;
            });
          },
          child: Text(
            'Date :  ${date.year} /${date.month} /${date.day}',
            style: TextStyle(fontSize: 17, color: Colors.black),
          )),
    );
  }

  Padding type() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: Colors.black54),
        ),
        child: DropdownButton<String>(
          value: selectedType,
          onChanged: ((value) {
            setState(() {
              selectedType = value!;
            });
          }),
          items: _itemei
              .map((e) => DropdownMenuItem(
                    child: Container(
                      child: Row(
                        children: [
                          Text(
                            e,
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    value: e,
                  ))
              .toList(),
          selectedItemBuilder: (BuildContext context) => _itemei
              .map((e) => Row(
                    children: [
                      Text(e),
                    ],
                  ))
              .toList(),
          hint: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              "type",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          dropdownColor: Colors.white,
          isExpanded: true,
          underline: Container(),
        ),
      ),
    );
  }

  Padding amount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        keyboardType: TextInputType.number,
        focusNode: amount_,
        controller: amountController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          labelText: 'amount',
          labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 2, color: Colors.black54)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 2, color: Colors.black)),
        ),
      ),
    );
  }

  Padding explain() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        focusNode: ex,
        controller: explainController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          labelText: 'explain',
          labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 2, color: Colors.black54)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 2, color: Colors.black)),
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
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: Color(0xffC5C5C5),
          ),
        ),
        child: DropdownButton<String>(
          value: selectedCatogary,
          onChanged: ((value) {
            setState(() {
              selectedCatogary = value!;
            });
          }),
          items: _item
              .map((e) => DropdownMenuItem(
                    child: Container(
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            child: Image.asset('assets/images/${e}.png'),
                          ),
                          SizedBox(width: 10),
                          Text(
                            e,
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    value: e,
                  ))
              .toList(),
          selectedItemBuilder: (BuildContext context) => _item
              .map((e) => Row(
                    children: [
                      Container(
                        width: 42,
                        child: Image.asset('assets/images/${e}.png'),
                      ),
                      SizedBox(width: 5),
                      Text(e)
                    ],
                  ))
              .toList(),
          hint: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              'Name',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          dropdownColor: Colors.white,
          isExpanded: true,
          underline: Container(),
        ),
      ),
    );
  }

  Future addTransaction() async {
    final model = Add_data(
        type: selectedType!,
        amount: amountController.text,
        datetime: date,
        explain: explainController.text,
        name: selectedCatogary!,
        id: DateTime.now().microsecondsSinceEpoch.toString());

    await TransactionDB().addTransaction(model);

    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => BottomBar(),
    ));
    TransactionDB.instance.getAllTransactions();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Transaction Added Successfully',
          textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.black,
      ),
    );
  }
}
