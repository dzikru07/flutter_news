import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../pages/favourite_page/models/article_models.dart';

part 'local_data_state.dart';

class LocalDataCubit extends Cubit<LocalDataState> {
  LocalDataCubit() : super(LocalDataInitial());

  List<ArticlesModel> listData = [];

  getDataLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString('action');
    if (action == null) {
      listData = [];
      emit(LocalDataSuccess(listData));
    } else {
      listData = articlesModelFromJson(action.toString());
      emit(LocalDataSuccess(listData));
    }
  }

  addDataToLocal(ArticlesModel value) async {
    listData.add(value);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('action', jsonEncode(listData));
  }
}
