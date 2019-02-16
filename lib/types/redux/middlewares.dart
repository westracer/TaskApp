import 'dart:convert';

import 'package:built_value/serializer.dart';
import 'package:redux/redux.dart';
import 'package:ui_kurs/types/app/storage.dart';
import 'package:ui_kurs/types/data/serializers.dart';
import 'package:ui_kurs/types/redux/actions/task-actions.dart';
import 'package:ui_kurs/widgets/models/app-state.dart';

List<Middleware<AppState>> createAllMiddleware() {
  final List<Middleware<AppState>> middlewareList = [
      // TODO: don't save it on every action
      new TypedMiddleware<AppState, AddTasksAction>(_saveState()),
      new TypedMiddleware<AppState, EditTaskAction>(_saveState()),
      new TypedMiddleware<AppState, RemoveTaskAction>(_saveState()),
      new TypedMiddleware<AppState, ToggleDoneTaskAction>(_saveState()),
      new TypedMiddleware<AppState, ReplaceAppStateAction>(_saveState()),
      new TypedMiddleware<AppState, MoveTaskAction>(_saveState()),
      new TypedMiddleware<AppState, SignInAction>(_saveState()),
      new TypedMiddleware<AppState, SignUpAction>(_saveState()),
      new TypedMiddleware<AppState, SignOutAction>(_saveState()),
      new TypedMiddleware<AppState, SaveAppStateAction>(_saveState()),
      new TypedMiddleware<AppState, LoadAppStateAction>(_loadState()),
  ];

  return middlewareList;
}

Middleware<AppState> _saveState() {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);

    final specifiedType = const FullType(AppState);
    String jsonString = json.encode(serializers.serialize(store.state, specifiedType: specifiedType));

    Storage.writeString(jsonString, LocalFiles.APP_STATE);
  };
}

Middleware<AppState> _loadState() {
  return (Store<AppState> store, action, NextDispatcher next) {
    Storage.readString(LocalFiles.APP_STATE).then((String str) {
      store.dispatch(LoadAppStateSuccessAction(str));
    }).catchError(() { });
  };
}
