library user;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user.g.dart';

enum AuthType {
  REGISTER,
  LOGIN,
  WITHOUT
}

abstract class User implements Built<User, UserBuilder> {
  String get email;
  String get name;
  String get pass;

  User._();
  static Serializer<User> get serializer => _$userSerializer;
  factory User([updates(UserBuilder b)]) => _$User((b) => b..update(updates));
}