import 'package:flutter/material.dart';
import 'package:flutter_news/pages/splash_screen/view/splash_screen_page.dart';
import '../component/page_transition/page_transtition.dart';
import '../pages/home_page/view/home_page.dart';

class AppRoute {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreenPage());
      case '/home':
        return PageTransitionEaseOutQuart(SecondPage());
      default:
        return MaterialPageRoute(builder: (_) => SplashScreenPage());
    }
  }
}
