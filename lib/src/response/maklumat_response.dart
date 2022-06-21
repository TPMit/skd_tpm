class MaklumatResponse {
  bool? status;
  List<DataMaklumat>? dataMaklumat;

  MaklumatResponse({this.status, this.dataMaklumat});

  MaklumatResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data_maklumat'] != null) {
      dataMaklumat = <DataMaklumat>[];
      json['data_maklumat'].forEach((v) {
        dataMaklumat!.add(DataMaklumat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (dataMaklumat != null) {
      data['data_maklumat'] =
          dataMaklumat!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataMaklumat {
  String? id;
  String? title;
  String? titleExcerpt;
  String? slug;
  String? thumbnail;
  String? content;
  String? status;
  String? categoryId;
  String? roleId;
  String? userId;
  String? createdAt;
  String? updatedAt;
  String? roleName;
  String? userName;
  String? categoryName;
  String? categorySlug;

  DataMaklumat(
      {this.id,
      this.title,
      this.titleExcerpt,
      this.slug,
      this.thumbnail,
      this.content,
      this.status,
      this.categoryId,
      this.roleId,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.roleName,
      this.userName,
      this.categoryName,
      this.categorySlug});

  DataMaklumat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    titleExcerpt = json['title_excerpt'];
    slug = json['slug'];
    thumbnail = json['thumbnail'];
    content = json['content'];
    status = json['status'];
    categoryId = json['category_id'];
    roleId = json['role_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    roleName = json['role_name'];
    userName = json['user_name'];
    categoryName = json['category_name'];
    categorySlug = json['category_slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['title_excerpt'] = titleExcerpt;
    data['slug'] = slug;
    data['thumbnail'] = thumbnail;
    data['content'] = content;
    data['status'] = status;
    data['category_id'] = categoryId;
    data['role_id'] = roleId;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['role_name'] = roleName;
    data['user_name'] = userName;
    data['category_name'] = categoryName;
    data['category_slug'] = categorySlug;
    return data;
  }
}
