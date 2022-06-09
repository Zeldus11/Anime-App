import 'package:flutter/material.dart';
import 'package:take_home_exam/view/anime_screen.dart';
import 'package:take_home_exam/model/anime_model.dart';
import 'package:take_home_exam/routing/app_routes.dart';

import '../view/anime_detail_screen.dart';
import '../view/splash_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case animeScreen:
        return MaterialPageRoute(builder: (_) => const AnimeScreen());
      case animeDetailScreen:
        return MaterialPageRoute(
            builder: (_) => AnimeDetailScreen(
                  media: args as Media,
                ));
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
