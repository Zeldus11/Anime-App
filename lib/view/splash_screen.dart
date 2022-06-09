import 'dart:async';

import 'package:flutter/material.dart';
import 'package:take_home_exam/routing/app_routes.dart';
import 'package:take_home_exam/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  AnimationController? animationController;
  Animation<double>? animation;

  startTime() async {
    var _duration = Duration(seconds: splashDuration);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    Navigator.pushNamedAndRemoveUntil(context, animeScreen, (r) => false);
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child:
          Image.asset(
            splashLogo,
            height: logoHeight,
            width: logoWidth,
          )
      ),
    );
  }
}