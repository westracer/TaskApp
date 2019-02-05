import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ui_kurs/types/redux/actions/task-actions.dart';
import 'package:ui_kurs/widgets/models/app-state.dart';

class SaveTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, OnSaveToStorage>(
        converter: (store) {
          return () =>
            store.dispatch(SaveTaskListAction());
    }, builder: (context, callback) {
      return new _SaveTile(callback);
    });
  }
}

typedef OnSaveToStorage = Function();

class _SaveTile extends StatelessWidget {
  _SaveTile(this.saveCallback);

  final OnSaveToStorage saveCallback;

  @override
  Widget build(BuildContext context) {
    return 
      ListTile(
        title: Text('Сохранить в память'),
        onTap: () async {
          saveCallback();

          Navigator.pop(context);
        },
      );
  }
}