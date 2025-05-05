

import 'package:flutter/material.dart';

import '../export_file/global_export.dart';

class CommonButton extends StatelessWidget {
  final Widget? child;
  final VoidCallback onPress;
  final Color? bgColor;
  final String? buttonText;
  final double? height, width;
  final buttonMargin;
  const CommonButton({super.key, required this.onPress, this.child, this.bgColor, this.buttonText, this.height, this.width, this.buttonMargin});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: height??DimensHelper.dimens_40,
        width: width??double.infinity,
        alignment: Alignment.center,
        margin: buttonMargin ?? EdgeInsets.zero,
        decoration: BoxDecoration(
          color: bgColor ??ColorHelper.primaryColor,
          borderRadius: BorderRadius.circular(DimensHelper.dimens_12),
          border: Border.all(color: ColorHelper.textFieldBorderColor,width: 0.3),
        ),
        child: child ?? Text(buttonText??"", style: const TextStyle(color: ColorHelper.whiteColor, fontSize: FontHelper.size_18, fontWeight: FontHelper.bold),),),
    );
  }
}


class ImageButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPress;
  const ImageButton({super.key, required this.onPress, required this.child});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      borderRadius: BorderRadius.circular(DimensHelper.dimens_12),
      splashColor: ColorHelper.greyColor,
      child: Container(
        height: DimensHelper.dimens_50,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: ColorHelper.secondaryGreyColor,
          borderRadius: BorderRadius.circular(DimensHelper.dimens_12),
          border: Border.all(color: ColorHelper.primaryColor,width: 0.3),
        ),
        child: child,
      ),
    );
  }
}
