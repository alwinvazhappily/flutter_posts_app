import 'package:http/http.dart' as http;

class ApiHelper {
  static Future<http.Response> get(String url) async {
    try {
      return await http.get(Uri.parse(url));
    } catch (e) {
      rethrow;
    }
  }
}
