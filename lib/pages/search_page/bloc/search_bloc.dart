import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../component/error_handling/models/error_models.dart';
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
        if (data.statusCode == 200) {
          NewsListModels dataList = newsListModelsFromJson(data.body);
        emit(ListNewsLoaded(dataList));
        } else {
          ErrorModels dataList = errorModelsFromJson(data.body);
          emit(ListNewsApiError(dataList));
        }
      } catch (e) {
        emit(ListNewsError(e.toString()));
      }
    });
  }
}
