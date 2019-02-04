import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as Services;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ui_kurs/assets/icon_pack_icons.dart';
import 'package:ui_kurs/layout/colors.dart';
import 'package:ui_kurs/types/app/routes.dart';
import 'package:ui_kurs/types/data/task.dart';
import 'package:ui_kurs/types/redux/actions/task-actions.dart';
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
          return (itemName) =>
            store.dispatch(CreateTaskAction(Task((b) => b..title = itemName)));
    }, builder: (context, callback) {
      return new AddTaskPageState(callback);
    });
  }
}

typedef OnItemAddedCallback = Function(String itemName);

class AddTaskPageState extends StatefulWidget {
  AddTaskPageState(this.callback);

  final OnItemAddedCallback callback;

  @override
  _AddTaskPage createState() => _AddTaskPage();
}

// TODO: extract form, validate it and add datepicker
// ????????
// why the heck flutter doesn't use native datepacker
// ????????
class _AddTaskPage extends State<AddTaskPageState> {
  _AddTaskPage();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar('Добавление задачи'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20), 
        child: 
        Column(
          children: <Widget>[
            TextInput(
              text: 'Название *',
              formatters: [
                Services.BlacklistingTextInputFormatter.singleLineFormatter,
              ],
            ),
            TextInput(
              text: 'Дата и время',
              inputType: TextInputType.datetime,
              hint: 'дд.мм.гггг мм:чч',
            ),
            Dropdown<String>(
              text: 'Исполнитель',
              list: ['to be done1', 'to be done2', 'to be done3', 'to be done4'],
              changeCallback: (String str) {},
              stringCallback: (String s) => s,
            ),
            TextInput(
              text: 'Приоритет',
            ),
            TextInput(
              text: 'Статус',
            ),
            TextInput(
              text: 'Описание',
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
                this.widget.callback('asd');
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