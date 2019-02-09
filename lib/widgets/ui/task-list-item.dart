import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import 'package:ui_kurs/assets/icon_pack_icons.dart';
import 'package:ui_kurs/layout/colors.dart';
import 'package:ui_kurs/types/app/routes.dart';
import 'package:ui_kurs/types/data/task.dart';
import 'package:ui_kurs/types/redux/actions/task-actions.dart';
import 'package:ui_kurs/widgets/models/app-state.dart';
import 'package:ui_kurs/widgets/pages/task-detail-page.dart';

typedef OnItemToggleCallback = Function(Task task);
typedef OnItemEditCallback = Function(Task task);

class TaskListItem extends StatefulWidget {
  TaskListItem({ Key key, this.task, this.reorderState, this.currentDepthTask, this.depth, this.prevDepthTask, this.isFirstInParent }) : super(key: key);

  final ReorderableItemState reorderState;
  final Task task;
  final Task currentDepthTask;
  final Task prevDepthTask;
  final int depth;
  final bool isFirstInParent;

  @override
  _TaskListItemState createState() => _TaskListItemState();
}

// TODO: class became too big after adding drag, maybe refactor it
class _TaskListItemState extends State<TaskListItem> with SingleTickerProviderStateMixin {
  static const double DEPTH_PADDING = 30.0;
  static const double RIGHT_DRAG_OFFSET = 0.8;
  static const double LEFT_DRAG_OFFSET = -0.4;
  static const double RIGHT_DRAG_TRIGGER_VALUE = 0.15;
  static const double LEFT_DRAG_TRIGGER_VALUE = 0.2;

  AnimationController _controller;
  Animation<double> _animation;
  double dragOffset = RIGHT_DRAG_OFFSET;
  bool draggingRight = true;
  bool triggering = false;
  bool justStarted = false;

  @override
  void initState() {
      super.initState();

      _controller = AnimationController(
        duration: Duration(milliseconds: 200), 
        vsync: this
      );

      _animation = CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 1.0, curve: Curves.ease),
      );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, OnItemToggleCallback>(
        converter: (store) {
          return (gotTask) =>
            store.dispatch(ToggleDoneTaskAction(gotTask));
    }, builder: (context, toggleCallback) {
      return StoreConnector<AppState, OnItemEditCallback>(
          converter: (store) {
            return (editedTask) =>
              store.dispatch(EditTaskAction(editedTask));
      }, builder: (context, editCallback) {
        return _build(context, toggleCallback, editCallback);
      });
    });
  }

  Widget _build(BuildContext context, OnItemToggleCallback toggleCallback, OnItemEditCallback changeCallback) {
    final reorderState = this.widget.reorderState;
    final task = this.widget.task;

    void _start(DragStartDetails details) {
      setState(() {
        justStarted = true;
      });
    }

    void _move(DragUpdateDetails details) {
      final double delta = details.primaryDelta / 500;
      bool draggingRightNow = draggingRight;

      if (justStarted) {
        if (details.primaryDelta > 0) {
          setState(() {
            draggingRight = true;
            dragOffset = RIGHT_DRAG_OFFSET;
            justStarted = false;
          });
          
          draggingRightNow = true;
        } else {
          setState(() {
            draggingRight = false;
            dragOffset = LEFT_DRAG_OFFSET;
            justStarted = false;
          });

          draggingRightNow = false;
        }
      }

      if ((!draggingRightNow && this.widget.depth == 0) || (draggingRightNow && this.widget.isFirstInParent)) {
        return;
      }

      int sign = draggingRightNow ? 1 : -1;
      _controller.value += sign * delta;
    }

    void _dragEnd(DragEndDetails details) {
      _controller.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.ease);

      if (this.triggering) {
        final task = this.widget.task;
        Task prevTask = this.draggingRight ? this.widget.currentDepthTask : this.widget.prevDepthTask;
        if (prevTask == null) {
          return;
        }

        String newParentId;
        if (this.draggingRight) {
          newParentId = prevTask.id;
        } else {
          newParentId = prevTask.parentId;
        }

        changeCallback(task.rebuild((b) => b..parentId = newParentId));
      }

      setState(() {
        triggering = false;
      });
    }

    final tween = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(dragOffset, 0.0),
    ).animate(_animation);
    
    tween.addListener(() {
      final dragTriggerValue = this.draggingRight ? RIGHT_DRAG_TRIGGER_VALUE : LEFT_DRAG_TRIGGER_VALUE;

      if (_animation.value > dragTriggerValue) {
        setState(() {
          triggering = true;
        });
      } else {
        setState(() {
          triggering = false;
        });
      }
    });

    return GestureDetector(
      onHorizontalDragStart: _start,
      onHorizontalDragUpdate: _move,
      onHorizontalDragEnd: _dragEnd,
      child: Container(
        padding: EdgeInsets.only(left: DEPTH_PADDING * this.widget.depth),
        margin: reorderState == ReorderableItemState.dragProxy ? EdgeInsets.only(bottom: 0) : EdgeInsets.only(bottom: 10),
        child: SlideTransition(
          position: tween,
          child: Row(
            children: <Widget>[
              // TODO: better 'gonnaChangeParent' layout
              Container(
                height: 30,
                margin: EdgeInsets.only(bottom: 20),
                child: this.triggering ? Text(this.draggingRight ? '↑' : '←', style: TextStyle(fontSize: 40)) : Container()
              ),
              Expanded(
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
                            toggleCallback(task);
                          },
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(right: 10.0),
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
                          padding: EdgeInsets.only(left: 20.0, right: 10.0, top: 11.0, bottom: 11.0),
                          child: ReorderableListener(
                            child: Icon(IconPack.move_task, size: 25.0, color: task.isCompleted() ? Colors.white : CustomColors.lightGray),
                          ),
                        ),
                      ],
                    )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            settings: RouteSettings(name: Routes.taskDetail), 
            builder: (context) => TaskDetailPage(task: task),
          ),
        );
      },
    );
  }
}