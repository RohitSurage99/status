import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:status/routes/routes_name.dart';
import 'package:status/screens/auth_screen/login_screen.dart';
import 'package:status/screens/auth_screen/signup_screen.dart';
import 'package:status/screens/auth_screen/verification_code.dart';
import 'package:status/screens/bottom_bar_tabs.dart';
import 'package:status/screens/no_route_found.dart';
import 'package:status/screens/splash_screen.dart';


class Routes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case RouteName.logIn:
        return PageTransition(type: PageTransitionType.rightToLeft, child: const LoginScreen());

      case RouteName.signUp:
        return PageTransition(type: PageTransitionType.rightToLeft, child: const SignUpScreen());

      case RouteName.verificationCode:
        final args = settings.arguments as Map<String, dynamic>;
        return PageTransition(type: PageTransitionType.rightToLeft, child: VerificationCode(args: args));


      case RouteName.bottomBarTabs:
        return
          PageTransition(
              type: PageTransitionType.rightToLeft,
              // child: MultiBlocProvider(
                // providers: [
                  // BlocProvider(create: (BuildContext context) => ChallengesDetailsCubit()),
                  // BlocProvider(create: (BuildContext context) => JoinNewChallengesCubit()),
                // ],
                child: const BottomBarTabs(),
              // )
          );


    //   case RouteName.staticContentView:
    //     final args = settings.arguments as Map<String, dynamic>;
    //     return PageTransition(
    //         type: PageTransitionType.rightToLeft,
    //         child: BlocProvider(
    //         create: (BuildContext context) => StaticContentCubit()..getStaticContentData(contentText: args['content']),
    //         child: StaticContentScreen(args : args)
    //     )
    //     );



      default:
        return PageTransition(type: PageTransitionType.bottomToTop, child: const NoRouteFound());
    }
  }
}
