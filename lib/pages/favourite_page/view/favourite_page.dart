
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/component/error_handling/view/empty_list.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../component/format/time_format.dart';
import '../../../component/local_data/cubit/local_data_cubit.dart';
import '../../../style/color.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocProvider(
        create: (context) => LocalDataCubit(),
        child: FavouritePageBloc(),
      ),
    );
  }
}

class FavouritePageBloc extends StatefulWidget {
  const FavouritePageBloc({super.key});

  @override
  State<FavouritePageBloc> createState() => _FavouritePageBlocState();
}

class _FavouritePageBlocState extends State<FavouritePageBloc> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<LocalDataCubit>().getDataLocal();
  }

  

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<LocalDataCubit, LocalDataState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is LocalDataSuccess) {
              if (state.listData.isEmpty) {
                return Center(
                    child: EmptyListPage(
                        message: "No Data Has Been Saved",
                        height: _height,
                        width: _width),
                  );
              }
              return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Favourite News',
                      style: GoogleFonts.montserrat(
                          fontSize: 28,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600),
                    ),
                    AnimationLimiter(
                      child: ListView.builder(
                          itemCount: state.listData.length,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemBuilder: (context, index) {
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
                                          arguments: state.listData[index]);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      margin: EdgeInsets.only(
                                          top: 15, left: 8, right: 8),
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
                                                    image: NetworkImage(
                                                        state.listData[index]
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
                                                  state.listData[index].title,
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
                                                  state.listData[index]
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
                                                              .getDataFormat(
                                                                  state.listData[
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
                                                          state.listData[index]
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
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            );
            } else  {
             return Center(
                    child: CircularProgressIndicator()
                  );
            }
          },
        ),
      ),
    );
  }
}
