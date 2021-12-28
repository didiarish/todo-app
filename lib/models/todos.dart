import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_taksu/models/task.dart';

class TodoModel extends ChangeNotifier {
  final List<Task> _task = [];

  UnmodifiableListView<Task> get allTasks => UnmodifiableListView(_task);

  void addTodo(Task task) {
    _task.add(task);
    notifyListeners();
  }

  void deleteTodo(Task task) {
    _task.remove(task);
    notifyListeners();
  }

}