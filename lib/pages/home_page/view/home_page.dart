import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../style/color.dart';
import '../bloc/home_bloc_bloc.dart';
import '../component_page/list_categories.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocProvider(
        create: (context) => HomeBlocBloc()..add(HomeBlocEvent()),
        child: HomePageBloc(),
      ),
    );
  }
}

class HomePageBloc extends StatefulWidget {
  @override
  State<HomePageBloc> createState() => _HomePageBlocState();
}

class _HomePageBlocState extends State<HomePageBloc>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    HomeBlocBloc cobaListData = context.read<HomeBlocBloc>();
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
                  height: 10,
                ),
                BlocBuilder<HomeBlocBloc, HomeBlocState>(
                  bloc: cobaListData,
                  builder: (context, state) {
                    if (state is ListNewsLoaded) {
                      return CarouselSlider(
                        options:
                            CarouselOptions(height: 210, viewportFraction: 1),
                        items: state.listData.articles.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          i.urlToImage.toString(),
                                        ),
                                        fit: BoxFit.cover)),
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.8),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              i.description.toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
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
                                                i.author.toString(),
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 10,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600),
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
                      );
                    } else {
                      Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
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
                    children: <Widget>[
                      ListNewsCategory(category: "business"),
                      ListNewsCategory(category: "science"),
                      ListNewsCategory(category: "health"),
                      ListNewsCategory(category: "sports"),
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
