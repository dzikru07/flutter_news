import 'package:flutter/material.dart';
import 'package:flutter_news/pages/home_page/models/news_models.dart';

import '../../pages/detail_page/view/news_details.dart';

class PageTransitionEaseOutQuart extends PageRouteBuilder {
  final Widget page;

  PageTransitionEaseOutQuart(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: Duration(milliseconds: 1500),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
              curve: Curves.easeOutQuart,
              parent: animation,
            );
            return Align(
              alignment: Alignment.bottomCenter,
              child: SizeTransition(
                sizeFactor: animation,
                child: page,
                axisAlignment: 0,
              ),
            );
          },
        );
}

class PageTransitionDetailCard extends PageRouteBuilder {
  var data;

  PageTransitionDetailCard(
    this.data,
  )
      : super(
          pageBuilder: (context, animation, anotherAnimation) =>
              NewsDetailsPage(
            data: data,
          ),
          transitionDuration: Duration(milliseconds: 1000),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
              curve: Curves.fastLinearToSlowEaseIn,
              parent: animation,
            );
            return Align(
              alignment: Alignment.bottomRight,
              child: SizeTransition(
                sizeFactor: animation,
                child: NewsDetailsPage(
                  data: data,
                ),
                axisAlignment: 0,
              ),
            );
          },
        );
}
