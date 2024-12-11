import 'package:toko_kita/helpers/api.dart';
import 'package:toko_kita/helpers/api_url.dart';
import 'package:toko_kita/model/login.dart';

class LoginBloc {
  static Future<Login> login({String? email, String? password}) async {
    String apiUrl = ApiUrl.login;
    var body = {"email": email, "password": password};
    try {
      final response = await Api().post(apiUrl, body);
      // ignore: avoid_print
      print('Response JSON: $response');
      return Login.fromJson(response);
    } catch (error) {
      // ignore: avoid_print
      print('Error during login : $error');
      rethrow;
    }
  }
}
