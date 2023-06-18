import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/todo_controller.dart';

class HomePage extends StatelessWidget {
  final TodoController todoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => todoController.addTodo(),
          ),
          IconButton(
            icon: Icon(Icons.delete_outline),
            onPressed: () => todoController.clearCompletedTodos(),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Search',
              ),
              onChanged: (value) {
                // Set the search query
                todoController.setSearchQuery(value);
              },
            ),
          ),
          Expanded(
            child: Obx(
              () {
                final filteredTodos = todoController.filteredTodos;
                return ListView.builder(
                  itemCount: filteredTodos.length,
                  itemBuilder: (context, index) {
                    final todo = filteredTodos[index];
                    return ListTile(
                      title: Text(todo.title),
                      leading: Obx(
                        () => Checkbox(
                          value: todo.completed.value ?? false,
                          onChanged: (value) =>
                              todoController.updateTodoStatus(index, value!),
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => todoController.deleteTodo(index),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
