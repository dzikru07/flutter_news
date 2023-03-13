import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../../service/api.dart';

class ServicePage {
  ApiService _apiService = ApiService();

  getListData(String searchValue) async {
    var param = {
      "country": "us",
      "apiKey": _apiService.getApiKey(),
      "category": searchValue
    };
    try {
      http.Response response =
          await _apiService.getApiData("/v2/top-headlines", param);
      return response;
    } catch (e) {
      return e;
    }
  }

}
