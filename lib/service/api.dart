import 'package:http/http.dart' as http;

class ApiService {
  final String _url = "newsapi.org";

  getApiKey() {
    String _apiKey = "5ed063c09d5040cc9894837e19c9ec4e";
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
