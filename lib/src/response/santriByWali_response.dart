// ignore_for_file: file_names

class SantryByWaliResponse {
  bool? status;
  List<DataSantri>? dataSantri;

  SantryByWaliResponse({this.status, this.dataSantri});

  SantryByWaliResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data_santri'] != null) {
      dataSantri = <DataSantri>[];
      json['data_santri'].forEach((v) {
        dataSantri!.add(DataSantri.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (dataSantri != null) {
      data['data_santri'] = dataSantri!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataSantri {
  String? idSantri;
  String? nis;
  String? jenisKelamin;
  String? tempatLahir;
  String? tanggalLahir;
  String? tagId;
  String? waliId;
  String? saldo;
  String? name;
  String? email;
  String? id;
  String? roleId;
  String? status;
  String? images;

  DataSantri(
      {this.idSantri,
      this.nis,
      this.jenisKelamin,
      this.tempatLahir,
      this.tanggalLahir,
      this.tagId,
      this.waliId,
      this.saldo,
      this.name,
      this.email,
      this.id,
      this.roleId,
      this.status,
      this.images});

  DataSantri.fromJson(Map<String, dynamic> json) {
    idSantri = json['id_santri'];
    nis = json['nis'];
    jenisKelamin = json['jenis_kelamin'];
    tempatLahir = json['tempat_lahir'];
    tanggalLahir = json['tanggal_lahir'];
    tagId = json['tag_id'];
    waliId = json['wali_id'];
    saldo = json['saldo'];
    name = json['name'];
    email = json['email'];
    id = json['id'];
    roleId = json['role_id'];
    status = json['status'];
    images = json['images'] ?? 'kosong';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_santri'] = idSantri;
    data['nis'] = nis;
    data['jenis_kelamin'] = jenisKelamin;
    data['tempat_lahir'] = tempatLahir;
    data['tanggal_lahir'] = tanggalLahir;
    data['tag_id'] = tagId;
    data['wali_id'] = waliId;
    data['saldo'] = saldo;
    data['name'] = name;
    data['email'] = email;
    data['id'] = id;
    data['role_id'] = roleId;
    data['status'] = status;
    data['images'] = images;
    return data;
  }
}
