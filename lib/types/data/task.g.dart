// GENERATED CODE - DO NOT MODIFY BY HAND

part of task;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Task> _$taskSerializer = new _$TaskSerializer();

class _$TaskSerializer implements StructuredSerializer<Task> {
  @override
  final Iterable<Type> types = const [Task, _$Task];
  @override
  final String wireName = 'Task';

  @override
  Iterable serialize(Serializers serializers, Task object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'status',
      serializers.serialize(object.status,
          specifiedType: const FullType(TaskStatus)),
      'plannedTime',
      serializers.serialize(object.plannedTime,
          specifiedType: const FullType(int)),
      'timeSpent',
      serializers.serialize(object.timeSpent,
          specifiedType: const FullType(int)),
    ];
    if (object.description != null) {
      result
        ..add('description')
        ..add(serializers.serialize(object.description,
            specifiedType: const FullType(String)));
    }
    if (object.dateTime != null) {
      result
        ..add('dateTime')
        ..add(serializers.serialize(object.dateTime,
            specifiedType: const FullType(DateTime)));
    }
    if (object.executor != null) {
      result
        ..add('executor')
        ..add(serializers.serialize(object.executor,
            specifiedType: const FullType(User)));
    }
    if (object.creator != null) {
      result
        ..add('creator')
        ..add(serializers.serialize(object.creator,
            specifiedType: const FullType(User)));
    }
    if (object.parentId != null) {
      result
        ..add('parentId')
        ..add(serializers.serialize(object.parentId,
            specifiedType: const FullType(String)));
    }
    if (object.groupId != null) {
      result
        ..add('groupId')
        ..add(serializers.serialize(object.groupId,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  Task deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TaskBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'dateTime':
          result.dateTime = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'executor':
          result.executor = serializers.deserialize(value,
              specifiedType: const FullType(User)) as User;
          break;
        case 'creator':
          result.creator = serializers.deserialize(value,
              specifiedType: const FullType(User)) as User;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(TaskStatus)) as TaskStatus;
          break;
        case 'parentId':
          result.parentId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'plannedTime':
          result.plannedTime = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'timeSpent':
          result.timeSpent = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'groupId':
          result.groupId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Task extends Task {
  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final DateTime dateTime;
  @override
  final User executor;
  @override
  final User creator;
  @override
  final TaskStatus status;
  @override
  final String parentId;
  @override
  final int plannedTime;
  @override
  final int timeSpent;
  @override
  final String groupId;

  factory _$Task([void updates(TaskBuilder b)]) =>
      (new TaskBuilder()..update(updates)).build();

  _$Task._(
      {this.id,
      this.title,
      this.description,
      this.dateTime,
      this.executor,
      this.creator,
      this.status,
      this.parentId,
      this.plannedTime,
      this.timeSpent,
      this.groupId})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('Task', 'id');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('Task', 'title');
    }
    if (status == null) {
      throw new BuiltValueNullFieldError('Task', 'status');
    }
    if (plannedTime == null) {
      throw new BuiltValueNullFieldError('Task', 'plannedTime');
    }
    if (timeSpent == null) {
      throw new BuiltValueNullFieldError('Task', 'timeSpent');
    }
  }

  @override
  Task rebuild(void updates(TaskBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  TaskBuilder toBuilder() => new TaskBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Task &&
        id == other.id &&
        title == other.title &&
        description == other.description &&
        dateTime == other.dateTime &&
        executor == other.executor &&
        creator == other.creator &&
        status == other.status &&
        parentId == other.parentId &&
        plannedTime == other.plannedTime &&
        timeSpent == other.timeSpent &&
        groupId == other.groupId;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc($jc(0, id.hashCode),
                                            title.hashCode),
                                        description.hashCode),
                                    dateTime.hashCode),
                                executor.hashCode),
                            creator.hashCode),
                        status.hashCode),
                    parentId.hashCode),
                plannedTime.hashCode),
            timeSpent.hashCode),
        groupId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Task')
          ..add('id', id)
          ..add('title', title)
          ..add('description', description)
          ..add('dateTime', dateTime)
          ..add('executor', executor)
          ..add('creator', creator)
          ..add('status', status)
          ..add('parentId', parentId)
          ..add('plannedTime', plannedTime)
          ..add('timeSpent', timeSpent)
          ..add('groupId', groupId))
        .toString();
  }
}

class TaskBuilder implements Builder<Task, TaskBuilder> {
  _$Task _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  DateTime _dateTime;
  DateTime get dateTime => _$this._dateTime;
  set dateTime(DateTime dateTime) => _$this._dateTime = dateTime;

  User _executor;
  User get executor => _$this._executor;
  set executor(User executor) => _$this._executor = executor;

  User _creator;
  User get creator => _$this._creator;
  set creator(User creator) => _$this._creator = creator;

  TaskStatus _status;
  TaskStatus get status => _$this._status;
  set status(TaskStatus status) => _$this._status = status;

  String _parentId;
  String get parentId => _$this._parentId;
  set parentId(String parentId) => _$this._parentId = parentId;

  int _plannedTime;
  int get plannedTime => _$this._plannedTime;
  set plannedTime(int plannedTime) => _$this._plannedTime = plannedTime;

  int _timeSpent;
  int get timeSpent => _$this._timeSpent;
  set timeSpent(int timeSpent) => _$this._timeSpent = timeSpent;

  String _groupId;
  String get groupId => _$this._groupId;
  set groupId(String groupId) => _$this._groupId = groupId;

  TaskBuilder();

  TaskBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _title = _$v.title;
      _description = _$v.description;
      _dateTime = _$v.dateTime;
      _executor = _$v.executor;
      _creator = _$v.creator;
      _status = _$v.status;
      _parentId = _$v.parentId;
      _plannedTime = _$v.plannedTime;
      _timeSpent = _$v.timeSpent;
      _groupId = _$v.groupId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Task other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Task;
  }

  @override
  void update(void updates(TaskBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Task build() {
    final _$result = _$v ??
        new _$Task._(
            id: id,
            title: title,
            description: description,
            dateTime: dateTime,
            executor: executor,
            creator: creator,
            status: status,
            parentId: parentId,
            plannedTime: plannedTime,
            timeSpent: timeSpent,
            groupId: groupId);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
