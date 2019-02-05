import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:redux/redux.dart';
import 'package:ui_kurs/types/app/storage.dart';
import 'package:ui_kurs/types/data/serializers.dart';
import 'package:ui_kurs/types/data/task.dart';
import 'package:ui_kurs/types/redux/actions/task-actions.dart';
import 'package:ui_kurs/types/redux/selectors.dart';
import 'package:ui_kurs/widgets/models/app-state.dart';

List<Middleware<AppState>> createAllMiddleware() {
  final List<Middleware<AppState>> middlewareList = [
      // TODO: uncomment later
      // new TypedMiddleware<AppState, AddTasksAction>(_taskListSave()),
      // new TypedMiddleware<AppState, ToggleDoneTaskAction>(_taskListSave()),
      new TypedMiddleware<AppState, SaveTaskListAction>(_taskListSave()),
      new TypedMiddleware<AppState, LoadTaskListAction>(_loadList()),
  ];

  return middlewareList;
}

Middleware<AppState> _taskListSave() {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);

    final BuiltList<Task> taskList = taskListSelector(store.state);

    final specifiedType = const FullType(BuiltList, const [const FullType(Task)]);
    String jsonString = json.encode(serializers.serialize(taskList, specifiedType: specifiedType));

    Storage.writeString(jsonString, LocalFiles.TASKS);
  };
}

Middleware<AppState> _loadList() {
  return (Store<AppState> store, action, NextDispatcher next) {
    Storage.readString(LocalFiles.TASKS).then((String str) {
      store.dispatch(LoadTaskListSuccessAction(str));
    }).catchError(() { });
  };
}
