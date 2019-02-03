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

  static TaskStatus getStatusFromString(String statusAsString) {
    for (TaskStatus element in TaskStatus.values) {
      if (element.toString() == statusAsString) {
          return element;
      }
    }
    
    return null;
  }

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

  Task.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        creator = json['creator'],
        description = json['description'],
        executor = json['executor'],
        dateTime = json['dateTime'],
        status = Task.getStatusFromString(json['status']),
        plannedTime = json['plannedTime'],
        timeSpent = json['timeSpent'],
        groupId = json['groupId'];

  Map<String, dynamic> toJson() => {
    'title': title,
    'creator': creator,
    'description': description,
    'executor': executor,
    'dateTime': dateTime,
    'status': status.toString(),
    'plannedTime': plannedTime,
    'timeSpent': timeSpent,
    'groupId': groupId,
  };
}