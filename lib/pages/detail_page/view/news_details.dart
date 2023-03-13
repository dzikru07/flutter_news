import 'package:flutter/material.dart';
import 'package:flutter_news/component/format/time_format.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

import '../../../style/color.dart';
import '../../home_page/models/news_models.dart';

class NewsDetailsPage extends StatefulWidget {
  NewsDetailsPage({super.key, required this.data});

  var data;

  @override
  State<NewsDetailsPage> createState() => _NewsDetailsPageState();
}

class _NewsDetailsPageState extends State<NewsDetailsPage> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: _height / 2.5,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(50)),
                        image: DecorationImage(
                            image: NetworkImage(
                              widget.data.urlToImage.toString(),
                            ),
                            fit: BoxFit.cover)),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(8, 4, 20, 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white.withOpacity(0.5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            UniconsLine.arrow_left,
                            color: Colors.black87,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Detail',
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600, fontSize: 14),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            // Text(
                            //   widget.data.source.toString(),
                            //   style: GoogleFonts.montserrat(
                            //       fontSize: 12,
                            //       fontWeight: FontWeight.w600,
                            //       color: cardSubTitleColor),
                            // ),
                            // SizedBox(
                            //   width: _width / 14,
                            // ),
                            Text(
                              FormatData()
                                  .getDataFormat(widget.data.publishedAt),
                              style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: cardSubTitleColor),
                            )
                          ],
                        ),
                        Icon(
                          UniconsLine.bookmark,
                          color: cardSubTitleColor,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.data.title,
                      style: GoogleFonts.montserrat(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: cardTitleColor),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.data.description.toString(),
                      style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: cardSubTitleColor),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icons/author_logo.png",
                          height: 70,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.data.author.toString(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: cardTitleColor),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              widget.data.source.name.toString(),
                              style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: cardSubTitleColor),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
