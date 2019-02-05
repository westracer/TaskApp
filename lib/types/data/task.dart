library task;

import 'dart:math';

import 'package:ui_kurs/types/app/user.dart';
import 'package:ui_kurs/types/data/task-status.dart';
import 'package:uuid/uuid.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'task.g.dart';

abstract class Task implements Built<Task, TaskBuilder> {
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
  
  @nullable
  String get parentId;

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

  static List<Task> generateRandomTasks({int howMany = 1}) {
    List<Task> list = [];

    Random r = Random();
    for (int i = 1; i <= howMany; i++) {
      final title = 'Task ' + i.toString();
      final TaskStatus status = TaskStatus.ALL_STATUSES[r.nextInt(TaskStatus.ALL_STATUSES.length - 1)];

      list.add(Task((b) => b..title = title..status = status));
    }

    return list;
  }

  Task._();
  static Serializer<Task> get serializer => _$taskSerializer;
  factory Task([updates(TaskBuilder b)]) =>
      _$Task((b) => b..id = generateId()..status = TaskStatus.NEW..plannedTime = 0..timeSpent = 0..update(updates));
}