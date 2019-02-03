import 'package:ui_kurs/types/data/task.dart';

class CreateTaskAction {
  CreateTaskAction(this.task);

  final Task task;
}

class EditTaskAction {
  EditTaskAction(this.task);

  final Task task;
}

class ToggleDoneTaskAction {
  ToggleDoneTaskAction(this.task);

  final Task task;
}