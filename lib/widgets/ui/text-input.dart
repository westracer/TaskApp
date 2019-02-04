import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_kurs/layout/colors.dart';

// TODO: maybe extract field title
class TextInput extends StatelessWidget {
  const TextInput({ Key key, this.text, this.controller, this.inputType = TextInputType.text, this.hint = null, this.formatters = null }) : super(key: key);
  
  final List<TextInputFormatter> formatters;
  final TextEditingController controller;
  final TextInputType inputType;
  final String text;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Text(
            this.text,
            style: TextStyle(color: CustomColors.lightGray, fontSize: 14),
            textAlign: TextAlign.start,
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: TextField(
            controller: controller,
            keyboardType: inputType,
            maxLines: inputType == TextInputType.multiline ? 6 : 1,
            inputFormatters: formatters != null ? formatters : [],
            decoration: InputDecoration(
              hintText: hint != null ? hint : '',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(0)),
                borderSide: BorderSide(color: Colors.black26, width: 1),
              ),
              enabled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(0)),
                borderSide: BorderSide(color: Colors.black26, width: 1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}