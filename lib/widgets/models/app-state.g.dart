// GENERATED CODE - DO NOT MODIFY BY HAND

part of appstate;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AppState> _$appStateSerializer = new _$AppStateSerializer();

class _$AppStateSerializer implements StructuredSerializer<AppState> {
  @override
  final Iterable<Type> types = const [AppState, _$AppState];
  @override
  final String wireName = 'AppState';

  @override
  Iterable serialize(Serializers serializers, AppState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'tasks',
      serializers.serialize(object.tasks,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Task)])),
      'users',
      serializers.serialize(object.users,
          specifiedType:
              const FullType(BuiltList, const [const FullType(User)])),
    ];
    if (object.currentUser != null) {
      result
        ..add('currentUser')
        ..add(serializers.serialize(object.currentUser,
            specifiedType: const FullType(User)));
    }

    return result;
  }

  @override
  AppState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AppStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'currentUser':
          result.currentUser.replace(serializers.deserialize(value,
              specifiedType: const FullType(User)) as User);
          break;
        case 'tasks':
          result.tasks.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Task)]))
              as BuiltList);
          break;
        case 'users':
          result.users.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(User)]))
              as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$AppState extends AppState {
  @override
  final User currentUser;
  @override
  final BuiltList<Task> tasks;
  @override
  final BuiltList<User> users;

  factory _$AppState([void updates(AppStateBuilder b)]) =>
      (new AppStateBuilder()..update(updates)).build();

  _$AppState._({this.currentUser, this.tasks, this.users}) : super._() {
    if (tasks == null) {
      throw new BuiltValueNullFieldError('AppState', 'tasks');
    }
    if (users == null) {
      throw new BuiltValueNullFieldError('AppState', 'users');
    }
  }

  @override
  AppState rebuild(void updates(AppStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  AppStateBuilder toBuilder() => new AppStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppState &&
        currentUser == other.currentUser &&
        tasks == other.tasks &&
        users == other.users;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, currentUser.hashCode), tasks.hashCode), users.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppState')
          ..add('currentUser', currentUser)
          ..add('tasks', tasks)
          ..add('users', users))
        .toString();
  }
}

class AppStateBuilder implements Builder<AppState, AppStateBuilder> {
  _$AppState _$v;

  UserBuilder _currentUser;
  UserBuilder get currentUser => _$this._currentUser ??= new UserBuilder();
  set currentUser(UserBuilder currentUser) => _$this._currentUser = currentUser;

  ListBuilder<Task> _tasks;
  ListBuilder<Task> get tasks => _$this._tasks ??= new ListBuilder<Task>();
  set tasks(ListBuilder<Task> tasks) => _$this._tasks = tasks;

  ListBuilder<User> _users;
  ListBuilder<User> get users => _$this._users ??= new ListBuilder<User>();
  set users(ListBuilder<User> users) => _$this._users = users;

  AppStateBuilder();

  AppStateBuilder get _$this {
    if (_$v != null) {
      _currentUser = _$v.currentUser?.toBuilder();
      _tasks = _$v.tasks?.toBuilder();
      _users = _$v.users?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$AppState;
  }

  @override
  void update(void updates(AppStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$AppState build() {
    _$AppState _$result;
    try {
      _$result = _$v ??
          new _$AppState._(
              currentUser: _currentUser?.build(),
              tasks: tasks.build(),
              users: users.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'currentUser';
        _currentUser?.build();
        _$failedField = 'tasks';
        tasks.build();
        _$failedField = 'users';
        users.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'AppState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
