import 'package:ui_kurs/types/data/task.dart';
import 'package:ui_kurs/widgets/models/app-state.dart';

List<Task> taskListSelector(AppState state) => state.tasks;