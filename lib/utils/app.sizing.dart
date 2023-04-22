import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:math' as math;

class Responsive {
  static late double _width, _height, _diagonal;
  static late bool _isTablet;

  static double get width => _width;
  static double get height => _height;
  static double get diagonal => _diagonal;
  static bool get isTablet => _isTablet;

  Responsive(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    _width = size.width;
    _height = size.height;
    _diagonal = math.sqrt(math.pow(_width, 2) + math.pow(_height, 2));
    _isTablet = size.shortestSide >= 600;
  }

  static widthPercentToPixels(double percent) => log("widthPercentToPixels: ${wp(percent)}");
  static heightPercentToPixels(double percent) => log("heightPercentToPixels: ${hp(percent)}");
  static displayPercentToPixels(double percent) => log("displayPercentToPixels: ${dp(percent)}");

  static double wp(double percent) => _width * percent / 100;
  static double hp(double percent) => _height * percent / 100;
  static double dp(double percent) => _diagonal * percent / 100;
}
