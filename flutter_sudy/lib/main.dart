import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'item.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListWidget(),
    );
  }
}

class TodoListWidget extends StatefulWidget {
  @override
  _TodoListWidgetState createState() => _TodoListWidgetState();
}

class _TodoListWidgetState extends State<TodoListWidget> {
  final List<Item> _items = [];
  final _biggerFont = TextStyle(fontSize: 18.0);
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo list sample'),
      ),
      body: _buildList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addRow,
        tooltip: 'Add item',
        child: Icon(Icons.add),
      ),
    );
  }

  void _addRow() {
    setState(() {
      _items.add(Item((_counter++).toString(), '', false));
    });
  }

  Widget _buildList() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: _items.length,
        itemBuilder: (context, i) => _buildRow(_items[i]));
  }

  Widget _buildRow(Item item) {
    return ListTile(
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Checkbox(
            value: item.done,
            onChanged: (bool newValue) => setState(() {
                  item.done = newValue;
                })),
               ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 40, maxWidth: 250),
                child: TextField(
                    style: item.done
                        ? TextStyle(decoration: TextDecoration.lineThrough)
                            .merge(_biggerFont)
                        : _biggerFont,
                    onSubmitted: (val) => setState(() => item.name = val)))
      ]),
    ]));
  }
}
