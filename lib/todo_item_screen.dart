import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'item.dart';

class TodoItemScreen extends StatelessWidget {
  static const routeName = '/item';

  @override
  Widget build(BuildContext context) {
    final Item item = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(item.name != null ? item.name : "New TODO Item"),
      ),
      body: Column(
        children: [
          ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 40, maxWidth: 250),
              child: TextField(onSubmitted: (val) => item.name = val))
        ],
      ),
    );
  }
}
