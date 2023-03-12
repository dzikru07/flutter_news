// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/pages/home_page/models/news_models.dart';
import 'package:flutter_news/pages/home_page/service/service_page.dart';
import 'package:meta/meta.dart';

part 'home_bloc_event.dart';
part 'home_bloc_state.dart';

class HomeBlocBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  HomeBlocBloc() : super(HomeBlocInitial()) {
    ServicePage servicePage = ServicePage();

    on<HomeBlocEvent>((event, emit) async {
      try {
        emit(ListNewsLoading());
        final data = await servicePage.getListData();
        NewsListModels dataList = newsListModelsFromJson(data.body);
        emit(ListNewsLoaded(dataList));
      } catch (e) {
        emit(ListNewsError(e.toString()));
      }
    });
  }
}

class HomeBlocBlocWithSearch
    extends Bloc<HomeBlocEventWithSearch, HomeBlocState> {
  HomeBlocBlocWithSearch() : super(HomeBlocInitial()) {
    ServicePage servicePage = ServicePage();

    on<HomeBlocEventWithSearch>((event, emit) async {
      try {
        emit(ListNewsLoading());
        final data = await servicePage
            .getListDataWithSearch(event.searchValue.toString());
        NewsListModels dataList = newsListModelsFromJson(data.body);
        emit(ListNewsLoaded(dataList));
      } catch (e) {
        emit(ListNewsError(e.toString()));
      }
    });
  }
}
