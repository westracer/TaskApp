import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ui_kurs/types/data/task.dart';
import 'package:ui_kurs/types/redux/actions/task-actions.dart';
import 'package:ui_kurs/widgets/models/app-state.dart';

class InitialStateTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, OnInitialStateCallback>(
        converter: (store) {
          return () =>
            store.dispatch(InitialStateAction());
    }, builder: (context, callback) {
      return new _InitialStateTile(callback);
    });
  }
}

typedef OnInitialStateCallback = Function();

class _InitialStateTile extends StatelessWidget {
  _InitialStateTile(this.addCallback);

  final OnInitialStateCallback addCallback;

  @override
  Widget build(BuildContext context) {
    return 
      ListTile(
        title: Text('initial state'),
        onTap: () async {
          addCallback();

          Navigator.pop(context);
        },
      );
  }
}