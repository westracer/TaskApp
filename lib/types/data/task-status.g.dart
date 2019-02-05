// GENERATED CODE - DO NOT MODIFY BY HAND

part of enums;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TaskStatus _$NEW = const TaskStatus._('NEW');
const TaskStatus _$WIP = const TaskStatus._('WIP');
const TaskStatus _$PROBLEM = const TaskStatus._('PROBLEM');
const TaskStatus _$POSTPONED = const TaskStatus._('POSTPONED');
const TaskStatus _$DONE = const TaskStatus._('DONE');

TaskStatus _$valueOf(String name) {
  switch (name) {
    case 'NEW':
      return _$NEW;
    case 'WIP':
      return _$WIP;
    case 'PROBLEM':
      return _$PROBLEM;
    case 'POSTPONED':
      return _$POSTPONED;
    case 'DONE':
      return _$DONE;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<TaskStatus> _$values =
    new BuiltSet<TaskStatus>(const <TaskStatus>[
  _$NEW,
  _$WIP,
  _$PROBLEM,
  _$POSTPONED,
  _$DONE,
]);

Serializer<TaskStatus> _$taskStatusSerializer = new _$TaskStatusSerializer();

class _$TaskStatusSerializer implements PrimitiveSerializer<TaskStatus> {
  @override
  final Iterable<Type> types = const <Type>[TaskStatus];
  @override
  final String wireName = 'TaskStatus';

  @override
  Object serialize(Serializers serializers, TaskStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  TaskStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TaskStatus.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
