// ignore_for_file: avoid_print, file_names

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../response/get_chart_response.dart';
import '../response/product_response.dart';
import '../response/transaksiHistory_response.dart';

class ShoppingServices {
  final Client _client = Client();
  

  Future<ProductResponse> getDataProduct() async {
    try {
      final response = await _client.get(Uri.parse(
          "https://sis.mindotek.com/rest/getproduct"));
      print(response.body);
      if (response.statusCode == 200) {
        ProductResponse productResponse =
            ProductResponse.fromJson(json.decode(response.body));
        return productResponse;
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

  Future addCart(String userId, String productId) async {
    try {
      final response = await _client.post(
          Uri.parse('https://sis.mindotek.com/rest/addcart'),
          body: {
            'user_id': userId,
            'product_id': productId,
          });
      print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> res = jsonDecode(response.body);
        return res['message'];
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

  Future<GetCartResponse> getcart(String userId) async {
    try {
      final response = await _client
          .get(Uri.parse("https://sis.mindotek.com/rest/getcart?user_id=$userId"));
      print(response.body);
      if (response.statusCode == 200) {
        GetCartResponse getCartResponse =
            GetCartResponse.fromJson(json.decode(response.body));
        return getCartResponse;
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

  Future deleteCart(String idCart) async {
    try {
      final response = await _client
          .post(Uri.parse('https://sis.mindotek.com/rest/deleteCart'), body: {
        'id_cart': idCart,
      });
      print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> res = jsonDecode(response.body);
        return res['message'];
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

    Future<TransaksiHistoryResponse> getTransaksiHistory(String userId) async {
    try {
      final response = await _client.get(
          Uri.parse("https://sis.mindotek.com/rest/GetTransactionByWali?user_id=$userId"));
      print(response.body);
      if (response.statusCode == 200) {
        TransaksiHistoryResponse transaksiHistoryResponse =
            TransaksiHistoryResponse.fromJson(json.decode(response.body));
        return transaksiHistoryResponse;
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