import 'package:flutter/material.dart';

class Task {
  String? title;
  DateTime? date;
  String? status;

  Task({this.title, this.date, this.status});

  Task.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        date = json['date'],
        status = json['status'];

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'date': date,
      'status': status,
    };
  }
}
