import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ui_kurs/types/redux/actions/task-actions.dart';
import 'package:ui_kurs/widgets/models/app-state.dart';

class SignOutTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, OnSignOut>(
        converter: (store) {
          return (tasks) =>
            store.dispatch(SignOutAction(tasks));
    }, builder: (context, callback) {
      return new _SignOutTile(callback);
    });
  }
}

typedef OnSignOut = Function(BuildContext context);

class _SignOutTile extends StatelessWidget {
  _SignOutTile(this.signOutCallback);

  final OnSignOut signOutCallback;

  @override
  Widget build(BuildContext context) {
    return 
      ListTile(
        title: Text('Выйти'),
        onTap: () {
          signOutCallback(context);
        },
      );
  }
}