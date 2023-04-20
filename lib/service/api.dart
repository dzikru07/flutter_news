import 'package:http/http.dart' as http;

class ApiService {
  final String _url = "newsapi.org";

  getApiKey() {
    String _apiKey = "";
    return _apiKey;
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + getApiKey()
      };

  Future getApiData(String path, var param) async {
    var _fullUrl = Uri.https(_url, path, param);
    return await http.get(_fullUrl, headers: _setHeaders());
  }
}
