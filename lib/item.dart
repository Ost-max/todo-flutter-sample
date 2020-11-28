class Item {
  final String id;
  String name;
  String description;
  DateTime due;
  bool done;
  bool enabled = true;

  Item(this.id, this.name, this.done);

  String getDueDateFormatted() {
    return due != null ? due.toString().split(' ')[0] : '';
  }

}
