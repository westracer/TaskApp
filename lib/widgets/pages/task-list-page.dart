import 'package:flutter/material.dart';
import 'package:flutter_redux_dev_tools/flutter_redux_dev_tools.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';
import 'package:ui_kurs/layout/colors.dart';
import 'package:ui_kurs/types/data/task.dart';
import 'package:ui_kurs/widgets/models/app-state.dart';
import 'package:ui_kurs/widgets/ui/task-list-item.dart';
import 'package:ui_kurs/widgets/ui/task-list.dart';

class TaskListPage extends StatelessWidget {
  TaskListPage(this.store);

  final DevToolsStore store;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.violet,
        title: Text('Ваши задачи'),
      ),
      body: TaskList(),
      endDrawer: ReduxDevTools<AppState>(this.store),
    );
  }
}