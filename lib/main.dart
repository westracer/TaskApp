import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redux/redux.dart';
import 'package:ui_kurs/types/app/routes.dart';
import 'package:ui_kurs/types/data/task.dart';
import 'package:ui_kurs/types/redux/middlewares.dart';
import 'package:ui_kurs/widgets/models/app-state.dart';
import 'package:ui_kurs/widgets/pages/add-task-page.dart';
import 'package:ui_kurs/widgets/pages/start-page.dart';
import 'package:ui_kurs/widgets/pages/task-list-page.dart';
import 'package:ui_kurs/types/redux/reducers.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';

void main() => 
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    final store = DevToolsStore<AppState>(
      appReducers,
      initialState: AppState(tasks: [Task((b) => b..title = 'task 1'), Task((b) => b..title = 'task 2')]),
      // middleware: createAllMiddleware()
    );

    runApp(ReduxApp(store));
  });

class ReduxApp extends StatelessWidget {
  final DevToolsStore<AppState> store;

  ReduxApp(this.store);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MyApp(store)
    );
  }
}

class MyApp extends StatelessWidget {
  MyApp(this.store);

  final DevToolsStore store;
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.welcome,
      routes: {
        Routes.welcome: (context) => StartPage(),
        Routes.taskList: (context) => TaskListPage(store),
        Routes.taskCreate: (context) => AddTaskPage(),
      },
      title: 'Task App',
    );
  }
}