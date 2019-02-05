library serializers;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:ui_kurs/types/data/task.dart';
import 'package:ui_kurs/types/data/task-status.dart';

part 'serializers.g.dart';

@SerializersFor(const [Task, TaskStatus])
final Serializers serializers = _$serializers = (_$serializers.toBuilder()
  ..addBuilderFactory(
    const FullType(
      BuiltList, const [const FullType(Task)]),
      () => new ListBuilder<Task>()
    )
  )
  .build();