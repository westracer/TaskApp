import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ui_kurs/types/data/task.dart';
import 'package:ui_kurs/types/redux/actions/task-actions.dart';
import 'package:ui_kurs/widgets/models/app-state.dart';

class GenerateTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, OnSaveToStorage>(
        converter: (store) {
          return (tasks) =>
            store.dispatch(AddTasksAction(tasks));
    }, builder: (context, callback) {
      return new _GenerateTile(callback);
    });
  }
}

typedef OnSaveToStorage = Function(List<Task> tasks);

class _GenerateTile extends StatelessWidget {
  _GenerateTile(this.addCallback);

  final OnSaveToStorage addCallback;

  @override
  Widget build(BuildContext context) {
    return 
      ListTile(
        title: Text('Сгенерировать 1000 задач'),
        onTap: () async {
          addCallback(Task.generateRandomTasks(howMany: 1000));

          Navigator.pop(context);
        },
      );
  }
}