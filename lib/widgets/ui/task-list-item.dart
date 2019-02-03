import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_kurs/layout/colors.dart';
import 'package:ui_kurs/types/data/task.dart';

class TaskListItem extends StatelessWidget {
  TaskListItem(this.task);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: CustomColors.lightGray, width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(3)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Checkbox(
                value: false,
                activeColor: CustomColors.green,
                onChanged: (value) {
                  debugPrint('checkbox ' + value.toString());
                },
              ),
              Flexible(
                child: Container(
                  padding: new EdgeInsets.only(right: 10.0),
                  child: Text(
                    task.title,
                    textAlign: TextAlign.left, 
                    style: TextStyle(color: CustomColors.lightGray, fontWeight: FontWeight.normal, fontSize: 18),
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                  )
                ),
              )
            ],
          )
        ),
      ),
      onTap: () {
        debugPrint('task tap');
      },
    );
  }
}