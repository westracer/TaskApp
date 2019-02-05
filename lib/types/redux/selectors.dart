import 'package:built_collection/built_collection.dart';
import 'package:ui_kurs/types/data/task.dart';
import 'package:ui_kurs/widgets/models/app-state.dart';

BuiltList<Task> taskListSelector(AppState state) => state.tasks;