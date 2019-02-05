import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:ui_kurs/types/data/serializers.dart';
import 'package:ui_kurs/types/data/task.dart';
import 'package:ui_kurs/types/redux/actions/task-actions.dart';
import 'package:ui_kurs/widgets/models/app-state.dart';

AppState appReducers(AppState appState, dynamic action) {
  if (action is AddTasksAction) {
    return addItem(appState, action);
  } else if (action is ToggleDoneTaskAction) {
    return toggleDoneItem(appState, action);
  } else if (action is LoadTaskListSuccessAction) {
    return loadTaskListSuccess(appState, action);
  } else if (action is MoveTaskAction) {
    return moveTask(appState, action);
  }

  return appState;
}

AppState addItem(AppState appState, AddTasksAction action) {
  List<Task> createdTasks = action.tasks;

  return AppState(
    currentUser: appState.currentUser,
    groups: appState.groups,
    tasks: appState.tasks.rebuild((b) => b.addAll(createdTasks))
  );
}

AppState toggleDoneItem(AppState appState, ToggleDoneTaskAction action) {
  final Task newTask = action.task.toggleStatusDone();

  return appState.replaceTask(newTask, action.task);
}

AppState loadTaskListSuccess(AppState appState, LoadTaskListSuccessAction action) {
  if (action.jsonString == null) return appState;

  try {
    final Object obj = json.decode(action.jsonString);
    final specifiedType = const FullType(BuiltList, const [const FullType(Task)]);
    BuiltList<Task> loadedList = serializers.deserialize(obj, specifiedType: specifiedType);
    return AppState(tasks: loadedList);
  } catch (e) {
    return appState;
  }
}

AppState moveTask(AppState appState, MoveTaskAction action) {
  int oldIndex = action.oldIndex;
  int newIndex = action.newIndex;
  int taskCount = appState.tasks.length;

  if (oldIndex < 0 || oldIndex >= taskCount || newIndex < 0 || newIndex >= taskCount) {
    return appState;
  }

  Task t = appState.tasks[oldIndex];

  ListBuilder b = appState.tasks.toBuilder();
  b.removeAt(oldIndex);
  b.insert(newIndex, t);

  return AppState(tasks: b.build());
}