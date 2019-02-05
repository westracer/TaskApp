library enums;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'task-status.g.dart';

class TaskStatus extends EnumClass {
  static Serializer<TaskStatus> get serializer => _$taskStatusSerializer;
  
  static const List<TaskStatus> ALL_STATUSES = [TaskStatus.NEW, TaskStatus.WIP, TaskStatus.POSTPONED, TaskStatus.PROBLEM, TaskStatus.DONE];

  static final Map<TaskStatus, String> taskStatusNames = Map.from({
    TaskStatus.NEW: 'Новая',
    TaskStatus.WIP: 'В работе',
    TaskStatus.POSTPONED: 'Отложена',
    TaskStatus.PROBLEM: 'Проблема',
    TaskStatus.DONE: 'Завершена',
  });

  static const TaskStatus NEW = _$NEW;
  static const TaskStatus WIP = _$WIP;
  static const TaskStatus PROBLEM = _$PROBLEM;
  static const TaskStatus POSTPONED = _$POSTPONED;
  static const TaskStatus DONE = _$DONE;

  const TaskStatus._(String name) : super(name);

  static BuiltSet<TaskStatus> get values => _$values;
  static TaskStatus valueOf(String name) => _$valueOf(name);
}