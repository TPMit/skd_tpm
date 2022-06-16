class ProductResponse {
  bool? status;
  List<DataProduct>? dataProduct;

  ProductResponse({this.status, this.dataProduct});

  ProductResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data_product'] != null) {
      dataProduct = <DataProduct>[];
      json['data_product'].forEach((v) {
        dataProduct!.add(DataProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (dataProduct != null) {
      data['data_product'] = dataProduct!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataProduct {
  String? barcode;
  String? categoryId;
  String? categoryImages;
  String? categoryTitle;
  String? createdAt;
  String? description;
  String? id;
  String? price;
  String? stok;
  String? title;
  String? unit;
  List<Images>? images;

  DataProduct(
      {this.barcode,
      this.categoryId,
      this.categoryImages,
      this.categoryTitle,
      this.createdAt,
      this.description,
      this.id,
      this.price,
      this.stok,
      this.title,
      this.unit,
      this.images});

  DataProduct.fromJson(Map<String, dynamic> json) {
    barcode = json['barcode'];
    categoryId = json['category_id'];
    categoryImages = json['category_images'];
    categoryTitle = json['category_title'];
    createdAt = json['created_at'];
    description = json['description'];
    id = json['id'];
    price = json['price'];
    stok = json['stok'];
    title = json['title'];
    unit = json['unit'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['barcode'] = barcode;
    data['category_id'] = categoryId;
    data['category_images'] = categoryImages;
    data['category_title'] = categoryTitle;
    data['created_at'] = createdAt;
    data['description'] = description;
    data['id'] = id;
    data['price'] = price;
    data['stok'] = stok;
    data['title'] = title;
    data['unit'] = unit;
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
