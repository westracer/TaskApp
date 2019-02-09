import 'package:flutter/material.dart';
import 'package:ui_kurs/assets/icon_pack_icons.dart';
import 'package:ui_kurs/layout/colors.dart';
import 'package:ui_kurs/widgets/ui/big-round-button.dart';

class ConfirmPage extends StatelessWidget {
  ConfirmPage({ this.cancel, this.confirm });

  final Function cancel;
  final Function confirm;
  
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
                          child: Icon(IconPack.question, size: 80.0, color: CustomColors.lightBlue)
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 14),
                          child: ConstrainedBox(
                            constraints: BoxConstraints.expand(height: 60),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: CustomGradients.blueToLightBlue, 
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Center(
                                child: Text(
                                  'Вы уверены?', 
                                  textAlign: TextAlign.center, 
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26),
                                )
                              )
                            ),
                          ),
                        ),
                        Text(
                          'Дальнейшее действие нельзя отменить. Подумайте еще раз',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: CustomColors.lightGray, fontWeight: FontWeight.normal, fontSize: 16),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 35),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(right: 8),
                                  child: BigRoundButton(
                                    onClick: () {
                                      Navigator.pop(context);

                                      if (this.cancel != null) {
                                        this.cancel();
                                      }
                                    },
                                    normalColors: BigRoundButtonColors(color: Colors.white, borderColor: Colors.lightBlue, textColor: Colors.lightBlue),
                                    text: 'Отмена',
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 8),
                                  child: BigRoundButton(
                                    onClick: () {
                                      Navigator.pop(context);

                                      if (this.confirm != null) {
                                        this.confirm();
                                      }
                                    },
                                    normalColors: BigRoundButtonColors(color: Colors.white, borderColor: Colors.lightBlue, textColor: Colors.lightBlue),
                                    text: 'Да, уверен',
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
          ],
        ),
      ),
    );
  }
}