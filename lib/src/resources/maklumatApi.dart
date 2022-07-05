// ignore_for_file: avoid_print, file_names

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:siakad_tpm/src/response/maklumat_response.dart';

class MaklumatServices {
  final Client _client = Client();

  Future<MaklumatResponse> getData() async {
    try {
      final response = await _client
          .get(Uri.parse("https://sis.mindotek.com/rest/getMaklumat"));
      print(response.body);
      if (response.statusCode == 200) {
        MaklumatResponse maklumatResponse =
            MaklumatResponse.fromJson(json.decode(response.body));
        return maklumatResponse;
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
    } catch (e) {
      print('====');
      print(e.toString());
      return Future.error(e);
    }
  }

  Future<MaklumatResponse> getDataLimit() async {
    try {
      final response = await _client
          .get(Uri.parse("https://sis.mindotek.com/rest/getMaklumat?limit=2"));
      print(response.body);
      if (response.statusCode == 200) {
        MaklumatResponse maklumatResponse =
            MaklumatResponse.fromJson(json.decode(response.body));
        return maklumatResponse;
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
    } catch (e) {
      print('====');
      print(e.toString());
      return Future.error(e);
    }
  }
}