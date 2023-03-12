import 'package:flutter/material.dart';
import 'package:flutter_news/component/bottom_bar/bottom_nav.dart';
import 'package:flutter_news/pages/detail_page/view/news_details.dart';
import 'package:flutter_news/pages/splash_screen/view/splash_screen_page.dart';
import '../component/page_transition/page_transtition.dart';

class AppRoute {
  Route onGenerateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreenPage());
      case '/home':
        return PageTransitionEaseOutQuart(BottomNavBar());
      case '/card/detail':
        return MaterialPageRoute(
            settings: RouteSettings(arguments: args),
            builder: (_) => NewsDetailsPage());
      default:
        return MaterialPageRoute(builder: (_) => SplashScreenPage());
    }
  }
}
