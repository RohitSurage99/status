import 'package:flutter/material.dart';
extension MediaQueryExtension on BuildContext {
  Size get globalSize => MediaQuery.of(this).size;
}


