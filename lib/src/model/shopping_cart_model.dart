import 'package:siakad_tpm/src/model/santri_list_model.dart';
import 'package:siakad_tpm/src/response/get_chart_response.dart';

class ShoppingCartModel {
  bool isloading = false;
  bool isSuccess = false;
  String idSantri = "";
  String namaSantri = "";
  String selectedBank = "";
  int totalHarga = 0;
  GetCartResponse getCartResponse = GetCartResponse();
  List<Santri> santri = <Santri>[];
}
