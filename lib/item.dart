class Item {
  final String id;
  String name;
  String description;
  DateTime before;
  bool done;
  bool enabled = true;

  Item(this.id, this.name, this.done);
}
