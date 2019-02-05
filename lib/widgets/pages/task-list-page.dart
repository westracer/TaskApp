import 'package:flutter/material.dart';
import 'package:flutter_redux_dev_tools/flutter_redux_dev_tools.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';
import 'package:ui_kurs/layout/colors.dart';
import 'package:ui_kurs/types/app/routes.dart';
import 'package:ui_kurs/widgets/models/app-state.dart';
import 'package:ui_kurs/widgets/ui/big-round-button.dart';
import 'package:ui_kurs/widgets/ui/custom-app-bar.dart';
import 'package:ui_kurs/widgets/ui/drawer.dart';
import 'package:ui_kurs/widgets/ui/task-list.dart';

class TaskListPage extends StatelessWidget {
  TaskListPage(this.store);

  final DevToolsStore store;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar('Ваши задачи'),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: TaskList(),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: BigRoundButton(
                text: '+ Создать',
                normalColors: BigRoundButtonColors(color: CustomColors.violet, borderColor: CustomColors.violet, textColor: Colors.white),
                onClick: () {
                  Navigator.pushNamed(context, Routes.taskCreate);
                },
              ),
            ),
          ],
        ),
      ),
      drawer: CustomDrawer(),
      endDrawer: ReduxDevTools<AppState>(this.store),
    );
  }
}