import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ui_kurs/widgets/models/app-state.dart';
import 'package:ui_kurs/widgets/ui/task-list-item.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, appState) {
        return new ListView.builder(
          itemCount: appState.tasks.length,
          itemBuilder: (context, position) =>
            new TastListItem(appState.tasks[position])
        );
      },
    );
  }
}