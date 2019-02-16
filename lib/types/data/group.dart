import 'package:ui_kurs/types/app/user.dart';
import 'package:uuid/uuid.dart';

// TODO: built immutability
class Group {
  Group({
    this.title,
    this.creator,
  });

  static generateId() {
    return 'G' + Uuid().v4().toString();
  }

  final String id = Group.generateId();
  final String title;
  final User creator;
  final List<User> users = List<User>();
}