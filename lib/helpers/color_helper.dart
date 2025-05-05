import 'package:flutter/material.dart';

class ColorHelper {
  ColorHelper._();
  static final ColorHelper assetsHelper = ColorHelper._();

  factory ColorHelper (){
    return assetsHelper;
  }

  static const Color primaryColor = Color(0xFF18407B);
  static const Color secondaryColor = Color(0xFFE8B621);
  static const Color primaryColorRipple = Color(0xFFE5583B);
  static const Color primaryLightColor = Color(0xFFF16744);
  static const Color primaryLight2Color = Color(0xFFf4dfda);
  static const Color blackSimilar = Color(0xFF2A2A33);
  static const Color bgColor = Color.fromRGBO(244, 246, 245, 1);



  static const Color textFieldBorderColor = Color(0xFFE3E3E3);
  static const Color textFieldFillColor = Color(0xFFF5F5F5);
  static const Color hintTextColor = Color(0xFF9C9C9C);
  static const  Color greyColor = Color(0xFF6F6F6F);
  static const  Color secondaryGreyColor = Color(0xFFE8E8E8);
  static const  Color secondaryChipColor = Color(0xFFD1D9E5);
  static const  Color greyIconColor = Color(0xFF707070);
  static const  Color greyIcon2Color = Color(0xFF747688);
  static const Color addMoreButtonColor = Color(0xFF2A2A33);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);

  static const Color nonDotColor = Color(0xFF466695);

  static const  Color whiteColor = Colors.white;
  static const  Color blackColor = Colors.black;
  static const  Color redColor = Colors.red;
  static const  Color noColor = Colors.transparent;
  static const  Color greenColor = Colors.green;

  static const  Color black = Colors.black;
}