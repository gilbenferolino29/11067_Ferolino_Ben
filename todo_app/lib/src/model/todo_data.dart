class TodoData {
  String details;
  late DateTime timestamp;
  int id;
  String title;

  TodoData(
      {this.details = '', this.title = '', DateTime? timestamp, this.id = 0}) {
    timestamp == null
        ? this.timestamp = DateTime.now()
        : this.timestamp = timestamp;
  }
}

List<TodoData> todoContents = [
  TodoData(
    id: 1,
    details:
        'description of sample todo (you can DELETE me by SWIPING LEFT TO RIGHT',
    title: 'Sample todo',
  ),
  TodoData(
    id: 2,
    details:
        'description of sample todo (you can also EDIT by SWIPING RIGHT TO LEFT',
    title: 'Sample todo',
  )
];
