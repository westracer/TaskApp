import 'package:ui_kurs/types/data/task.dart';
import 'package:ui_kurs/types/redux/actions/task-actions.dart';
import 'package:ui_kurs/widgets/models/app-state.dart';

AppState appReducers(AppState appState, dynamic action) {
  if (action is CreateTaskAction) {
    return addItem(appState, action);
  } 
  // else if (action is ToggleItemStateAction) {
  //   return toggleItemState(items, action);
  // } 

  return appState;
}

AppState addItem(AppState appState, CreateTaskAction action) {
  return AppState(
    currentUser: appState.currentUser,
    groups: appState.groups,
    tasks: appState.tasks..add(action.task)
  );
}

// List<Task> toggleItemState(List<CartItem> items, ToggleItemStateAction action) {
//   return items.map((item) => item.name == action.item.name ?
//     action.item : item).toList();
// }