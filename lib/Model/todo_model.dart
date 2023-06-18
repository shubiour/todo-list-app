import 'package:get/get.dart';

class Todo {
  final String title;
  final RxBool completed;

  Todo({
    required this.title,
    bool completed = false,
  }) : completed = completed.obs;
}
