import 'package:ui_kurs/types/app/user.dart';
import 'package:ui_kurs/types/data/group.dart';
import 'package:ui_kurs/types/data/task.dart';

class AppState {
  AppState({this.currentUser = null, this.tasks, this.groups});

  final User currentUser;
  final List<Task> tasks;
  final List<Group> groups;
}