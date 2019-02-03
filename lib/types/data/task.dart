library task;

import 'package:built_collection/built_collection.dart';
import 'package:ui_kurs/types/app/user.dart';
import 'package:uuid/uuid.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'task.g.dart';

enum TaskStatus { NEW, WIP, PROBLEM, POSTPONED, DONE }

abstract class Task implements Built<Task, TaskBuilder> {
  // Task({
  //   this.title, 
  //   this.creator,
  //   this.description = '',
  //   this.executor = null, 
  //   this.dateTime = null, 
  //   this.status = TaskStatus.NEW,
  //   this.plannedTime = 0,
  //   this.timeSpent = 0,
  //   this.groupId = '',
  // });

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

  String get id;
  String get title;

  @nullable
  String get description;

  @nullable
  DateTime get dateTime;

  @nullable
  User get executor;

  @nullable
  User get creator;
  TaskStatus get status;
  List<Task> get children;
  int get plannedTime;
  int get timeSpent;

  @nullable
  String get groupId;

  Task toggleStatusDone() {
    if (this.status == TaskStatus.DONE) {
      return this.rebuild((b) => b..status = TaskStatus.WIP);
    } else {
      return this.rebuild((b) => b..status = TaskStatus.DONE);
    }
  }

  bool isCompleted() {
    return this.status == TaskStatus.DONE;
  }

  Task._();
  static Serializer<Task> get serializer => _$taskSerializer;
  factory Task([updates(TaskBuilder b)]) =>
      _$Task((b) => b..id = generateId()..children = []..status = TaskStatus.NEW..plannedTime = 0..timeSpent = 0..update(updates));
}