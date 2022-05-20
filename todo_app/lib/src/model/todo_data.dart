import 'package:simple_moment/simple_moment.dart';

class TodoData {
  late String details;
  late DateTime timestamp;
  bool done = false;
  late String title;

  TodoData({this.details = '', this.title = '', DateTime? timestamp}) {
    timestamp == null
        ? this.timestamp = DateTime.now()
        : this.timestamp = timestamp;
  }

  TodoData.fromJson(Map<String, dynamic> json) {
    details = json['details'] ?? '';
    timestamp = json['created'] ?? DateTime.now();
    done = json['done'] ?? false;
  }

  String get parsedDate {
    return Moment.fromDateTime(timestamp).format('hh:mm a MMMM dd, yyyy ');
  }

  updateDetails(String updateTitle, String updateDetails) {
    title = updateTitle;
    details = updateDetails;
    timestamp = DateTime.now();
  }

  toggleDone() {
    done = !done;
  }

  Map<String, dynamic> get json => {
        'title': title,
        'details': details,
        'created': timestamp,
        'done': done,
      };

  Map<String, dynamic> toJson() {
    return json;
  }

  log() {
    print(json);
  }
}

List<TodoData> todoContents = [
  TodoData(
    details:
        'description of sample todo (you can DELETE me by SWIPING LEFT TO RIGHT',
    title: 'Sample todo',
  ),
  TodoData(
    details:
        'description of sample todo (you can also EDIT by SWIPING RIGHT TO LEFT',
    title: 'Sample todo',
  )
];
