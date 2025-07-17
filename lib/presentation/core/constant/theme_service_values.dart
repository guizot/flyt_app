import 'package:flutter/material.dart';
import '../extension/color_extension.dart';

class ThemeServiceValues {

  /// MODE STRING CONSTANTS:
  static const String light = 'Light';
  static const String dark = 'Dark';
  static const String system = 'System';

  static const List<String> themeString = [
    light,
    dark,
    system
  ];

  /// COLOR STRING CONSTANTS:
  static const String colorPink = 'Pink';
  static const String colorBlue = 'Blue';
  static const String colorGreen = 'Green';

  /// TO ADD NEW COLOR:
  /// PUT NEW STRING & COLOR TO THESE 2 ARRAY CONSTANTS
  /// THEN REBUILD AND COLOR IS AUTOMATICALLY ADDED
  static const List<String> colorString = [
    colorPink,
    colorBlue,
    colorGreen,
  ];
  static List<Color> colorValue = [
    HexColor('FFE7E9'),
    HexColor('E7F5FF'),
    HexColor('E7FFF1'),
  ];
  static List<Color> colorValueList = [
    Colors.pink.shade100,
    Colors.blue.shade100,
    Colors.green.shade100
  ];
}