
import 'package:demo/provider/api.dart';
import 'package:http/http.dart' as http;

class AccountApi extends Api {
  //////////////////////////////////////////////////////////////////
  /// GET LIST USER
  //////////////////////////////////////////////////////////////////
  Future<http.Response> getListUsers(String t) async {
    var header = await getHeader();
    return http.get('$apiBaseUrl/0.4/?randomapi', headers: header).timeout(Duration(seconds: 15));
  }
}
