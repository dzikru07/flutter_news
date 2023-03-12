import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../component/format/time_format.dart';
import '../../../style/color.dart';
import '../bloc/home_bloc_bloc.dart';

class ListNewsCategory extends StatelessWidget {
  ListNewsCategory({super.key, required this.category});

  String category;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeBlocBlocWithSearch()
              ..add(HomeBlocEventWithSearch(category)),
          ),
        ],
        child: ListNewsCategoryBloc(),
      ),
    );
  }
}

class ListNewsCategoryBloc extends StatefulWidget {
  const ListNewsCategoryBloc({super.key});

  @override
  State<ListNewsCategoryBloc> createState() => _ListNewsCategoryBlocState();
}

class _ListNewsCategoryBlocState extends State<ListNewsCategoryBloc> {
  @override
  Widget build(BuildContext context) {
    HomeBlocBlocWithSearch cobaListData =
        context.read<HomeBlocBlocWithSearch>();

    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return BlocBuilder<HomeBlocBlocWithSearch, HomeBlocState>(
      bloc: cobaListData,
      builder: (context, state) {
        if (state is ListNewsLoaded) {
          return ListView.builder(
              itemCount: state.listData.articles.length,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    Navigator.of(context).pushNamed("/card/detail",
                        arguments: state.listData.articles[index]);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                        color: cardMainColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        Container(
                          height: 110,
                          width: 110,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(state
                                      .listData.articles[index].urlToImage
                                      .toString()),
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: _width / 1.6,
                              child: Text(
                                state.listData.articles[index].title,
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
                                state.listData.articles[index].description
                                    .toString(),
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
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: cardDateColor,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Text(
                                        FormatData().getDataFormat(state
                                            .listData
                                            .articles[index]
                                            .publishedAt),
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
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Text(
                                        state.listData.articles[index].author
                                            .toString(),
                                        style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
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
              });
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
