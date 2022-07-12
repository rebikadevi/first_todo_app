// import 'package:flutter/cupertino.dart';
import 'package:flutter_todo_app/utils.dart';
// import 'package:intl/intl.dart';

class Todo {
  DateTime? formatedDate;
  String title;
  final String? id;
  bool isDone;

  Todo({
    required this.formatedDate,
    required this.title,
    this.id,
    this.isDone = false,
  });

  static Todo fromJson(Map<String, dynamic> json) => Todo(
        formatedDate: Utils.toDateTime(json['formatedDate']),
        title: json['title'],
        id: json['id'],
        isDone: json['isDone'],
      );

  Map<String, dynamic> toJson(String id) => {
        // Map<String, dynamic> toJson() => {
        'formatedDate': Utils.fromDateTimeToJson(formatedDate!),
        'title': title,
        'id': id,
        'isDone': isDone,
      };

  Map<String, dynamic> toJso() => {
        'formatedDate': Utils.fromDateTimeToJson(formatedDate!),
        'title': title,
        'id': id,
        'isDone': isDone,
      };

// factory Todo.fromMap(Map<String, dynamic> map) {
//   return Todo(
//     id: map['id'],
//     formatedDate: map['formatedDate'],
//     isDone: map['isDone'],
//   title: (map['title'] as List<dynamic>).map((title) => title.fromMap(title)).toList(),

//   );
// }

}
