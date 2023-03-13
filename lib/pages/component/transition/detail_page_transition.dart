import 'package:flutter/cupertino.dart';

import '../../detail_page/view/news_details.dart';

class PageTransitionDetailCard extends PageRouteBuilder {
  var data;

  PageTransitionDetailCard(
    this.data,
  ) : super(
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
