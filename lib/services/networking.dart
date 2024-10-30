import "package:http/http.dart" as http;
import 'dart:convert' as convert;

class NetworkHelper {
  NetworkHelper(this.url);
  final Uri url;

  Future getData() async {
    http.Response res = await http.get(url);
    if (res.statusCode == 200) {
      return convert.jsonDecode(res.body);
    } else {
      print(res.statusCode);
    }
  }
}
