// ignore_for_file: file_names

class TransaksiHistoryResponse {
  bool? status;
  List<DataTransaction>? dataTransaction;

  TransaksiHistoryResponse({this.status, this.dataTransaction});

  TransaksiHistoryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data_transaction'] != null) {
      dataTransaction = <DataTransaction>[];
      json['data_transaction'].forEach((v) {
        dataTransaction!.add(DataTransaction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (dataTransaction != null) {
      data['data_transaction'] =
          dataTransaction!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataTransaction {
  String? id;
  String? grossAmount;
  String? statusPaid;
  String? orderId;
  String? paidAt;
  String? createdAt;
  String? nis;
  String? saldo;
  String? name;
  String? email;
  String? userId;
  String? roleId;
  String? images;
  String? totalItem;

  DataTransaction(
      {this.id,
      this.grossAmount,
      this.statusPaid,
      this.orderId,
      this.paidAt,
      this.createdAt,
      this.nis,
      this.saldo,
      this.name,
      this.email,
      this.userId,
      this.roleId,
      this.images,
      this.totalItem});

  DataTransaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    grossAmount = json['gross_amount'];
    statusPaid = json['status_paid'];
    orderId = json['order_id'];
    paidAt = json['paid_at'];
    createdAt = json['created_at'];
    nis = json['nis'];
    saldo = json['saldo'];
    name = json['name'];
    email = json['email'];
    userId = json['user_id'];
    roleId = json['role_id'];
    images = json['images'];
    totalItem = json['total_item'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['gross_amount'] = grossAmount;
    data['status_paid'] = statusPaid;
    data['order_id'] = orderId;
    data['paid_at'] = paidAt;
    data['created_at'] = createdAt;
    data['nis'] = nis;
    data['saldo'] = saldo;
    data['name'] = name;
    data['email'] = email;
    data['user_id'] = userId;
    data['role_id'] = roleId;
    data['images'] = images;
    data['total_item'] = totalItem;
    return data;
  }
}
