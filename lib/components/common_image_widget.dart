import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:status/helpers/assets_helper.dart';
import 'package:status/helpers/color_helper.dart';
import 'package:status/helpers/dimens_helper.dart';
import 'package:status/utils/globle_context.dart';


Widget showPickedFile({required String image, double? width, double? height}) {
  return ClipRRect(
    borderRadius: const BorderRadius.all(Radius.circular(15)),
    child: Image.file(
      File(image),
      fit: BoxFit.cover,
      height: height ?? DimensHelper.dimens_20,
      width: width ??  DimensHelper.dimens_20,
    ),
  );
}

Widget customAssetImage(
    {String? imgName,
      double? height,
      double? width,
      Color? bgColor,
      decoration,onTap,
      BoxFit? boxFit}) =>
    InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width ?? width,
        decoration: decoration ?? BoxDecoration(shape: BoxShape.circle, color: bgColor ?? Colors.transparent),
        child: Image.asset(
            imgName!,
            fit: boxFit
        ),
      ),
    );

Widget customSVGAssetImage(
    {String? imgName,
      double? height,
      double? width,
      Color? bgColor,
      BoxFit? boxFit}) =>
    Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: bgColor ?? Colors.transparent),
      child: Image.asset(
        imgName ?? "",
        fit: boxFit ?? BoxFit.fill,
      ),
    );



Widget customNetworkImage(
    {String? imgUrl,
      double? height,
      double? radius,
      double? width,
      BoxFit? fit,
      Widget? errorChildWidget,
      Color? bgColor}) =>
    ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius??DimensHelper.dimens_8)),
      child: CachedNetworkImage(
        imageUrl: imgUrl??"",
        height: height ?? DimensHelper.dimens_20,
        width: width ??  DimensHelper.dimens_20,
        fit: fit ?? BoxFit.contain,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CircularProgressIndicator(
              value: downloadProgress.progress,
              color: ColorHelper.secondaryColor),
        errorWidget: (context, url, error) =>  customAssetImage(
          bgColor: ColorHelper.whiteColor,
          imgName: AppImages.appLogo,
          height: context.globalSize.height / DimensHelper.dimens_22,
        ),
      ),
    );

Widget errorWidget({double? size, double? height, double? width}) {
  return Container(
    height: height,
    width: width,
    padding: const EdgeInsets.all(DimensHelper.dimens_2),
    decoration: BoxDecoration(
        color: ColorHelper.primaryColor,
        borderRadius: BorderRadius.circular(DimensHelper.dimens_10)),
    child: // Image.asset(AppImages.userProfile)
    Icon(
      Icons.error_outline,
      size: size ?? 10.0
    ),
  );
}


