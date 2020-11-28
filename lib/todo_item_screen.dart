import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'item.dart';

class TodoItemScreen extends StatelessWidget {
  static const routeName = '/item';

  @override
  Widget build(BuildContext context) {
    final Item item =
        ModalRoute.of(context).settings.arguments ?? new Item('0', '', false);
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name.isNotEmpty ? "Edit TODO Item" : "New TODO Item"),
      ),
      body: Theme(
          data: Theme.of(context).copyWith(
              inputDecorationTheme:
                  InputDecorationTheme(border: InputBorder.none, filled: true)),
          child: Padding(
              padding: EdgeInsets.all(24.0), child: ToDoItemForm(item))),
    );
  }
}

class ToDoItemForm extends StatefulWidget {
  final Item _item;

  ToDoItemForm(this._item);

  @override
  ToDoItemFormState createState() {
    return ToDoItemFormState(_item);
  }
}

class ToDoItemFormState extends State<ToDoItemForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final Item _item;

  static final double _basicPadding = 24;
  static final TextEditingController _controllerDate = TextEditingController();

  ToDoItemFormState(this._item);

  @override
  void initState() {
    super.initState();
    _controllerDate.text = _item.getDueDateFormatted();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          TextFormField(
              decoration: InputDecoration(
                labelText: 'Title:',
                prefixIcon: Icon(Icons.done),
              ),
              initialValue: _item.name,
              onSaved: (val) => _item.name = val),
          SizedBox(height: _basicPadding),
          TextFormField(
            onTap: () => showDatePicker(
              context: context,
              initialDate: _item.due ?? DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2025),
            ).then((value) => setState(() {
                  _item.due = value;
                  _controllerDate.text = _item.getDueDateFormatted();
                })),
            controller: _controllerDate,
            readOnly: true,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.calendar_today_outlined),
              labelText: 'Due Date:',
            ),
          ),
          SizedBox(height: _basicPadding),
          TextFormField(
              initialValue: _item.description,
              decoration: InputDecoration(
                labelText: 'Description:',
                prefixIcon: Icon(Icons.description),
              ),
              maxLines: 3,
              onSaved: (val) => _item.description = val),
          SizedBox(height: _basicPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlineButton(
                  child: Text('Cancel'),
                  onPressed: () => Navigator.pop(context)),
              SizedBox(width: 12),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      Navigator.pop(context, _item);
                    }
                  },
                  child: Text('Apply')),
            ],
          )
        ]));
  }

  String _formatDate(DateTime due) {
    return due != null ? due.toString().split(' ')[0] : '';
  }
}
