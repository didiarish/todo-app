import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:todo_taksu/models/task.dart';
import 'package:todo_taksu/models/todos.dart';
import 'package:todo_taksu/ui/shared/styles.dart';
import 'package:todo_taksu/ui/widgets/list_card.dart';
import 'package:todo_taksu/ui/widgets/text_field.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final String? name;

  const HomePage({Key? key, this.name}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final format = DateFormat("dd MMM yyy HH:mm");
  DateTime? value;
  final _formKey = GlobalKey<FormState>();
  SharedPreferences? _prefs;

  // setupTodo() async {
  //   final SharedPreferences prefs = await _prefs;
  //
  //   String? stringTodo = prefs.getString(widget.name!);
  //   List todoList = jsonDecode(stringTodo!);
  //   for (var todo in todoList) {
  //     setState(() {
  //       Provider.of<TodoModel>(context, listen: false).addTodo(todo);
  //     });
  //   }
  // }

  void onAdd() {
    final SharedPreferences? prefs = _prefs;
    if (_titleController.text.isNotEmpty && _dateController.text.isNotEmpty) {
      final Task todo = Task(
          title: _titleController.text,
          date: value,
          status: (value!.isBefore(DateTime.now())) ? "overdue" : "open");
      print("ini on add");
      Provider.of<TodoModel>(context, listen: false).addTodo(todo);
      // String items = jsonEncode(todo);
      // prefs?.setString(widget.name!, items);
      // print(items);
    }
  }

  Future<void> _showDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: mainColor,
          title: const Text(
            "New Todo",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
          ),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextField(
                    label: "Title",
                    hint: "Write todo ..",
                    message: 'Please enter some text',
                    controller: _titleController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Due date",
                        style: TextStyle(
                            color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 56,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: softBlack, borderRadius: BorderRadius.circular(5)),
                        child: DateTimeField(
                          validator: (value) {
                            if (value == null) {
                              return 'Please input a date';
                            }
                            return null;
                          },
                          initialValue: DateTime.now(),
                          cursorColor: Colors.white,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            hintText: "dd MMM yyy HH:mm",
                            hintStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: softBlack,
                                width: 0.0,
                              ),
                            ),
                            enabled: true,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: softBlack,
                                width: 0,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: softBlack,
                                width: 1,
                              ),
                            ),
                          ),
                          controller: _dateController,
                          format: format,
                          onShowPicker: (context, currentValue) async {
                            await showCupertinoModalPopup(
                                context: context,
                                builder: (context) {
                                  return BottomSheet(
                                    builder: (context) => Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          constraints: BoxConstraints(maxHeight: 200),
                                          child: CupertinoDatePicker(
                                            initialDateTime: DateTime.now(),
                                            // minimumDate: DateTime.now(),
                                            // maximumDate: DateTime(2100),
                                            onDateTimeChanged: (DateTime date) {
                                              value = date;
                                            },
                                          ),
                                        ),
                                        TextButton(onPressed: () => Navigator.pop(context), child: Text('Ok')),
                                      ],
                                    ),
                                    onClosing: () {},
                                  );
                                });
                            setState(() {});
                            return value;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 33,
                  ),
                  Container(
                    width: 179,
                    height: 40,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: purple,
                        elevation: 0,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          onAdd();
                          _titleController.clear();
                          _dateController.clear();
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 179,
                    height: 40,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        elevation: 0,
                      ),
                      onPressed: () {
                        _titleController.clear();
                        _dateController.clear();
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            color: darkGrey,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // setupTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 50.0, bottom: 0),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hi, " + widget.name!,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 30),
                  ),
                  SizedBox(height: 30,),
                  // Expanded(
                  //   child: ListView(
                  //     padding: EdgeInsets.symmetric(vertical: 35),
                  //     children: [
                  //       CustomCard(),
                  //     ],
                  //   ),
                  // ),
                  Expanded(
                    child: CustomCard(),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    backgroundColor: green,
                    onPressed: _showDialog,
                    tooltip: 'Dialog',
                    child: const Icon(
                      Icons.add,
                      color: darkBlack,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
