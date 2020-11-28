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
        padding: EdgeInsets.all(8.0),
        itemCount: _items.length,
        itemBuilder: (context, i) => _buildRow(_items[i], i));
  }

  Widget _buildRow(Item item, int i) {
    return Dismissible(
      key: Key(item.name),
      background: Container(
        color: Colors.red,
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: AlignmentDirectional.centerStart,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      secondaryBackground: Container(
        color: Colors.lightGreen,
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: AlignmentDirectional.centerEnd,
        child: Icon(
          Icons.done_outline_rounded,
          color: Colors.white,
        ),
      ),
      dismissThresholds: {
        DismissDirection.startToEnd: 0.7,
        DismissDirection.endToStart: 0.2
      },
      confirmDismiss: (direction) {
        var delete = direction == DismissDirection.startToEnd;
        setState(() {
          if (!delete) {
            item.done = !item.done;
          }
        });
        return Future.value(delete);
      },
      onDismissed: (direction) {
        setState(() {
          print(direction);
          _items.removeAt(i);
        });
      },
      child: Card(
        child: ListTile(
            subtitle: Text(
              '${item.getDueDateFormatted().isNotEmpty ? item.getDueDateFormatted() : item.description}',
              overflow: TextOverflow.ellipsis,
            ),
            leading: Checkbox(
                value: item.done,
                onChanged: (bool newValue) => setState(() {
                      item.done = newValue;
                    })),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () =>
                  navigateToItem(item).then((value) => setState(() => {})),
            ),
            title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: item.done
                        ? TextStyle(decoration: TextDecoration.lineThrough)
                            .merge(_biggerFont)
                        : _biggerFont,
                  ),
                ])),
      ),
    );
  }
}
