import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:music/consts/colors.dart';

TextStyle oruStayle({
  double? size = 14,
  Color? color,
}) {
  return TextStyle(
    fontSize: size,
    color: color ?? whiteColor,
  );
}

// Rest of your code...
