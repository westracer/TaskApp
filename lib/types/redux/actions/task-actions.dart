import 'package:flutter/widgets.dart';
import 'package:ui_kurs/types/app/user.dart';
import 'package:ui_kurs/types/data/task.dart';
import 'package:ui_kurs/widgets/models/app-state.dart';

class AddTasksAction {
  AddTasksAction(this.tasks);

  final List<Task> tasks;
}

class EditTaskAction {
  EditTaskAction(this.task);

  final Task task;
}

class RemoveTaskAction {
  RemoveTaskAction(this.id);

  final String id;
}

class ToggleDoneTaskAction {
  ToggleDoneTaskAction(this.task);

  final Task task;
}

class LoadAppStateAction {
  LoadAppStateAction();
}

class ReplaceAppStateAction {
  ReplaceAppStateAction(this.appState);

  final AppState appState;
}

class SaveAppStateAction {
  SaveAppStateAction();
}

class LoadAppStateSuccessAction {
  LoadAppStateSuccessAction(this.jsonString);

  final String jsonString;
}

class MoveTaskAction {
  MoveTaskAction(this.oldIndex, this.newIndex);

  final int oldIndex;
  final int newIndex;
}

class SignInAction {
  SignInAction(this.context, this.user);

  final User user;
  final BuildContext context;
}

class SignUpAction {
  SignUpAction(this.context, this.user);

  final User user;
  final BuildContext context;
}

class SignOutAction {
  SignOutAction(this.context);

  final BuildContext context;
}

class InitialStateAction {
  InitialStateAction();
}