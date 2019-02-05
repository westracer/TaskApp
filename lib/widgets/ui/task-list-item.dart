import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ui_kurs/layout/colors.dart';
import 'package:ui_kurs/types/data/task.dart';
import 'package:ui_kurs/types/redux/actions/task-actions.dart';
import 'package:ui_kurs/widgets/models/app-state.dart';

class TaskListItem extends StatelessWidget {
  TaskListItem(this.task);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, OnItemChangeCallback>(
        converter: (store) {
          return (gotTask) =>
            store.dispatch(ToggleDoneTaskAction(gotTask));
    }, builder: (context, callback) {
      return new _TaskListItem(task, callback);
    });
  }
}

typedef OnItemChangeCallback = Function(Task task);

class _TaskListItem extends StatelessWidget {
  _TaskListItem(this.task, this.changeCallback);
  
  final OnItemChangeCallback changeCallback;
  final Task task;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: task.isCompleted() ? CustomColors.green : Colors.white,
            border: Border.all(color: task.isCompleted() ? CustomColors.green : CustomColors.lightGray, width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(3)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Checkbox(
                value: task.isCompleted(),
                activeColor: CustomColors.green,
                onChanged: (value) {
                  changeCallback(task);
                },
              ),
              Flexible(
                child: Container(
                  padding: new EdgeInsets.only(right: 10.0),
                  child: Text(
                    task.title,
                    textAlign: TextAlign.left, 
                    style: TextStyle(color: task.isCompleted() ? Colors.white : CustomColors.lightGray, fontWeight: FontWeight.normal, fontSize: 18),
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                  )
                ),
              )
            ],
          )
        ),
      ),
      onTap: () {
        debugPrint('task tap');
      },
    );
  }
}