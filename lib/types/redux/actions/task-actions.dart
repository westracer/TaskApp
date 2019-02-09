import 'package:ui_kurs/types/data/task.dart';

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

class LoadTaskListAction {
  LoadTaskListAction();
}

class SaveTaskListAction {
  SaveTaskListAction();
}

class LoadTaskListSuccessAction {
  LoadTaskListSuccessAction(this.jsonString);

  final String jsonString;
}

class MoveTaskAction {
  MoveTaskAction(this.oldIndex, this.newIndex);

  final int oldIndex;
  final int newIndex;
}