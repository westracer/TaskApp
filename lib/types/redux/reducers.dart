import 'package:ui_kurs/types/data/serializers.dart';
import 'package:ui_kurs/types/data/task.dart';
import 'package:ui_kurs/types/redux/actions/task-actions.dart';
import 'package:ui_kurs/widgets/models/app-state.dart';

import 'package:flutter/widgets.dart';

AppState appReducers(AppState appState, dynamic action) {
  if (action is CreateTaskAction) {
    return addItem(appState, action);
  } else if (action is ToggleDoneTaskAction) {
    return toggleDoneItem(appState, action);
  } 

  return appState;
}

AppState addItem(AppState appState, CreateTaskAction action) {
  Task createdTask = action.task;
  debugPrint(serializers.serialize(createdTask).toString());

  return AppState(
    currentUser: appState.currentUser,
    groups: appState.groups,
    tasks: appState.tasks.rebuild((b) => b.add(createdTask))
  );
}

AppState toggleDoneItem(AppState appState, ToggleDoneTaskAction action) {
  final Task newTask = action.task.toggleStatusDone();

  return appState.replaceTask(newTask, action.task);
}