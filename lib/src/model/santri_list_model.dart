class Santri {
  String idSantri;
  String nis;
  String jenisKelamin;
  String tempatLahir;
  String tanggalLahir;
  String saldo;
  String name;
  String email;
  String roleId;
  String status;
  String images;
  Santri({
  required this.idSantri,
  required this.nis,
  required this.jenisKelamin,
  required this.tempatLahir,
  required this.tanggalLahir,
  required this.saldo,
  required this.name,
  required this.email,
  required this.roleId,
  required this.status,
  required this.images,
  });
}

class SantriListModel {
  int idUser = 0;
  bool isloading = false;
  bool isSuccess = false;
  List<Santri> santri = <Santri>[];
}