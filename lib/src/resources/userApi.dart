// ignore_for_file: file_names, avoid_print

import 'dart:convert';
import '../response/login_response.dart';
import 'package:http/http.dart' as http;

class UserApi {
  static Future<PostResult> connectToApi(String email, String password) async {
    String apiURL = "https://sis.mindotek.com/rest/login";

    var response = await http
        .post(Uri.parse(apiURL), body: {"email": email, "password": password});
    Map<String, dynamic> res = jsonDecode(response.body);
    print(res);
    PostResult postResult = PostResult.fromJson(json.decode(response.body));
    return postResult;
  }
}
