import 'dart:developer';

import 'package:http/http.dart' as http;
import '../../../service/api.dart';

class ServicePage {
  ApiService _apiService = ApiService();

  getListData(String searchValue) async {
    var param = {
      "language": "en",
      "apiKey": _apiService.getApiKey(),
      "q": searchValue
    };
    try {
      http.Response response =
          await _apiService.getApiData("/v2/everything", param);
      inspect(response);
      return response;
    } catch (e) {
      return e;
    }
  }
}
