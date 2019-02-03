import 'package:ui_kurs/types/app/user.dart';
import 'package:ui_kurs/types/data/group.dart';
import 'package:ui_kurs/types/data/task.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// TODO: built_value immutability
class AppState {
  AppState({this.currentUser = null, this.tasks, this.groups});

  final User currentUser;
  final List<Task> tasks;
  final List<Group> groups;

  AppState replaceTask(Task newTask, Task oldTask) {
    List<Task> taskList = List.from(this.tasks);
    int oldTaskIndex = taskList.indexWhere((Task test) { return test.id == oldTask.id; });
    if (oldTaskIndex != -1) {
      taskList.replaceRange(oldTaskIndex, oldTaskIndex + 1, [newTask]);
    }

    return AppState(
      currentUser: this.currentUser,
      groups: this.groups,
      tasks: taskList
    );
  }
}