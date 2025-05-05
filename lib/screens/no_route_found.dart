import 'package:flutter/material.dart';
import 'package:status/helpers/string_helper.dart';

class NoRouteFound extends StatelessWidget {
  const NoRouteFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text(AppString.somethingWentWrong),
      ),
      body:  const Center(
        child: Text(AppString.noRouteFound),
      ),
    );
  }
}
