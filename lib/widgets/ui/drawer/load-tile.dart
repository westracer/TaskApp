import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ui_kurs/types/redux/actions/task-actions.dart';
import 'package:ui_kurs/widgets/models/app-state.dart';

class LoadTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, OnLoadFromStorage>(
        converter: (store) {
          return () =>
            store.dispatch(LoadTaskListAction());
    }, builder: (context, callback) {
      return new _LoadTile(callback);
    });
  }
}

typedef OnLoadFromStorage = Function();

class _LoadTile extends StatelessWidget {
  _LoadTile(this.loadCallback);

  final OnLoadFromStorage loadCallback;

  @override
  Widget build(BuildContext context) {
    return 
      ListTile(
        title: Text('Загрузить из памяти'),
        onTap: () async {
          loadCallback();

          Navigator.pop(context);
        },
      );
  }
}