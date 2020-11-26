import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'item.dart';

class TodoItemScreen extends StatelessWidget {
  static const routeName = '/item';
  static final dateTimeCntlr = TextEditingController();
  static final titleCntlr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Item item = ModalRoute.of(context).settings.arguments;
    titleCntlr.text = item.name;
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name.isNotEmpty ? "Edit TODO Item" : "New TODO Item"),
      ),
      body: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            children: [
              TextField(
                  decoration: InputDecoration(labelText: 'Title:'),
                  controller: titleCntlr,
                  onSubmitted: (val) => item.name = val),
              SizedBox(height: 16),
              TextField(
                controller: dateTimeCntlr,
                  decoration: InputDecoration(labelText: 'Due Date:'),
                  onSubmitted: (val) => item.name = val,
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
                  onSubmitted: (val) => item.description = val),
            ],
          )),
    );
  }
}
