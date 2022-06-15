// ignore_for_file: file_names, avoid_print
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:siakad_tpm/src/response/santriByWali_response.dart';

class SantriServices {
  final Client _client = Client();

  Future<SantryByWaliResponse> getData(String idWali) async {
    try{
      final response = await _client.get(
          Uri.parse("https://sis.mindotek.com/rest/getsantribywali?user_id=$idWali"));
      print(response.body);
      if (response.statusCode == 200) {
        SantryByWaliResponse santryByWaliResponse =
            SantryByWaliResponse.fromJson(json.decode(response.body));
        return santryByWaliResponse;
      } else {
        return Future.error("data kosong 🤷‍♂️");
      }

    } on SocketException {
      return Future.error("Yah, Internet Kamu error!😑");
    } on HttpException {
      print("Fungsi post ga nemu 😱");
      // return Future.error("Fungsi post ga nemu 😱");
      return Future.error("terjadi error");
    } on FormatException {
      print("Response format kacauu! 👎");
      // return Future.error("Response format kacauu! 👎");
      return Future.error("terjadi error");
    }
  }
}