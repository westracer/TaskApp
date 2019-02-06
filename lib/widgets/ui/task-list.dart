import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ui_kurs/types/data/task.dart';
import 'package:ui_kurs/types/redux/actions/task-actions.dart';
import 'package:ui_kurs/widgets/models/app-state.dart';
import 'package:ui_kurs/widgets/ui/task-list-item.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, appState) {
        final _list = appState.tasks.toList();

        return _TaskList(list: _list);
      },
    );
  }
}

class _TaskList extends StatefulWidget {
  _TaskList({ this.list });

  final List<Task> list;

  @override
  _TaskListView createState() => _TaskListView(list, this);
}

typedef OnMoveTaskCallback = Function(int oldIndex, int newIndex);

class _TaskListView extends State<_TaskList> {
  _TaskListView(this._list, this.parent);

  final _TaskList parent;
  List<Task> _list;
  int _newIndex = -1;
  int _draggingIndex = -1;

  int _indexOfKey(Key key) {
    return _list.indexWhere((Task t) => Key(t.id) == key);
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      // TODO: not so sure about that
      onDidChange: (AppState appState) {
        setState(() {
          this._list = appState.tasks.toList();
        });
      },
      builder: (_context, appState) {
        return Container(
          padding: EdgeInsets.all(20), 
          child: StoreConnector<AppState, OnMoveTaskCallback>(
            converter: (store) {
              return (i1, i2) =>
                store.dispatch(MoveTaskAction(i1, i2)); 
            },
            builder: (_context, moveCallback) {
              return ReorderableList(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: _list.length,
                  itemBuilder: (context, position) {
                  final task = _list[position];

                  return ReorderableItem(
                    key: Key(task.id),
                    childBuilder: (BuildContext context, ReorderableItemState state) {
                      return TaskListItem(task, state);
                    },
                  );
                },
              ),
                onReorder: (Key draggedItem, Key newPosition) {
                  bool shouldSetState = false;

                  int draggingIndex = _indexOfKey(draggedItem);
                  if (_draggingIndex == -1 || _draggingIndex != draggingIndex) {
                    shouldSetState = true;
                  }

                  int newPositionIndex = _indexOfKey(newPosition);
                  if (_newIndex == -1 || _newIndex != newPositionIndex) {
                    shouldSetState = true;
                  }

                  if (shouldSetState) {
                    final Task item = _list[draggingIndex];
                    setState(() {
                      _newIndex = newPositionIndex;
                      _draggingIndex = draggingIndex;

                      _list.removeAt(_draggingIndex);
                      _list.insert(newPositionIndex, item);
                    });
                  }

                  return true;
                },
                onReorderDone: (Key draggedItem) {
                  int oldIndex = appState.tasks.indexWhere((Task t) => Key(t.id) == draggedItem);
                  moveCallback(oldIndex, _newIndex);

                  _draggingIndex = _newIndex = -1;
                },
              );
            },
          ),
        );
      }
    );
  }

}