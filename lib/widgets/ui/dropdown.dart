import 'package:flutter/material.dart';
import 'package:ui_kurs/layout/colors.dart';

class Dropdown<T> extends StatefulWidget {
  const Dropdown({ Key key, this.text, this.controller, this.initValue, this.list, this.stringCallback, this.isEmplemented = true, this.changeCallback, }) : super(key: key);

  final bool isEmplemented;
  final TextEditingController controller;
  final String text;
  final List<T> list;
  final Function(T) stringCallback;
  final Function(T) changeCallback;
  final T initValue;

  @override
  _Dropdown createState() => _Dropdown<T>();
}

// TODO: maybe extract field title
class _Dropdown<T> extends State<Dropdown<T>> {
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
          color: this.widget.isEmplemented ? null : Colors.black12,
          child: 
            DropdownButton<T>(
            value: _value != null ? _value : this.widget.initValue,
            isExpanded: true,
            items: this.widget.list.map((T value) {
              return new DropdownMenuItem<T>(
                value: value,
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