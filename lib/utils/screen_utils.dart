import 'package:flutter/material.dart';

class ScreenUtils {
  // static final ScreenUtils _singleton = ScreenUtils();

  /// screen width
  /// 当前屏幕 宽
  static double screenW(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.size.width;
  }

  /// screen height
  /// 当前屏幕 高
  static double screenH(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.size.height;
  }
}