import 'package:flutter/material.dart';
import '../helpers/color_helper.dart';

class BackButtonWidget extends StatelessWidget {
  final String? routeName;
  final VoidCallback? onPress;
  final Color? color;
  final icon;
  const BackButtonWidget({super.key, this.routeName, this.onPress, this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon ?? Icons.arrow_back,color: ColorHelper.blackColor),
      onPressed: onPress??(){
        if(WidgetsBinding.instance.window.viewInsets.bottom > 0.0){
          FocusScope.of(context).requestFocus(FocusNode());
        }else{
          if(routeName == null){
            Navigator.pop(context);
          }else{
            Navigator.pushNamedAndRemoveUntil(context, routeName!, (route) => false);
          }

        }
      },
    );
  }
}
