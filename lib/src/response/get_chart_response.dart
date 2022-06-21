class GetCartResponse {
  bool? status;
  List<DataCart>? dataCart;

  GetCartResponse({this.status, this.dataCart});

  GetCartResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data_cart'] != null) {
      dataCart = <DataCart>[];
      json['data_cart'].forEach((v) {
        dataCart!.add(DataCart.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (dataCart != null) {
      data['data_cart'] = dataCart!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataCart {
  String? barcode;
  String? categoryId;
  String? createdAt;
  String? description;
  String? id;
  String? price;
  String? stok;
  String? title;
  String? satuan;
  String? namaWali;
  String? idWaliSantri;
  String? idCart;
  List<Images>? images;
  late int qty;

  DataCart(
      {this.barcode,
      this.categoryId,
      this.createdAt,
      this.description,
      this.id,
      this.price,
      this.stok,
      this.title,
      this.satuan,
      this.namaWali,
      this.idWaliSantri,
      this.idCart,
      this.images,
      required this.qty});

  DataCart.fromJson(Map<String, dynamic> json) {
    barcode = json['barcode'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    description = json['description'];
    id = json['id'];
    price = json['price'];
    stok = json['stok'];
    title = json['title'];
    satuan = json['satuan'];
    namaWali = json['nama_wali'];
    idWaliSantri = json['id_wali_santri'];
    idCart = json['id_cart'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    qty = 1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['barcode'] = barcode;
    data['category_id'] = categoryId;
    data['created_at'] = createdAt;
    data['description'] = description;
    data['id'] = id;
    data['price'] = price;
    data['stok'] = stok;
    data['title'] = title;
    data['satuan'] = satuan;
    data['nama_wali'] = namaWali;
    data['id_wali_santri'] = idWaliSantri;
    data['id_cart'] = idCart;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  String? id;
  String? productId;
  String? fileName;
  String? createdAt;

  Images({this.id, this.productId, this.fileName, this.createdAt});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    fileName = json['file_name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['file_name'] = fileName;
    data['created_at'] = createdAt;
    return data;
  }
}
