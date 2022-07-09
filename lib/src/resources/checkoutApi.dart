// ignore_for_file: file_names, avoid_print
import 'dart:io';
import 'package:dio/dio.dart';
// import 'dart:convert';
// import 'package:http/http.dart' show Client;

class CheckoutServices {
  // final Client _client = Client();
  Dio dio = Dio();
  late Response response;

  Future<String> bayarPost(String data) async {
    try {
      final response =
          await dio.post("https://sis.mindotek.com/rest/pay", data: data);
      if (response.data['status']) {
        return 'berhasil';
      } else {
        return Future.error("Transaksi Gagal 🤷‍♂️");
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
