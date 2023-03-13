import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../home_page/models/news_models.dart';
import '../service/service_page.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    ServicePage servicePage = ServicePage();
    on<SearchEvent>((event, emit) async {
      try {
        emit(ListNewsLoading());
        final data =
            await servicePage.getListData(event.searchValue.toString());
        NewsListModels dataList = newsListModelsFromJson(data.body);
        emit(ListNewsLoaded(dataList));
      } catch (e) {
        emit(ListNewsError(e.toString()));
      }
    });
  }
}
