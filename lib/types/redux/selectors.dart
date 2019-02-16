import 'package:built_collection/built_collection.dart';
import 'package:ui_kurs/types/app/user.dart';
import 'package:ui_kurs/types/data/task.dart';
import 'package:ui_kurs/widgets/models/app-state.dart';

// TODO: use selectors and split them by type

BuiltList<Task> taskListSelector(AppState state) => state.tasks;
List<User> getAllUsers(AppState state) => state.users.toList();

List<Task> getUserTasks(AppState state) {
  final currentUser = state.currentUser;

  // TODO: work with user's id
  String email;
  if (currentUser != null) {
    email = currentUser.email;
  }

  return state.tasks.toList().where((Task test) => test.executor == email).toList();
}