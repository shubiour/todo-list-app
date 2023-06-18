import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/todo_model.dart';

class TodoController extends GetxController {
  final todos = <Todo>[].obs;
  final RxString searchQuery = ''.obs;

  void addTodo() {
    TextEditingController titleController = TextEditingController();

    Get.defaultDialog(
      title: 'Add Todo',
      content: TextFormField(
        autofocus: true,
        controller: titleController,
        decoration: InputDecoration(
          labelText: 'Title',
        ),
      ),
      textConfirm: 'OK',
      textCancel: 'Cancel',
      onConfirm: () {
        final value = titleController.text;
        if (value.isNotEmpty) {
          todos.add(Todo(title: value));
          Get.back();
        }
      },
    );
  }

  void updateTodoStatus(int index, bool completed) {
    todos[index].completed.value = completed;
  }

  void deleteTodo(int index) {
    todos.removeAt(index);
  }

  void clearCompletedTodos() {
    todos.removeWhere((todo) => todo.completed.value);
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  List<Todo> get filteredTodos {
    if (searchQuery.value.isEmpty) {
      return todos;
    } else {
      final filteredList = todos.where((todo) {
        return todo.title
            .toLowerCase()
            .contains(searchQuery.value.toLowerCase());
      }).toList();
      return filteredList;
    }
  }
}

