import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ui_kurs/layout/colors.dart';
import 'package:ui_kurs/types/app/user.dart';
import 'package:ui_kurs/types/redux/actions/task-actions.dart';
import 'package:ui_kurs/widgets/models/app-state.dart';
import 'package:ui_kurs/widgets/ui/big-round-button.dart';
import 'package:ui_kurs/widgets/ui/text-input.dart';

typedef OnSignInCallback = Function(User user);
typedef OnSignUpCallback = Function(User user);

class LoginPage extends StatelessWidget {
  // TODO: controller enum
  final Map<String, TextEditingController> controllers = Map.from({
    'email': TextEditingController(),
    'password': TextEditingController(),
    'name': TextEditingController(),
  });

  createUser() {
    return User((b) => b
      ..pass = controllers['password'].text
      ..email = controllers['email'].text
      ..name = controllers['name'].text
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        'Вернуться назад',
                      ),
                    )
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextInput(
                        text: 'Email',
                        controller: controllers['email'],
                        inputType: TextInputType.emailAddress,
                      ),
                      TextInput(
                        text: 'Пароль',
                        controller: controllers['password'],
                        inputType: TextInputType.text,
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: StoreConnector<AppState, OnSignInCallback>(
                          converter: (store) {
                            return (user) =>
                              store.dispatch(SignInAction(context, user));
                      }, builder: (context, callback) {
                        return BigRoundButton(
                          text: 'Войти',
                          onClick: () {
                            callback(createUser());
                          },
                          normalColors: BigRoundButtonColors(color: CustomColors.lightBlue, borderColor: CustomColors.lightBlue, textColor: Colors.white),
                        );
                      })
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      'Для регистрации также укажите ваше имя',
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  TextInput(
                    text: 'Имя',
                    controller: controllers['name'],
                    inputType: TextInputType.text,
                  ),
                  Container(
                    child: StoreConnector<AppState, OnSignUpCallback>(
                          converter: (store) {
                            return (user) =>
                              store.dispatch(SignUpAction(context, user));
                      }, builder: (context, callback) {
                        return BigRoundButton(
                          text: 'Зарегистрироваться',
                          onClick: () {
                            callback(createUser());
                          },
                          normalColors: BigRoundButtonColors(color: Colors.white, borderColor: CustomColors.violet, textColor: CustomColors.violet),
                        );
                      }),
                  ),
                ],
              )
            )
          ],
        ) 
      ),
    );
  }
}