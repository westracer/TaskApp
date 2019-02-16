import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ui_kurs/types/data/task.dart';
import 'package:ui_kurs/types/redux/actions/task-actions.dart';
import 'package:ui_kurs/types/redux/selectors.dart';
import 'package:ui_kurs/widgets/models/app-state.dart';
import 'package:ui_kurs/widgets/models/task-tree.dart';
import 'package:ui_kurs/widgets/ui/task-list-item.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, appState) {
        final List<Task> _list = getUserTasks(appState);

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
  _TaskListView(rawList, this.parent) {
    final tree = buildTreeAndGetRoots(rawList);
    final flat = getFlatListWithDepths(tree);

    _list = flat.flatList;
    _listBeforeDnd = List.from(_list);
    _depths = flat.depths;
  }

  final _TaskList parent;
  List<Task> _listBeforeDnd;
  List<Task> _list;
  Map<Task, int> _depths;
  
  int _newIndex = -1;
  int _draggingIndex = -1;

  int _indexOfKey(Key key) {
    return _list.indexWhere((Task t) => Key(t.id) == key);
  }

  @override
  Widget build(BuildContext context) {
    Map<int, Task> lastDepthTask = Map();

    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      // TODO: not so sure about that
      onDidChange: (AppState appState) {
        setState(() {
          final tree = buildTreeAndGetRoots(getUserTasks(appState));
          final flat = getFlatListWithDepths(tree);

          _list = flat.flatList;
          _listBeforeDnd = List.from(_list);
          _depths = flat.depths;
        });
      },
      builder: (_context, appState) {
        return Container(
          padding: EdgeInsets.all(10), 
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
                  final depth = _depths[task];
                  final currentDepthTask = lastDepthTask[depth];
                  final prevDepthTask = lastDepthTask[depth-1];

                  bool isFirstInParent = true;
                  if (position > 0) {
                    isFirstInParent = _depths[task] != 0 && _depths[_list[position-1]] < _depths[task];
                  }

                  lastDepthTask.update(depth, (Task oldValue) => task, ifAbsent: () => task);

                  return ReorderableItem(
                    key: Key(task.id),
                    childBuilder: (BuildContext context, ReorderableItemState state) {
                      return TaskListItem(
                        task: task, 
                        reorderState: state, 
                        currentDepthTask: currentDepthTask, 
                        depth: depth, 
                        prevDepthTask: prevDepthTask, 
                        isFirstInParent: isFirstInParent
                      );
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

                  // TODO: not always working properly. fix later
                  {
                    if (_depths[_list[draggingIndex]] > _depths[_list[newPositionIndex]]) {
                      return false;
                    }

                    int min;
                    int max;
                    if (newPositionIndex > draggingIndex) {
                      min = draggingIndex;
                      max = newPositionIndex;
                    } else {
                      max = draggingIndex;
                      min = newPositionIndex;
                    }

                    for (int i = min; i <= max-1; i++) {
                      if (_depths[_list[draggingIndex]] > _depths[_list[i]]) {
                        return false;
                      }
                    }
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
                  if (_newIndex != -1) {
                    // finding index in raw task list by taking task from flat list before dnd
                    _newIndex = appState.tasks.indexWhere((Task t) => t == _listBeforeDnd[_newIndex]);
                  }
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