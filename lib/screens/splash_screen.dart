import 'package:flutter/material.dart';
import 'package:status/helpers/string_helper.dart';
import '../helpers/color_helper.dart';
import '../helpers/storage_helper.dart';
import '../routes/routes_name.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String accessToken = "";
  bool appInternet = false;


  _buildNavigator (){
    bool isLogin = StorageHelper().getIsFirstLaunch();
    if (isLogin){
      Navigator.pushNamedAndRemoveUntil(context, RouteName.bottomBarTabs, (route) => false);
    }else {
      Navigator.pushNamedAndRemoveUntil(context, RouteName.bottomBarTabs, (route) => false);
    }
  }

  deviceData () async {
    Future.delayed(const Duration(seconds: 2),() => {_buildNavigator(),});
    }




  @override
  void initState() {
    deviceData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorHelper.whiteColor,
      body: Center(
        child: Text(AppString.appName)
      ),
    );
  }
}