import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_news/component/error_handling/view/empty_list.dart';
import 'package:flutter_news/pages/favourite_page/models/article_models.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../component/format/time_format.dart';
import '../../../style/color.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  List<ArticlesModel> listData = [];

  getDataLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString('action');
    if (action == null) {
      setState(() {
        listData = [];
      });
    } else {
      setState(() {
        listData = articlesModelFromJson(action.toString());
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataLocal();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: listData.isEmpty
            ? Center(
                child: EmptyListPage(
                    message: "No Data Has Been Saved",
                    height: _height,
                    width: _width),
              )
            : SingleChildScrollView(
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
                      ListView.builder(
                          itemCount: listData.length,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () async {
                                Navigator.of(context).pushNamed("/card/detail",
                                    arguments: listData[index]);
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  listData[index]
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
                                          width: _width / 1.6,
                                          child: Text(
                                            listData[index].title,
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
                                            listData[index]
                                                .description
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
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Text(
                                                    FormatData().getDataFormat(
                                                        listData[index]
                                                            .publishedAt),
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.white),
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
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Text(
                                                    listData[index]
                                                        .author
                                                        .toString(),
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.white),
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
                          }),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
