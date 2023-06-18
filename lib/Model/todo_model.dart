import 'package:get/get.dart';

class Todo {
  final String title;
  final RxBool completed;

  Todo({
    required this.title,
    bool completed = false,
  }) : completed = completed.obs;


  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'completed': completed.value,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      title: map['title'],
      completed: map['completed'],
    );
  }
}
