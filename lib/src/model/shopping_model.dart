import 'package:siakad_tpm/src/response/get_chart_response.dart';
import 'package:siakad_tpm/src/response/product_response.dart';

// class Shopping {
//   String id;
//   String title;
//   String description;
//   String barcode;
//   String categoryId;
//   String price;
//   String stok;
//   String unit;
//   Shopping({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.barcode,
//     required this.categoryId,
//     required this.price,
//     required this.stok,
//     required this.unit
//     });
// }

class ShoppingModel {
  bool isloading = false;
  bool isSuccess = false;
  ProductResponse productResponse = ProductResponse();
  GetCartResponse getCartResponse = GetCartResponse();
}
