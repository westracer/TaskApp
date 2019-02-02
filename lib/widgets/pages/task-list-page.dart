import 'package:flutter/material.dart';
import 'package:ui_kurs/assets/icon_pack_icons.dart';
import 'package:ui_kurs/layout/colors.dart';
import 'package:ui_kurs/types/app/routes.dart';
import 'package:ui_kurs/widgets/ui/big-round-button.dart';

class TaskListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint('task-list');

    return Scaffold(
      appBar: AppBar(
        title: Text('task list'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40), 
        child: MaterialButton(
          child: Text('press'),
          onPressed: () {
            Navigator.pushReplacementNamed(context, Routes.welcome);
          }
        )
      ),
    );
  }
}