import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ui_kurs/layout/colors.dart';
import 'package:ui_kurs/types/app/routes.dart';
import 'package:ui_kurs/types/data/task.dart';
import 'package:ui_kurs/types/redux/actions/task-actions.dart';
import 'package:ui_kurs/widgets/models/app-state.dart';
import 'package:ui_kurs/widgets/pages/confirm-page.dart';
import 'package:ui_kurs/widgets/ui/custom-app-bar.dart';
import 'package:intl/intl.dart';

class TaskDetailPage extends StatelessWidget {
  TaskDetailPage({ this.task });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, OnItemRemoveCallback>(
        converter: (store) {
          return (id) =>
            store.dispatch(RemoveTaskAction(id));
    }, builder: (context, callback) {
      return new TaskDetailPageState(callback, task);
    });
  }
}

typedef OnItemRemoveCallback = Function(String id);

class TaskDetailPageState extends StatefulWidget {
  TaskDetailPageState(this.callback, this.task);

  final OnItemRemoveCallback callback;
  final Task task;

  @override
  _TaskDetailPage createState() => _TaskDetailPage();
}

class _TaskDetailPage extends State<TaskDetailPageState> {
  _TaskDetailPage();
  
  @override
  Widget build(BuildContext context) {
    final Task task = this.widget.task;

    Widget dateWidget = Container();
    if (task.dateTime != null) {
      dateWidget = Container(
        margin: EdgeInsets.only(bottom: 5),
        child: Text(
          DateFormat('dd.mm.yyyy HH:MM').format(task.dateTime), 
          style: TextStyle(color: CustomColors.lightGray, fontSize: 16), textAlign: TextAlign.start,
        ),
      );
    }

    Widget descriptionWidget = Container();
    if (task.description != null) {
      descriptionWidget = Container(
        margin: EdgeInsets.only(bottom: 5),
        child: Text(task.description, style: TextStyle(color: Colors.black, fontSize: 16), textAlign: TextAlign.start,)
      );
    }

    return Scaffold(
      appBar: buildAppBar('Информация о задаче'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20), 
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  dateWidget,
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Text(task.title, style: TextStyle(color: Colors.black, fontSize: 24), textAlign: TextAlign.start,)
                  ),
                  descriptionWidget,
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(right: 4),
                            child: _button(
                              () {
                                
                              }, 
                              CustomColors.lightBlue,
                              'Редактировать'
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 4),
                            child: _button(
                              () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    settings: RouteSettings(name: Routes.confirm), 
                                    builder: (context) => ConfirmPage(
                                      confirm: () {
                                        this.widget.callback(task.id);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                );
                              }, 
                              CustomColors.red,
                              'Удалить'
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _button(Function onPressed, Color color, String text) {
  return MaterialButton(
    onPressed: onPressed,
    padding: EdgeInsets.all(0),
    child: DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: color,
      ),
      child: Center(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Text(text, textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 16)),
        )
      ),
    ),
  );
}