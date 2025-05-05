import 'package:flutter/material.dart';
import 'package:status/export_file/global_export.dart';

void toastMessage (String message){
  DelightToastBar(
    autoDismiss: true,
    snackbarDuration: const Duration(seconds: 2),
    builder: (context) => ToastCard(
      leading: const Icon(Icons.app_settings_alt),
      // Image.asset(AppImages.appLogo),
      title: Text(message,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
    ),
  ).show(navigatorKey.currentContext!);
}