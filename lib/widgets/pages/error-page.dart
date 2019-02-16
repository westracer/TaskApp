import 'package:flutter/material.dart';
import 'package:ui_kurs/assets/icon_pack_icons.dart';
import 'package:ui_kurs/layout/colors.dart';
import 'package:ui_kurs/widgets/ui/big-round-button.dart';

class ErrorPage extends StatelessWidget {
  ErrorPage({ this.goBack, this.errorText });

  final Function goBack;
  final String errorText;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(40), 
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(bottom: 30),
                          child: Icon(IconPack.close__1_, size: 80.0, color: CustomColors.red)
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 14),
                          child: ConstrainedBox(
                            constraints: BoxConstraints.expand(height: 60),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: CustomGradients.lightRedToRed, 
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Center(
                                child: Text(
                                  'Ошибка', 
                                  textAlign: TextAlign.center, 
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26),
                                )
                              )
                            ),
                          ),
                        ),
                        Text(
                          this.errorText,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: CustomColors.lightGray, fontWeight: FontWeight.normal, fontSize: 16),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 35),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: BigRoundButton(
                                  onClick: () {
                                    if (this.goBack != null) {
                                      this.goBack();
                                    }
                                  },
                                  normalColors: BigRoundButtonColors(color: Colors.lightBlue, borderColor: Colors.lightBlue, textColor: Colors.white),
                                  text: 'Вернуться назад',
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
          ],
        ),
      ),
    );
  }
}