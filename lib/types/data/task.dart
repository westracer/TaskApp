import 'package:ui_kurs/types/app/user.dart';
import 'package:uuid/uuid.dart';

enum TaskStatus { NEW, WIP, PROBLEM, POSTPONED, DONE }

class Task {
  Task({
    this.title, 
    this.creator,
    this.description = '', 
    this.executor = null, 
    this.dateTime = null, 
    this.status = TaskStatus.NEW,
    this.plannedTime = 0,
    this.timeSpent = 0,
    this.groupId = '',
  });

  static generateId() {
    return 'T' + Uuid().v4().toString();
  }

  final String id = Task.generateId();
  final String title;
  final String description;
  final DateTime dateTime;
  final User executor;
  final User creator;
  final TaskStatus status;
  final List<Task> children = List<Task>();
  final int plannedTime;
  final int timeSpent;
  final String groupId;
}