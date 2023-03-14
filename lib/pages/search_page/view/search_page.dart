import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

import '../../../component/error_handling/view/api_error.dart';
import '../../../component/error_handling/view/network_error.dart';
import '../../../component/format/time_format.dart';
import '../../../style/color.dart';
import '../bloc/search_bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocProvider(
        create: (context) => SearchBloc()..add(SearchEvent()),
        child: SearchPageBloc(),
      ),
    );
  }
}

class SearchPageBloc extends StatefulWidget {
  const SearchPageBloc({super.key});

  @override
  State<SearchPageBloc> createState() => _SearchPageBlocState();
}

class _SearchPageBlocState extends State<SearchPageBloc>
    with TickerProviderStateMixin {
  bool _searchStatus = false;

  late final AnimationController _controller;
  late final AnimationController _controller2;

  late Animation<double> animated;
  late Animation<double> animated2;

  TextEditingController searchData = TextEditingController();

  int lengthData = 10;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    )..forward();
    _controller2 = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );
    animated = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    );
    animated2 = CurvedAnimation(
      parent: _controller2,
      curve: Curves.bounceOut,
    );
  }

  runAnimationControllerShow() {
    _controller.repeat();
    _controller.forward();
  }

  runAnimationControllerHide() {
    _controller.reset();
  }

  runAnimationController2Show() {
    _controller2.repeat();
    _controller2.forward();
  }

  runAnimationController2Hide() {
    _controller2.reset();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    _controller2.dispose();
    searchData.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SearchBloc searchDataResult = context.read<SearchBloc>();

    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.centerStart,
                      children: [
                        ScaleTransition(
                          scale: animated,
                          child: Text(
                            'Search News',
                            style: GoogleFonts.montserrat(
                                fontSize: 28,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        ScaleTransition(
                          scale: animated2,
                          child: Container(
                            padding: EdgeInsets.only(left: 15),
                            height: 40,
                            width: _width / 1.5,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12)),
                            child: TextField(
                              controller: searchData,
                              decoration: InputDecoration(
                                suffixIcon: InkWell(
                                  onTap: () {
                                    searchData.clear();
                                  },
                                  child: Icon(
                                    UniconsLine.multiply,
                                    size: 15,
                                  ),
                                ),
                                hintText: "Search News",
                              ),
                              onSubmitted: (value) {
                                searchDataResult.add(SearchEvent(value));
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _searchStatus = !_searchStatus;
                          if (_searchStatus) {
                            runAnimationControllerHide();
                            runAnimationController2Show();
                          } else {
                            runAnimationControllerShow();
                            runAnimationController2Hide();
                          }
                        });
                      },
                      child: Icon(
                        UniconsLine.search,
                        color: Colors.grey[600],
                        size: 25,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                BlocBuilder<SearchBloc, SearchState>(
                  bloc: searchDataResult,
                  builder: (context, state) {
                    if (state is ListNewsLoaded) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Number of News ${state.listData.totalResults}',
                            style: GoogleFonts.montserrat(
                                fontSize: 12,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600),
                          ),
                          AnimationLimiter(
                            child: ListView.builder(
                                itemCount: state.listData.articles.length <=
                                        lengthData + 1
                                    ? state.listData.articles.length
                                    : lengthData + 1,
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemBuilder: (context, index) {
                                  if (index < lengthData) {
                                    return AnimationConfiguration.staggeredList(
                                position: index,
                                delay: Duration(milliseconds: 100),
                                
                                child: SlideAnimation(
                                  duration: Duration(milliseconds: 2500),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  child: FadeInAnimation(
                                      duration: Duration(milliseconds: 2500),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                      child: InkWell(
                                        onTap: () async {
                                          Navigator.of(context).pushNamed(
                                              "/card/detail",
                                              arguments:
                                                  state.listData.articles[index]);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          margin: EdgeInsets.only(top: 15, left: 8, right: 8),
                                          decoration: BoxDecoration(
                                              color: cardMainColor,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 110,
                                                width: 110,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    image: DecorationImage(
                                                        image: NetworkImage(state
                                                            .listData
                                                            .articles[index]
                                                            .urlToImage
                                                            .toString()),
                                                        fit: BoxFit.cover)),
                                              ),
                                              SizedBox(
                                                width: 12,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: _width / 1.8,
                                                    child: Text(
                                                      state.listData.articles[index]
                                                          .title,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      style: GoogleFonts.montserrat(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: cardTitleColor),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: _width / 1.8,
                                                    child: Text(
                                                      state.listData.articles[index]
                                                          .description
                                                          .toString(),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      style: GoogleFonts.montserrat(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: cardSubTitleColor),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  SizedBox(
                                                    width: _width / 1.8,
                                                    child: SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            padding:
                                                                EdgeInsets.all(5),
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    cardDateColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                            child: Text(
                                                              FormatData()
                                                                  .getDataFormat(state
                                                                      .listData
                                                                      .articles[
                                                                          index]
                                                                      .publishedAt),
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                      fontSize: 12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Colors
                                                                          .white),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 8,
                                                          ),
                                                          Container(
                                                            padding:
                                                                EdgeInsets.all(5),
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    cardAuthorColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                            child: Text(
                                                              state
                                                                  .listData
                                                                  .articles[index]
                                                                  .author
                                                                  .toString(),
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                      fontSize: 12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Colors
                                                                          .white),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                )));
                                  } else {
                                    return index == lengthData
                                        ? Center(
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  if (state.listData.articles
                                                          .length <
                                                      lengthData + 10) {
                                                    lengthData = state
                                                        .listData.articles.length;
                                                  } else {
                                                    lengthData = lengthData + 10;
                                                  }
                                                });
                                              },
                                              child: Container(
                                                  margin:
                                                      EdgeInsets.only(top: 20),
                                                  padding: EdgeInsets.fromLTRB(
                                                      15, 8, 15, 8),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: Colors.grey[200]),
                                                  child: Text(
                                                    "Load More",
                                                    style: GoogleFonts.montserrat(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black87),
                                                  )),
                                            ),
                                          )
                                        : SizedBox();
                                  }
                                }),
                          )
                        ],
                      );
                    } else if (state is ListNewsApiError) {
                      return ErrorApiPage(
                        message: state.data.message,
                        height: _height,
                        width: _width,
                      );
                    } else if (state is ListNewsError) {
                      return ErrorNetworkPage(
                        message: state.message,
                        height: _height,
                        width: _width,
                      );
                    } else {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: _height / 3,
                            ),
                            CircularProgressIndicator(),
                          ],
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
