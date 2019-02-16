import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_kurs/types/app/routes.dart';
import 'package:ui_kurs/types/app/user.dart';
import 'package:ui_kurs/types/data/serializers.dart';
import 'package:ui_kurs/types/data/task.dart';
import 'package:ui_kurs/types/redux/actions/task-actions.dart';
import 'package:ui_kurs/widgets/models/app-state.dart';
import 'package:ui_kurs/widgets/pages/error-page.dart';

AppState appReducers(AppState appState, dynamic action) {
  // TODO: split actions by type
  if (action is AddTasksAction) {
    return addItem(appState, action);
  } else if (action is ToggleDoneTaskAction) {
    return toggleDoneItem(appState, action);
  } else if (action is LoadAppStateSuccessAction) {
    return loadAppStateSuccess(appState, action);
  } else if (action is MoveTaskAction) {
    return moveTask(appState, action);
  } else if (action is RemoveTaskAction) {
    return removeTask(appState, action);
  } else if (action is EditTaskAction) {
    return editTask(appState, action);
  } else if (action is SignOutAction) {
    return signOut(appState, action);
  } else if (action is SignInAction) {
    return signIn(appState, action);
  } else if (action is SignUpAction) {
    return signUp(appState, action);
  } else if (action is ReplaceAppStateAction) {
    return replaceState(appState, action);
  } else if (action is InitialStateAction) {
    return setInitialState(appState, action);
  }

  return appState;
}

AppState addItem(AppState appState, AddTasksAction action) {
  List<Task> createdTasks = action.tasks;
  
  final newTasks = appState.tasks.rebuild((b) => b.addAll(createdTasks));

  return appState.rebuild((b) => b..tasks = newTasks.toBuilder());
}

AppState removeTask(AppState appState, RemoveTaskAction action) {
  final newTasks = appState.tasks.rebuild((b) => b.removeWhere((Task test) => test.id == action.id));

  return appState.rebuild((b) => b..tasks = newTasks.toBuilder());
}

AppState editTask(AppState appState, EditTaskAction action) {
  return appState.replaceTask(action.task, action.task);
}

AppState toggleDoneItem(AppState appState, ToggleDoneTaskAction action) {
  final Task newTask = action.task.toggleStatusDone();

  return appState.replaceTask(newTask, action.task);
}

AppState replaceState(_, ReplaceAppStateAction action) {
  return action.appState;
}

AppState loadAppStateSuccess(AppState appState, LoadAppStateSuccessAction action) {
  if (action.jsonString == null) return appState;

  try {
    final Object obj = json.decode(action.jsonString);
    final specifiedType = const FullType(AppState);
    AppState newState = serializers.deserialize(obj, specifiedType: specifiedType);
    return newState;
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

  // TODO: if moving to different depth item, get same depth item
  ListBuilder<Task> lb = appState.tasks.toBuilder();
  lb[oldIndex] = lb[newIndex];
  lb[newIndex] = t;

  return appState.rebuild((b) => b..tasks = lb);
}

AppState signOut(AppState appState, SignOutAction action) {
  Navigator.popUntil(action.context, ModalRoute.withName(Routes.taskList));
  Navigator.pushReplacementNamed(action.context, Routes.welcome);

  return appState.rebuild((b) => b..currentUser = null);
}

AppState signIn(AppState appState, SignInAction action) {
  User entered = action.user;
  int userIndex = appState.users.indexWhere(
    (User test) {
      bool passMatch = test.pass == entered.pass;
      bool emailMatch = test.email.toLowerCase() == entered.email.toLowerCase();

      return emailMatch && passMatch;
    }
  );

  User newUser;
  if (userIndex == -1) {
    Navigator.of(action.context).push(
      MaterialPageRoute(
        settings: RouteSettings(name: Routes.error), 
        builder: (context) => ErrorPage(
          goBack: () {
            Navigator.pop(context);
          },
          errorText: 'Введены некорретные данные'
        ),
      ),
    );
  } else {
    newUser = appState.users[userIndex];

    Navigator.popUntil(action.context, ModalRoute.withName(Routes.welcome));
    Navigator.pushReplacementNamed(action.context, Routes.taskList);
  }

  return appState.rebuild((b) => b..currentUser = newUser != null ? newUser.toBuilder() : null);
}

AppState signUp(AppState appState, SignUpAction action) {
  User newUser = action.user;
  AppStateBuilder b = appState.toBuilder();
  b.currentUser = newUser.toBuilder();
  b.users = appState.users.toBuilder();
  b.users.add(newUser);

  Navigator.popUntil(action.context, ModalRoute.withName(Routes.welcome));
  Navigator.pushReplacementNamed(action.context, Routes.taskList);

  return b.build();
}

AppState setInitialState(AppState appState, InitialStateAction action) {
  return AppState.getInitialState().rebuild((b) => b..currentUser = appState.currentUser != null ? appState.currentUser.toBuilder() : null);
}