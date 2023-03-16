import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../component/error_handling/view/api_error.dart';
import '../../../component/error_handling/view/network_error.dart';
import '../../../component/format/time_format.dart';
import '../../../component/local_data/cubit/local_data_cubit.dart';
import '../../../style/color.dart';
import '../../favourite_page/models/article_models.dart';
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
            create: (context) => HomeBlocBloc()..add(HomeBlocEvent(category)),
          ),
          BlocProvider(
            create: (context) => LocalDataCubit(),
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

class _ListNewsCategoryBlocState extends State<ListNewsCategoryBloc>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> animated;

  int dataFav = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );

    animated = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    );

    context.read<LocalDataCubit>().getDataLocal();
  }

  runAnimationControllerShow() async {
    _controller.repeat();
    await _controller.forward();
    await Future.delayed(const Duration(
      milliseconds: 600,
    ));
    _controller.reset();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HomeBlocBloc cobaListData = context.read<HomeBlocBloc>();
    LocalDataCubit listDataCubit = context.read<LocalDataCubit>();

    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return BlocBuilder<HomeBlocBloc, HomeBlocState>(
      bloc: cobaListData,
      builder: (context, state) {
        if (state is ListNewsLoaded) {
          return AnimationLimiter(
            child: ListView.builder(
                itemCount: state.listData.articles.length,
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
                            child: BlocConsumer<LocalDataCubit, LocalDataState>(
                              listener: (context, state2) {
                                // TODO: implement listener
                              },
                              builder: (context, state3) {
                                return InkWell(
                                  onTap: () async {
                                    if (state3 is LocalDataSuccess) {
                                      Navigator.of(context).pushNamed(
                                        "/card/detail",
                                        arguments:
                                            state.listData.articles[index]);
                                    }
                                    
                                  },
                                  onDoubleTap: () async {
                                    if (state3 is LocalDataSuccess) {
                                      setState(() {
                                      dataFav = index;
                                    });
                                    var data = state3.listData.where(
                                        (element) =>
                                            element.title ==
                                            state.listData.articles[index]
                                                .title);
                                                print(data);
                                    if (data.isEmpty) {
                                      context.read<LocalDataCubit>().addDataToLocal(ArticlesModel(
                                          source: Source(
                                              id:  state.listData.articles
                                                  [index].source.id
                                                  .toString(),
                                              name:  state.listData.articles
                                                  [index]
                                                  .source
                                                  .name),
                                          author:  state.listData.articles
                                              [index].author
                                              .toString(),
                                          title:  state.listData.articles
                                              [index].title,
                                          description:  state.listData.articles
                                              [index].description
                                              .toString(),
                                          url:  state.listData.articles[index].url,
                                          urlToImage:  state.listData.articles
                                              [index].urlToImage
                                              .toString(),
                                          publishedAt:  state.listData.articles[index].publishedAt,
                                          content:  state.listData.articles[index].content.toString()));
                                    }
                                    runAnimationControllerShow();
                                    }
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
                                        Stack(
                                          alignment:
                                              AlignmentDirectional.center,
                                          children: [
                                            Container(
                                              height: 110,
                                              width: 110,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          state
                                                              .listData
                                                              .articles[
                                                                  index]
                                                              .urlToImage
                                                              .toString()),
                                                      fit: BoxFit.cover)),
                                            ),
                                            dataFav == index
                                                ? ScaleTransition(
                                                    scale: animated,
                                                    child: Icon(
                                                      Icons.favorite,
                                                      size: 45,
                                                      color: Colors.red,
                                                    ),
                                                  )
                                                : SizedBox()
                                          ],
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
                                                state.listData
                                                    .articles[index].title,
                                                overflow:
                                                    TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style:
                                                    GoogleFonts.montserrat(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            cardTitleColor),
                                              ),
                                            ),
                                            SizedBox(
                                              width: _width / 1.8,
                                              child: Text(
                                                state
                                                    .listData
                                                    .articles[index]
                                                    .description
                                                    .toString(),
                                                overflow:
                                                    TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500,
                                                    color:
                                                        cardSubTitleColor),
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
                                                                fontSize:
                                                                    12,
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
                                                                fontSize:
                                                                    12,
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
                              },
                            ),
                          )));
                }),
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
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
