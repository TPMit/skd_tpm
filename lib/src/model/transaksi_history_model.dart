class Transaksi {
  String id;
  String harga;
  String statusPaid;
  String totalItem;
  String createdAt;
  Transaksi({
  required this.id,
  required this.harga,
  required this.statusPaid,
  required this.totalItem,
  required this.createdAt,
    });
}

class TransaksiHistoryModel {
  int idUser = 0;
  bool isloading = false;
  bool isSuccess = false;
  List<Transaksi> transaksi = <Transaksi>[];
}
