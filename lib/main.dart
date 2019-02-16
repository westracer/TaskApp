import 'dart:convert';

import 'package:built_value/serializer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_kurs/types/app/routes.dart';
import 'package:ui_kurs/types/app/storage.dart';
import 'package:ui_kurs/types/data/serializers.dart';
import 'package:ui_kurs/types/redux/middlewares.dart';
import 'package:ui_kurs/widgets/models/app-state.dart';
import 'package:ui_kurs/widgets/pages/add-task-page.dart';
import 'package:ui_kurs/widgets/pages/confirm-page.dart';
import 'package:ui_kurs/widgets/pages/error-page.dart';
import 'package:ui_kurs/widgets/pages/login-page.dart';
import 'package:ui_kurs/widgets/pages/start-page.dart';
import 'package:ui_kurs/widgets/pages/task-list-page.dart';
import 'package:ui_kurs/widgets/pages/task-detail-page.dart';
import 'package:ui_kurs/types/redux/reducers.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';

Future<void> main() async {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) async {
    final AppState loadedState = await _loadState();
    final AppState state = loadedState != null ? loadedState : AppState.getInitialState();

    final store = DevToolsStore<AppState>(
      appReducers,
      initialState: state,
      middleware: createAllMiddleware()
    );

    runApp(ReduxApp(store, true));
  });
}

Future<AppState> _loadState() async {
  try {
    String jsonString = await Storage.readString(LocalFiles.APP_STATE);
    final Object obj = json.decode(jsonString);
    final specifiedType = const FullType(AppState);
    AppState newState = serializers.deserialize(obj, specifiedType: specifiedType);
    return newState;
  } catch (e) {
    return null;
  }
}

class ReduxApp extends StatelessWidget {
  ReduxApp(this.store, this.loggedIn);
  
  final DevToolsStore<AppState> store;
  final bool loggedIn;

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MyApp(store, loggedIn)
    );
  }
}

class MyApp extends StatelessWidget {
  MyApp(this.store, this.loggedIn);

  final DevToolsStore<AppState> store;
  final bool loggedIn;
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // TODO: initialRoute splash screen
      initialRoute: Routes.welcome,
      routes: {
        Routes.welcome: (context) => StartPage(),
        Routes.taskList: (context) => TaskListPage(store),
        Routes.taskCreate: (context) => AddTaskPage(),
        Routes.taskDetail: (context) => TaskDetailPage(),
        Routes.confirm: (context) => ConfirmPage(),
        Routes.error: (context) => ErrorPage(),
        Routes.login: (context) => LoginPage(),
      },
      title: 'Task App',
    );
  }
}