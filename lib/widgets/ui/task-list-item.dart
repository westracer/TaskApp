import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import 'package:ui_kurs/assets/icon_pack_icons.dart';
import 'package:ui_kurs/layout/colors.dart';
import 'package:ui_kurs/types/data/task.dart';
import 'package:ui_kurs/types/redux/actions/task-actions.dart';
import 'package:ui_kurs/widgets/models/app-state.dart';

class TaskListItem extends StatelessWidget {
  TaskListItem(this.task, this.reorderState);

  final Task task;
  final ReorderableItemState reorderState;

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, OnItemChangeCallback>(
        converter: (store) {
          return (gotTask) =>
            store.dispatch(ToggleDoneTaskAction(gotTask));
    }, builder: (context, callback) {
      return new _TaskListItem(task, reorderState, callback);
    });
  }
}

typedef OnItemChangeCallback = Function(Task task);

class _TaskListItem extends StatelessWidget {
  _TaskListItem(this.task, this.reorderState, this.changeCallback);
  
  final ReorderableItemState reorderState;
  final OnItemChangeCallback changeCallback;
  final Task task;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: reorderState == ReorderableItemState.dragProxy ? EdgeInsets.only(bottom: 0) : EdgeInsets.only(bottom: 10),
        child: Opacity(
          opacity: reorderState == ReorderableItemState.placeholder ? 0.0 : 1.0,
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
                Expanded(
                  child: Container(
                    padding: new EdgeInsets.only(right: 10.0),
                    child: Text(
                      task.title,
                      textAlign: TextAlign.left, 
                      style: TextStyle(color: task.isCompleted() ? Colors.white : CustomColors.lightGray, fontWeight: FontWeight.normal, fontSize: 18),
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                    ),
                  ),
                ),
                Container(
                  padding: new EdgeInsets.only(left: 20.0, right: 10.0, top: 11.0, bottom: 11.0),
                  child: ReorderableListener(
                    child: Icon(IconPack.move_task, size: 25.0, color: task.isCompleted() ? Colors.white : CustomColors.lightGray),
                  ),
                ),
              ],
            )
          ),
        ),
      ),
      onTap: () {
        debugPrint('task tap');
      },
    );
  }
}