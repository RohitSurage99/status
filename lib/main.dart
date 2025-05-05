
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:status/cubits/get_api_cubit.dart';
import 'helpers/color_helper.dart';
import 'helpers/storage_helper.dart';
import 'network_manager/auth_device_data.dart';
import 'network_manager/local_storage_cubit.dart';
import 'routes/routes.dart';
import 'routes/routes_name.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


void main () async{
  WidgetsFlutterBinding.ensureInitialized();
  mainCommon();
}

void mainCommon() async{
  WidgetsFlutterBinding.ensureInitialized();
  await StorageHelper().init();
  await UserAuthenticationApis().getId();
  // status bar color
  // SystemChrome.setSystemUIOverlayStyle( const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarBrightness: Brightness.dark));

  //Always Portrait Up mode
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);


  runApp(const MyApp());
}


class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    // final stringHelper = StringHelper.of(context)!;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },

      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (BuildContext context) => StorageCubit()),
          BlocProvider(create: (BuildContext context) => GetApiCubit()),
        ],
        child: MaterialApp(
          title: "test",
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: _buildTheme(),
          initialRoute: RouteName.splash,
          onGenerateRoute: Routes.onGenerateRoute,
        ),
      ),

    );
  }

  _buildTheme(){
    return ThemeData(
      textTheme: GoogleFonts.beVietnamProTextTheme(),
      appBarTheme: const AppBarTheme(color:Colors.white,elevation: 0.0),
      bottomSheetTheme: const BottomSheetThemeData(backgroundColor: ColorHelper.primaryColor),
      colorScheme: ColorScheme.fromSeed(
          background: ColorHelper.whiteColor,
          surface: ColorHelper.whiteColor,
          surfaceTint: ColorHelper.whiteColor,
          seedColor: ColorHelper.primaryColor),
      useMaterial3: true,
    );
  }

}
