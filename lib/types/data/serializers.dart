library serializers;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:ui_kurs/types/app/user.dart';
import 'package:ui_kurs/types/data/task.dart';
import 'package:ui_kurs/types/data/task-status.dart';
import 'package:ui_kurs/widgets/models/app-state.dart';

part 'serializers.g.dart';

@SerializersFor(const [Task, TaskStatus, User, AppState])
final Serializers serializers = _$serializers = (_$serializers.toBuilder()
  ..addBuilderFactory(
    const FullType(
      BuiltList, const [const FullType(Task)]),
      () => new ListBuilder<Task>()
    )
  ..addBuilderFactory(
    const FullType(
      BuiltList, const [const FullType(User)]),
      () => new ListBuilder<User>()
    )
  )
  .build();