import 'package:flutter/material.dart';
import 'package:flutter_news/routes/app_route.dart';
import 'package:flutter_news/style/color.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppRoute _appRoute = AppRoute();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter News',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: colorTheme,
      ),
      onGenerateRoute: _appRoute.onGenerateRoute,
    );
  }
}
