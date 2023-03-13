import 'package:flutter/material.dart';
import 'package:flutter_news/component/bottom_bar/bottom_nav.dart';
import 'package:flutter_news/pages/splash_screen/view/splash_screen_page.dart';
import '../component/page_transition/page_transtition.dart';
import '../pages/component/transition/detail_page_transition.dart';

class AppRoute {
  Route onGenerateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreenPage());
      case '/home':
        return PageTransitionEaseOutQuart(BottomNavBar());
      case '/card/detail':
        return PageTransitionDetailCard(args);
      default:
        return MaterialPageRoute(builder: (_) => SplashScreenPage());
    }
  }
}
