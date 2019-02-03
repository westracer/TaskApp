import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ui_kurs/assets/icon_pack_icons.dart';
import 'package:ui_kurs/layout/colors.dart';
import 'package:ui_kurs/types/app/routes.dart';
import 'package:ui_kurs/types/data/task.dart';
import 'package:ui_kurs/types/redux/actions/task-actions.dart';
import 'package:ui_kurs/widgets/models/app-state.dart';
import 'package:ui_kurs/widgets/ui/big-round-button.dart';
import 'package:ui_kurs/widgets/ui/custom-app-bar.dart';

class AddTaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, OnItemAddedCallback>(
        converter: (store) {
          return (itemName) =>
            store.dispatch(CreateTaskAction(Task((b) => b..title = itemName)));
    }, builder: (context, callback) {
      return new _AddTaskPage(callback);
    });
  }
}

typedef OnItemAddedCallback = Function(String itemName);

class _AddTaskPage extends StatelessWidget {
  _AddTaskPage(this.callback);
  
  final OnItemAddedCallback callback;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar('Добавление задачи'),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40), 
        child: MaterialButton(
          child: Text('press'),
          onPressed: () {
            callback('itemName');
          }
        )
      ),
    );
  }
}