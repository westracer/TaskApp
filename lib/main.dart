import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_kurs/types/routes.dart';
import 'package:ui_kurs/widgets/pages/start-page.dart';
import 'package:ui_kurs/widgets/pages/task-list-page.dart';

void main() => 
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(new MyApp());
  });

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.welcome,
      routes: {
        Routes.welcome: (context) => StartPage(),
        Routes.taskList: (context) => TaskListPage(),
      },
      title: 'Task App',
    );
  }
}