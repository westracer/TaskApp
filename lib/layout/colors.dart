import 'dart:ui';

import 'package:flutter/painting.dart';

class CustomColors {
  static final Color lightGray = Color.fromARGB(255, 150, 150, 150);
  static final Color lightBlue = Color.fromARGB(255, 93, 186, 255);
  static final Color violet = Color.fromARGB(255, 187, 148, 255);
  static final Color blue = Color.fromARGB(255, 58, 117, 243);
  static final Color green = Color.fromARGB(255, 98, 229, 103);
}

class CustomGradients {
  static final LinearGradient blueToViolet = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      Color.fromARGB(255, 112, 118, 252),
      Color.fromARGB(255, 159, 150, 255),
      CustomColors.violet,
    ],
    stops: <double>[0, 0.5, 1.0],
  );
}