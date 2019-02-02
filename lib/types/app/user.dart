import 'package:ui_kurs/types/data/group.dart';

enum AuthType {
  REGISTER,
  LOGIN,
  WITHOUT
}

class User {
  User({this.email = '', this.name = '', this.pass = ''});

  final String email;
  final String name;
  final String pass;
  final List<Group> groups = List<Group>();
}