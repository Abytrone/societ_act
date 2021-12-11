import 'package:flutter/material.dart';

// 0xFFE63946

// 0xFFF1FAEE

// 0xFFA8DADC

// 0xFF457B9D

// 0xFF1D3557

// 0xFFCFD7CD

// 0xFFEDF1F4
extension ColorExtension on String {
  toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}
