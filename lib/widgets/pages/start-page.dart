import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ui_kurs/assets/icon_pack_icons.dart';
import 'package:ui_kurs/layout/colors.dart';
import 'package:ui_kurs/types/app/routes.dart';
import 'package:ui_kurs/types/app/user.dart';
import 'package:ui_kurs/widgets/models/app-state.dart';
import 'package:ui_kurs/widgets/ui/big-round-button.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) {
          return store.state;
    }, builder: (context, state) {
      return _StartPage(state.currentUser);
    });
  }
}

class _StartPage extends StatefulWidget {
  _StartPage(this.currentUser);

  final User currentUser;
  
  @override
  _StartPageState createState() => _StartPageState(currentUser);
}

class _StartPageState extends State<_StartPage> {
  _StartPageState(this.currentUser);

  final User currentUser;
  
  @override
  void initState() {
    super.initState();

    if (currentUser != null) {
      Future(() {
        Navigator.pushReplacementNamed(context, Routes.taskList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40), 
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: 
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(bottom: 30),
                            child: Icon(IconPack.task_list, size: 80.0, color: CustomColors.violet)
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 14),
                            child: ConstrainedBox(
                              constraints: BoxConstraints.expand(height: 60),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: CustomGradients.blueToViolet,
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                ),
                                child: Center(
                                  child: Text(
                                    'Добро пожаловать!', 
                                    textAlign: TextAlign.center, 
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26),
                                  )
                                )
                              ),
                            ),
                          ),
                          Text(
                            'Как бы вы хотели начать работу?',
                            style: TextStyle(color: CustomColors.lightGray, fontWeight: FontWeight.normal, fontSize: 16),
                          ),
                        ],
                      ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: BigRoundButton(
                            text: 'Зарегистрироваться или войти',
                            onClick: () {
                              Navigator.pushNamed(context, Routes.login);
                            },
                            normalColors: BigRoundButtonColors(color: Colors.white, borderColor: CustomColors.violet, textColor: CustomColors.violet),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                            MaterialButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(context, Routes.taskList);
                              },
                              height: 40,
                              child: Text(
                                'Продолжить без регистрации',
                                style: TextStyle(color: CustomColors.lightBlue, fontWeight: FontWeight.normal, fontSize: 14, decoration: TextDecoration.underline),
                              )
                            )
                          ],),
                        )
                      ],
                    ),
                  )
                ],
              )
            )
          ],
        )
      ),
    );
  }
}