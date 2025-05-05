import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:status/helpers/color_helper.dart';
import 'package:status/helpers/dimens_helper.dart';


loadingIndicator(){
  return Center(
    child: Card(
      elevation: 2,
      color: ColorHelper.whiteColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DimensHelper.dimens_50)
      ),
      child: Container(
          alignment: Alignment.center,
          height: DimensHelper.dimens_50,width: DimensHelper.dimens_50,
          padding: const EdgeInsets.all(DimensHelper.dimens_14),
          child: const CircularProgressIndicator(color: ColorHelper.primaryColor,strokeWidth: DimensHelper.dimens_3,)
      ),
    ),
  );
}


loadingButton({Color? color}){
  return  Center(
    child: LoadingIndicator(
        indicatorType: Indicator.pacman,
        colors:  color != null? [color]:[ColorHelper.whiteColor],
        backgroundColor: ColorHelper.noColor,
        strokeWidth: DimensHelper.dimens_2,
      ),
  );
}


Widget cirProIndicator(double size, {Color? color}){
  return Container(
      alignment: Alignment.center,
      height: size,width: size,
      padding: const EdgeInsets.all(DimensHelper.dimens_4),
      child: CircularProgressIndicator(color: color ?? ColorHelper.primaryColor,strokeWidth: DimensHelper.dimens_3,)
  );
}


Widget blurLoading ({required Widget child}){
  return Scaffold(
      body: Stack(
        children: [
          child,
          Container(
            color: ColorHelper.whiteColor.withOpacity(0.7),
            child: loadingIndicator(),
          )
        ],
      )
  );
}
