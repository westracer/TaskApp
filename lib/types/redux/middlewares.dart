import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:ui_kurs/types/app/storage.dart';
import 'package:ui_kurs/types/redux/actions/task-actions.dart';
import 'package:ui_kurs/types/redux/selectors.dart';
import 'package:ui_kurs/widgets/models/app-state.dart';

List<Middleware<AppState>> createAllMiddleware() {
  final List<Middleware<AppState>> middlewareList = [
      new TypedMiddleware<AppState, CreateTaskAction>(_taskListSave()),
      new TypedMiddleware<AppState, ToggleDoneTaskAction>(_taskListSave()),
      // new MiddlewareBinding<AppState, CreateTaskAction>(_taskMiddleware()
  ];

  return middlewareList;
}

Middleware<AppState> _taskListSave() {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);

    final taskList = taskListSelector(store.state);
    Storage.writeString(jsonEncode(taskList), LocalFiles.TASKS);
    debugPrint('tasklist saved');
  };
}