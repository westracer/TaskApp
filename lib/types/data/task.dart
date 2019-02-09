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
    const CHILD_TASK_CHANCE = .22;
    const DESCRIPTIONS = [
      'something important about the task goes here', 
      'maybe you should do something',
      'go get a drink',
      'In publishing and graphic design, lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document without relying on meaningful content. Replacing the actual content with placeholder text allows designers to design the form of the content before the content itself has been produced.',
      'btw drag and drop works like shit',
      'sample description',
      'come and stay awhile. and I will find a home because love to end, we love to end',
    ];

    List<Task> list = [];

    Random r = Random();
    for (int i = 1; i <= howMany; i++) {
      final title = 'Task ' + i.toString();
      final TaskStatus status = TaskStatus.ALL_STATUSES[r.nextInt(TaskStatus.ALL_STATUSES.length - 1)];
      final desctiption = DESCRIPTIONS[r.nextInt(DESCRIPTIONS.length - 1)];

      TaskBuilder b = Task((b) => b..title = title..status = status..description = desctiption).toBuilder();

      if (list.length > 1 && r.nextDouble() < CHILD_TASK_CHANCE) {
        int parentIndex = r.nextInt(list.length - 1);
        b.parentId = list[parentIndex].id;
      }

      list.add(b.build());
    }

    return list;
  }

  Task._();
  static Serializer<Task> get serializer => _$taskSerializer;
  factory Task([updates(TaskBuilder b)]) =>
      _$Task((b) => b..id = generateId()..status = TaskStatus.NEW..plannedTime = 0..timeSpent = 0..update(updates));
}