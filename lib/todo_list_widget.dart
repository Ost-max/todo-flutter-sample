import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_flutter_sample/todo_item_screen.dart';

import 'item.dart';

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

  Future navigateToItem(Item item) {
    return Navigator.pushNamed(context, TodoItemScreen.routeName,
        arguments: item);
  }

  void _addRow() {
    navigateToItem(null).then((value) => setState(() {
          if (value != null) {
            _items.add(value);
          }
        }));
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
      Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Checkbox(
            value: item.done,
            onChanged: (bool newValue) => setState(() {
                  item.done = newValue;
                })),
        GestureDetector(
          onTap: () => navigateToItem(item).then((value) => setState(() => {})),
          child: Text(
            item.name,
            style: item.done
                ? TextStyle(decoration: TextDecoration.lineThrough)
                    .merge(_biggerFont)
                : _biggerFont,
          ),
        ),
      ]),
      Divider(thickness: 1)
    ]));
  }
}
