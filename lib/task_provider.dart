import 'package:flutter/material.dart';

class TaskProvider extends ChangeNotifier {
  final List<Map<String, String>> _tasks = [];

  List<Map<String, String>> get tasks => _tasks;

  void addTask(Map<String, String> task) {
    _tasks.add(task);
    notifyListeners(); // Notifies UI to rebuild
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
    notifyListeners();
  }
}
