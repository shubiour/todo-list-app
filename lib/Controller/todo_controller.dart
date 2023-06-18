import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../model/todo_model.dart';

class TodoController extends GetxController {
  final todos = <Todo>[].obs;
  final RxString searchQuery = ''.obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    // Load todos from storage
    List<dynamic>? storedTodos = box.read('todos');
    if (storedTodos != null) {
      todos.assignAll(
        storedTodos.map((todo) => Todo.fromMap(todo)).toList(),
      );
    }
  }

  void addTodo() {
    TextEditingController titleController = TextEditingController();

    Get.defaultDialog(
      title: 'Add Todo',
      content: TextFormField(
        autofocus: true,
        controller: titleController,
        decoration: const InputDecoration(
          labelText: 'Title',
        ),
      ),
      textConfirm: 'OK',
      textCancel: 'Cancel',
      onConfirm: () {
        final value = titleController.text;
        if (value.isNotEmpty) {
          todos.add(Todo(title: value));
          saveTodosToStorage(); // Save todos to storage
          Get.back();
        }
      },
    );
  }

  void updateTodoStatus(int index, bool completed) {
    todos[index].completed.value = completed;
    saveTodosToStorage(); // Save todos to storage
  }

  void deleteTodo(int index) {
    todos.removeAt(index);
    saveTodosToStorage(); // Save todos to storage
  }

  void clearCompletedTodos() {
    todos.removeWhere((todo) => todo.completed.value);
    saveTodosToStorage(); // Save todos to storage
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  List<Todo> get filteredTodos {
    if (searchQuery.value.isEmpty) {
      return todos;
    } else {
      final filteredList = todos.where((todo) {
        return todo.title.toLowerCase().contains(searchQuery.value.toLowerCase());
      }).toList();
      return filteredList;
    }
  }

  void saveTodosToStorage() {
    box.write('todos', todos.map((todo) => todo.toMap()).toList());
  }
}
