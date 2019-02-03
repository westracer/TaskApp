import 'package:flutter/material.dart';
import 'package:ui_kurs/layout/colors.dart';

AppBar buildAppBar(String title) {
  return AppBar(
    backgroundColor: CustomColors.violet,
    title: Text(title),
  );
}