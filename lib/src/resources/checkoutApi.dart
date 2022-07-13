// ignore_for_file: file_names, avoid_print
import 'dart:io';
import 'package:dio/dio.dart';
// import 'dart:convert';
// import 'package:http/http.dart' show Client;

class CheckoutServices {
  // final Client _client = Client();
  Dio dio = Dio();
  late Response response;

  Future<String> bayarPost(
      String userId,
      amount,
      paymentType,
      List<dynamic> productId,
      price,
      totalItem,
      idCart,
      String santriId) async {
    try {
      FormData formData = FormData.fromMap({
        "user_id": userId,
        "amount": amount,
        "payment_type": paymentType,
        "product_id[]": productId,
        "price[]": price,
        "total_item[]": totalItem,
        "id_cart[]": idCart,
        "santri_id": santriId,
      });
      print(formData);
      final response =
          await dio.post("https://sis.mindotek.com/rest/pay", data: formData);
      if (response.data['status']) {
        return 'berhasil';
      } else {
        return Future.error("Transaksi Gagal 🤷‍♂️");
      }
    } on DioError catch (e) {
      throw Exception(e.response!.data.toString());
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
