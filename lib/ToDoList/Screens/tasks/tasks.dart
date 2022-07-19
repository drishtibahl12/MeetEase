import 'package:meet_ease/ToDoList/Screens/tasks/todolist.dart';
import 'package:meet_ease/ToDoList/models/todoList.dart';
import "package:provider/provider.dart";
import "package:flutter/material.dart";

class Tasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TodoListModel todoList = TodoListModel();
    todoList.getTasksFromSharedPrefs();
    return Scaffold(
        appBar: AppBar(
          title: Text('TodoList'),
        ),
        body: ChangeNotifierProvider.value(
          value: todoList,
          child: TodoListWidget(),
        ));
  }
}
