import 'package:flutter/material.dart';

class BigRoundButtonColors {
  const BigRoundButtonColors({ this.color, this.borderColor, this.textColor });

  final Color color;
  final Color borderColor;
  final Color textColor;
}

class BigRoundButton extends StatelessWidget {
  const BigRoundButton({ Key key, this.text, this.normalColors, this.onClick }) : super(key: key);
  
  final String text;
  final BigRoundButtonColors normalColors;
  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onClick,
      padding: EdgeInsets.all(0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: this.normalColors.borderColor, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: this.normalColors.color,
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(this.text, textAlign: TextAlign.center, style: TextStyle(color: this.normalColors.textColor, fontWeight: FontWeight.normal, fontSize: 16)),
          )
        ),
      ),
    );
  }
}