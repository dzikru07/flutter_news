import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../style/color.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: appBarColorAccent,
                          borderRadius: BorderRadius.circular(12)),
                      child: Text(
                        'Home',
                        style: GoogleFonts.montserrat(
                            fontSize: 12,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Hello, Arya',
                              style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '25 January 2023',
                              style: GoogleFonts.montserrat(
                                  fontSize: 10,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          'assets/icons/profile_icon.png',
                          width: 45,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Top Headlines',
                  style: GoogleFonts.montserrat(
                      fontSize: 20, fontWeight: FontWeight.w700),
                ),
                CarouselSlider(
                  options:
                      CarouselOptions(height: _height / 3, viewportFraction: 1),
                  items: [1, 2, 3, 4, 5].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/slider_image.png'))),
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Last call to apply to pitch at TechCrunchs (virtual) event in Boston',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: mainColor,
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: Text(
                                          'Mat Huddon',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 10,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                TabBar(
                  controller: _tabController,
                  indicatorColor: appBarColorAccent,
                  tabs: <Widget>[
                    Tab(
                      child: Text(
                        "Bussiness",
                        style: GoogleFonts.montserrat(
                            fontSize: 10,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Science",
                        style: GoogleFonts.montserrat(
                            fontSize: 10,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Health",
                        style: GoogleFonts.montserrat(
                            fontSize: 10,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Sports",
                        style: GoogleFonts.montserrat(
                            fontSize: 10,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: _height / 2,
                  child: TabBarView(
                    controller: _tabController,
                    children: const <Widget>[
                      ListNewsCategory(),
                      ListNewsCategory(),
                      ListNewsCategory(),
                      ListNewsCategory(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ListNewsCategory extends StatefulWidget {
  const ListNewsCategory({super.key});

  @override
  State<ListNewsCategory> createState() => _ListNewsCategoryState();
}

class _ListNewsCategoryState extends State<ListNewsCategory> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return ListView.builder(
        itemCount: 7,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
                color: cardMainColor, borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                Container(
                  height: 110,
                  width: 110,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage("assets/images/newsList.png"))),
                ),
                SizedBox(
                  width: 12,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Battle for Big-Money Donors',
                      style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: cardTitleColor),
                    ),
                    SizedBox(
                      width: _width / 1.6,
                      child: Text(
                        '"The former president and the Florida governor this week intensify fight for campaign cash"',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: cardSubTitleColor),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: cardDateColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            '26 May 2023',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: cardAuthorColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            'Dorry Mens',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          );
        });
  }
}
