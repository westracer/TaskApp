import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as Services;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ui_kurs/layout/colors.dart';
import 'package:ui_kurs/types/app/user.dart';
import 'package:ui_kurs/types/data/task-status.dart';
import 'package:ui_kurs/types/data/task.dart';
import 'package:ui_kurs/types/redux/actions/task-actions.dart';
import 'package:ui_kurs/types/redux/selectors.dart';
import 'package:ui_kurs/widgets/models/app-state.dart';
import 'package:ui_kurs/widgets/ui/big-round-button.dart';
import 'package:ui_kurs/widgets/ui/custom-app-bar.dart';
import 'package:ui_kurs/widgets/ui/dropdown.dart';
import 'package:ui_kurs/widgets/ui/text-input.dart';

class AddTaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, OnItemAddedCallback>(
        converter: (store) {
          return (newTask) =>
            store.dispatch(AddTasksAction([newTask]));
    }, builder: (context, callback) {
      return new AddTaskPageState(callback);
    });
  }
}

typedef OnItemAddedCallback = Function(Task newTask);

class AddTaskPageState extends StatefulWidget {
  AddTaskPageState(this.callback);

  final OnItemAddedCallback callback;

  @override
  _AddTaskPage createState() => _AddTaskPage();
}

// TODO: extract form, validate it and add datepicker
class _AddTaskPage extends State<AddTaskPageState> {
  _AddTaskPage();

  // TODO: controller enum
  final Map<String, TextEditingController> controllers = Map.from({
    'title': TextEditingController(),
    'datetime': TextEditingController(),
    'description': TextEditingController(),
    'planned': TextEditingController(),
    'spent': TextEditingController(),
  });

  TaskStatus _taskStatus = TaskStatus.NEW;
  String _executor;

  Task createNewTask() {
    int spent, planned;
    DateTime dateTime = DateTime.tryParse(controllers['datetime'].text);
    try { spent = int.parse(controllers['spent'].text); } on FormatException catch (_) { spent = 0; }
    try { planned = int.parse(controllers['planned'].text); } on FormatException catch (_) { planned = 0; }

    return Task((b) => b
      ..title = controllers['title'].text
      ..timeSpent = spent
      ..status = _taskStatus
      ..plannedTime = planned
      ..dateTime = dateTime
      ..executor = _executor
      ..description = controllers['description'].text
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar('Добавление задачи'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20), 
        child: Column(
          children: <Widget>[
            TextInput(
              text: 'Название *',
              controller: controllers['title'],
              formatters: [
                Services.BlacklistingTextInputFormatter.singleLineFormatter,
              ],
            ),
            TextInput(
              text: 'Дата и время',
              controller: controllers['datetime'],
              inputType: TextInputType.datetime,
              hint: 'ДД-ММ-ГГГГ ММ:ЧЧ',
            ),
            StoreConnector<AppState, AppState>(
                converter: (store) => store.state, 
                builder: (context, state) {
                  return Dropdown<User>(
                    initValue: null,
                    text: 'Исполнитель',
                    list: getAllUsers(state),
                    changeCallback: (User user) {
                      _executor = user.email;
                    },
                    stringCallback: (User user) {
                      return user.email;
                    },
                  );
            }),
            Dropdown<String>(
              text: 'Приоритет',
              isEmplemented: false,
              list: ['to be done1', 'to be done2', 'to be done3', 'to be done4'],
              changeCallback: (String str) {},
              stringCallback: (String s) => s,
            ),
            Dropdown<TaskStatus>(
              initValue: TaskStatus.NEW,
              text: 'Статус',
              list: TaskStatus.ALL_STATUSES,
              changeCallback: (TaskStatus status) {
                _taskStatus = status;
              },
              stringCallback: (TaskStatus status) {
                return TaskStatus.taskStatusNames[status];
              },
            ),
            TextInput(
              text: 'Описание',
              controller: controllers['description'],
              inputType: TextInputType.multiline,
              formatters: [],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: 
                  Container(
                    padding: EdgeInsets.only(right: 10),
                    child: TextInput(
                      text: 'Планируемое время',
                      hint: 'мин',
                      controller: controllers['planned'],
                      inputType: TextInputType.number,
                      formatters: [
                        Services.WhitelistingTextInputFormatter.digitsOnly,
                        Services.BlacklistingTextInputFormatter.singleLineFormatter,
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: 
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: TextInput(
                      text: 'Затраченное время',
                      hint: 'мин',
                      controller: controllers['spent'],
                      inputType: TextInputType.number,
                      formatters: [
                        Services.WhitelistingTextInputFormatter.digitsOnly,
                        Services.BlacklistingTextInputFormatter.singleLineFormatter,
                      ],
                    ),
                  ),
                ),
              ],
            ),
            BigRoundButton(
              text: 'Создать',
              onClick: () {
                this.widget.callback(this.createNewTask());
                Navigator.pop(context);
              },
              normalColors: BigRoundButtonColors(color: CustomColors.violet, borderColor: CustomColors.violet, textColor: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}