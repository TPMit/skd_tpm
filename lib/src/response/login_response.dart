class PostResult {
  String? id;
  String? name;
  String? email;
  String? rememberToken;
  String? roleId;
  String? status;
  String? images;
  String? createdAt;
  String? roleName;
  String? slug;

  PostResult(
      {this.id,
      this.name,
      this.email,
      this.rememberToken,
      this.roleId,
      this.status,
      this.images,
      this.createdAt,
      this.roleName,
      this.slug});

  PostResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    rememberToken = json['remember_token'];
    roleId = json['role_id'];
    status = json['status'];
    images = json['images'];
    createdAt = json['created_at'];
    roleName = json['role_name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['remember_token'] = rememberToken;
    data['role_id'] = roleId;
    data['status'] = status;
    data['images'] = images;
    data['created_at'] = createdAt;
    data['role_name'] = roleName;
    data['slug'] = slug;
    return data;
  }
}
