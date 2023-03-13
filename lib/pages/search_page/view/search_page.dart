import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

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
                            height: 40,
                            width: _width / 1.5,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(12)),
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
                        children: [
                          Text(
                            'Number of News ${state.listData.totalResults}',
                            style: GoogleFonts.montserrat(
                                fontSize: 12,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ListView.builder(
                              itemCount: 5,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () async {
                                    // Navigator.of(context).pushNamed("/card/detail",
                                    //     arguments: state.listData.articles[index]);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    margin: EdgeInsets.only(top: 15),
                                    decoration: BoxDecoration(
                                        color: cardMainColor,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Row(
                                      children: [
                                        // Container(
                                        //   height: 110,
                                        //   width: 110,
                                        //   decoration: BoxDecoration(
                                        //       borderRadius: BorderRadius.circular(10),
                                        //       image: DecorationImage(
                                        //           image: NetworkImage(state
                                        //               .listData.articles[index].urlToImage
                                        //               .toString()),
                                        //           fit: BoxFit.cover)),
                                        // ),
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
                                              width: _width / 1.6,
                                              child: Text(
                                                "state.listData.articles[index].title",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: cardTitleColor),
                                              ),
                                            ),
                                            SizedBox(
                                              width: _width / 1.6,
                                              child: Text(
                                                "state.listData.articles[index].description.toString()",
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
                                            SizedBox(
                                              width: _width / 1.6,
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                          color: cardDateColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                      child: Text(
                                                        "asdlkasd adm;asd al;sd",
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
                                                                  .circular(5)),
                                                      child: Text(
                                                        "mdf sdlksf sfklsf sn",
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
                                );
                              })
                        ],
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
