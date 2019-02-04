import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_kurs/layout/colors.dart';

class Dropdown<T> extends StatefulWidget {
  const Dropdown({ Key key, this.text, this.controller, this.list, this.stringCallback, this.changeCallback, }) : super(key: key);

  final TextEditingController controller;
  final String text;
  final List<T> list;
  final Function(T) stringCallback;
  final Function(T) changeCallback;

  @override
  _Dropdown createState() => _Dropdown<T>();
}

// TODO: maybe extract field title   
class _Dropdown<T> extends State<Dropdown<T>> {
  Widget _hint = Text('asd');
  T _value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Text(
            this.widget.text,
            style: TextStyle(color: CustomColors.lightGray, fontSize: 14),
            textAlign: TextAlign.start,
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: 
            DropdownButton<T>(
            value: _value,
            isExpanded: true,
            items: this.widget.list.map((T value) {
              return new DropdownMenuItem<T>(
                value: this.widget.stringCallback(value),
                child: Text(this.widget.stringCallback(value)),
              );
            }).toList(),
            onChanged: (T el) {
              setState(() {
                _value = el;
              });

              this.widget.changeCallback(el);
            }),
          ),
      ],
    );
  }
}