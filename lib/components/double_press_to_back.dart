import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:status/helpers/string_helper.dart';
import '../utils/toast_message.dart';


class DoublePressToExit extends StatefulWidget {
  final Widget child;
  const DoublePressToExit({super.key, required this.child});

  @override
  State<DoublePressToExit> createState() => _DoublePressToExitState();
}

class _DoublePressToExitState extends State<DoublePressToExit> {

  DateTime? currentBackPressTime;
  bool canPopNow = false;
  int requiredSeconds = 2;

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: canPopNow,
        onPopInvoked: onPopInvoked,
    child: widget.child);
  }


  void onPopInvoked(bool didPop) {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: requiredSeconds)) {
      currentBackPressTime = now;
       toastMessage(AppString.pressBackAgainToExit);
      Future.delayed(
        Duration(seconds: requiredSeconds), () {
        // Disable pop invoke and close the toast after 2s timeout
        setState(() {canPopNow = false;});
        Fluttertoast.cancel();
      },
      );
      // Ok, let user exit app on the next back press
      setState(() {canPopNow = true;});
    }}

}
