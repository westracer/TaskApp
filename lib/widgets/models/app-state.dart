library appstate;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ui_kurs/types/app/user.dart';
import 'package:ui_kurs/types/data/task.dart';

part 'app-state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  @nullable
  User get currentUser;

  BuiltList<Task> get tasks;
  BuiltList<User> get users;

  // TODO: meh
  AppState replaceTask(Task newTask, Task oldTask) {
    ListBuilder listBuilder = this.tasks.toBuilder();
    int oldTaskIndex = this.tasks.indexWhere((Task test) { return test.id == oldTask.id; });
    if (oldTaskIndex != -1) {
      listBuilder.replaceRange(oldTaskIndex, oldTaskIndex + 1, BuiltList<Task>([newTask]));
    }

    final BuiltList<Task> newList = listBuilder.build();

    return this.rebuild((b) => b..tasks = newList.toBuilder());
  }

  static AppState getInitialState() {
    final users = [
      User((b) => b..email = 'user1@'..name = 'user1'..pass = 'user1'),
      User((b) => b..email = 'user2@'..name = 'user2'..pass = 'user2'),
      User((b) => b..email = 'user3@'..name = 'user3'..pass = 'user3'),
    ];


    List<Task> allTasks = List();

    for (final user in users) {
      final parentTask = Task((b) => b..executor = user.email..title = 'Задача' + ' для ' + user.name);
      final parentTask2 = Task((b) => b..executor = user.email..title = 'Задача 2' + ' для ' + user.name);
      final childTask = Task((b) => b..executor = user.email..title = 'Подзадача уровня 1' + ' для ' + user.name..parentId = parentTask.id);

      final listForUser = [
        parentTask, 
        Task((b) => b..executor = user.email..parentId = parentTask.id..title = 'Подзадача' + ' для ' + user.name),
        Task((b) => b..executor = user.email..parentId = parentTask2.id..title = 'Подзадача 1' + ' для ' + user.name),
        Task((b) => b..executor = user.email..parentId = parentTask2.id..title = 'Подзадача 2' + ' для ' + user.name),
        Task((b) => b..executor = user.email..parentId = childTask.id..title = 'Подзадача уровня 2' + ' для ' + user.name),
        childTask,
        parentTask2,
      ];

      allTasks.addAll(listForUser);
    }

    return AppState((b) => b
      ..users = BuiltList<User>.from(users).toBuilder()
      ..tasks = BuiltList<Task>.from(allTasks).toBuilder()
    );
  }

  AppState._();
  static Serializer<AppState> get serializer => _$appStateSerializer;
  factory AppState([updates(AppStateBuilder b)]) => _$AppState((b) => b..update(updates));
}