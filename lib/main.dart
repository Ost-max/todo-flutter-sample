import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:todo_flutter_sample/todo_item_screen.dart';
import 'package:todo_flutter_sample/todo_list_widget.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo list app',
      routes: {
         TodoItemScreen.routeName: (context) => TodoItemScreen()
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListWidget(),
    );
  }
}


