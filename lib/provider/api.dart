
import 'package:demo/global.dart';
import 'package:demo/provider/shared_pref.dart';

class Api {
  final String apiBaseUrl = Global().env.apiBaseUrl;

  Future<Map<String, String>> getHeader() async {
    var token = await SharedPrefService.internal().getAuthToken();
    Map<String, String> header = token.length > 0
        ? {
            "accept": "application/json",
            "Authorization": "Bearer $token"
          }
        : {
            "accept": "application/json",
          };
    return header;
  }
}
