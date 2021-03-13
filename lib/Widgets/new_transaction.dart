import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNew;
  NewTransaction(this.addNew);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  String type;

  DateTime _selectedDate;
  TextEditingController _textEditingController = TextEditingController();

  final amountController = TextEditingController();

  void submit() {
    if (titleController.text.isEmpty ||
        type.isEmpty ||
        amountController.text.isEmpty ||
        int.parse(amountController.text) <= 0 ||
        _textEditingController.text.isEmpty) return;
    widget.addNew(
      titleController.text,
      type,
      int.parse(amountController.text),
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SingleChildScrollView(
        child: Container(
          color: Colors.grey[350],
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: mediaQuery.viewInsets.bottom + 10,
          ),
          child: Column(
            children: [
              Text(
                'Add a new transaction',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.blue[900],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: mediaQuery.size.width * 0.4,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: TextStyle(
                          color: Colors.blue[900],
                        ),
                      ),
                      controller: titleController,
                      onSubmitted: (_) => submit(),
                    ),
                  ),
                  Container(
                    width: mediaQuery.size.width * 0.4,
                    child: TextField(
                      controller: amountController,
                      decoration: InputDecoration(
                        labelText: 'Amount',
                        labelStyle: TextStyle(
                          color: Colors.blue[900],
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      onSubmitted: (_) => submit(),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: mediaQuery.size.width * 0.4,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: DropdownButton<String>(
                      dropdownColor: Colors.grey[200],
                      hint: Text(
                        'Transaction Type',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue[900],
                        ),
                      ),
                      value: type,
                      onChanged: (String newValue) {
                        setState(() {
                          type = newValue;
                        });
                      },
                      items: <String>[
                        'Expense',
                        'Income',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              color: Colors.blue[900],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    width: mediaQuery.size.width * 0.4,
                    child: TextField(
                      style: TextStyle(
                        color: Colors.blue[900],
                      ),
                      focusNode: AlwaysDisabledFocusNode(),
                      controller: _textEditingController,
                      onTap: () {
                        _selectDate(context);
                      },
                      decoration: InputDecoration(
                        hintText: 'Select Date',
                        hintStyle: TextStyle(
                          color: Colors.blue[900],
                        ),
                        suffixIcon: Icon(
                          Icons.calendar_today,
                          color: Colors.blue[900],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              FloatingActionButton(
                backgroundColor: Colors.blueGrey,
                child: Icon(
                  Icons.add,
                ),
                onPressed: submit,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      _textEditingController
        ..text = DateFormat('EE, MMM d').format(_selectedDate)
        ..selection = TextSelection.fromPosition(
          TextPosition(
              offset: _textEditingController.text.length,
              affinity: TextAffinity.upstream),
        );
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
