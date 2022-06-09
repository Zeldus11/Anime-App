import 'package:flutter/material.dart';
import 'package:take_home_exam/routing/app_routes.dart';
import 'package:take_home_exam/routing/route_generator.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  await initHiveForFlutter();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.red,
        ),
      ),
      initialRoute: splashScreen,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
