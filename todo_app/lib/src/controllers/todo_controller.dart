import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/src/model/todo_data.dart';

class TodoController with ChangeNotifier {
  final Box todoCache = Hive.box('todos');
  late String currentUser;
  List<TodoData> data = [];

  TodoController(this.currentUser) {
    List result = todoCache.get(currentUser, defaultValue: []);
    print(result);
    for (var entry in result) {
      print(entry);
      data.add(TodoData.fromJson(Map<String, dynamic>.from(entry)));
    }
    notifyListeners();
  }

  toggleDone(TodoData todo) {
    todo.toggleDone();
    saveDataToCache();
  }

  addTodo(TodoData todo) {
    data.add(todo);
    saveDataToCache();
  }

  removeTodo(TodoData toBeDeleted) {
    data.remove(toBeDeleted);
    saveDataToCache();
  }

  updateTodo(TodoData todo, String newDetails, String newTitle) {
    todo.updateDetails(newTitle, newDetails);
    saveDataToCache();
  }

  saveDataToCache() {
    List<Map<String, dynamic>> dataToStore = [];
    for (TodoData todo in data) {
      dataToStore.add(todo.toJson());
    }
    print(dataToStore);
    todoCache.put(currentUser, dataToStore);
    notifyListeners();
  }
}
