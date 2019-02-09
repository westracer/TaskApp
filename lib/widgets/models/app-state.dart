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

  // TODO: meh
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

  static AppState getInitialState() {
    final parentTask = Task((b) => b..title = 'parent task');
    final parentTask2 = Task((b) => b..title = 'parent task 2');
    final childTask = Task((b) => b..title = 'child task depth 1'..parentId = parentTask.id);

    final list = [
      parentTask, 
      Task((b) => b..parentId = parentTask.id..title = 'child task'),
      Task((b) => b..parentId = parentTask2.id..title = 'child task 1'),
      Task((b) => b..parentId = parentTask2.id..title = 'child task 2'),
      Task((b) => b..parentId = childTask.id..title = 'child task depth 2'),
      childTask,
      parentTask2,
    ];

    return AppState(
      currentUser: null,
      groups: [],
      tasks: BuiltList.from(list)
    );
  }
}