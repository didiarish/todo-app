import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_taksu/models/todos.dart';
import 'package:todo_taksu/ui/views/login_page.dart';

import 'ui/views/home_page.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => TodoModel(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'To-do Taksu',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
