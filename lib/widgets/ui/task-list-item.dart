import 'package:flutter/widgets.dart';
import 'package:ui_kurs/types/data/task.dart';

class TastListItem extends StatelessWidget {
  TastListItem(this.task);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Text(task.id);
  }
}