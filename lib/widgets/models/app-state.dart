import 'package:built_collection/built_collection.dart';
import 'package:ui_kurs/types/app/user.dart';
import 'package:ui_kurs/types/data/group.dart';
import 'package:ui_kurs/types/data/task.dart';

// TODO: built_value immutability
class AppState {
  AppState({this.currentUser, this.tasks, this.groups});

  final User currentUser;
  final BuiltList<Task> tasks;
  final List<Group> groups;

  AppState replaceTask(Task newTask, Task oldTask) {
    ListBuilder listBuilder = this.tasks.toBuilder();
    int oldTaskIndex = this.tasks.indexWhere((Task test) { return test.id == oldTask.id; });
    if (oldTaskIndex != -1) {
      listBuilder.replaceRange(oldTaskIndex, oldTaskIndex + 1, BuiltList<Task>([newTask]));
    }

    return AppState(
      currentUser: this.currentUser,
      groups: this.groups,
      tasks: listBuilder.build()
    );
  }
}