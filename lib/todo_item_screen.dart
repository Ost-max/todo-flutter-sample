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
        title: Text(item.name.isNotEmpty ? "Edit TODO Item" : "New TODO Item"),
      ),
      body: Padding(
          padding: EdgeInsets.all(24.0),
          child: ToDoItemForm(item)
      ),
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

  static final titleCntlr = TextEditingController();
  static final dateTimeCntlr = TextEditingController();

  ToDoItemFormState(this._item);

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    titleCntlr.text = _item.name;

    return Form(
        key: _formKey,
        child: Column(
            children: <Widget>[
              TextField(
                  decoration: InputDecoration(labelText: 'Title:'),
                  controller: titleCntlr,
                  onSubmitted: (val) => _item.name = val),
              SizedBox(height: 16),
              TextField(
                controller: dateTimeCntlr,
                decoration: InputDecoration(labelText: 'Due Date:'),
                onSubmitted: (val) => _item.name = val,
                onTap: (){
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2025),
                  ).then((value) =>  dateTimeCntlr.text = value.toString().split(' ')[0]);
                } ,
              ),

              SizedBox(height: 16),
              TextField(
                  decoration: InputDecoration(
                    labelText: 'Description:',
                  ),
                  maxLines: 3,
                  onSubmitted: (val) => _item.description = val)
            ]
        )
    );
  }
}
