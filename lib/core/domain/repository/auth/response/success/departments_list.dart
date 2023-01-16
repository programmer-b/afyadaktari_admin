class DepartmentsList {
  int? statusCode;
  String? message;
  Data? data;
  int? total;

  DepartmentsList({this.statusCode, this.message, this.data, this.total});

  DepartmentsList.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['total'] = total;
    return data;
  }
}

class Data {
  int? count;
  List<DataModels>? dataModels;

  Data({this.count, this.dataModels});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['dataModels'] != null) {
      dataModels = <DataModels>[];
      json['dataModels'].forEach((v) {
        dataModels!.add(DataModels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    if (dataModels != null) {
      data['dataModels'] = dataModels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataModels {
  int? id;
  String? name;
  int? createdAt;
  int? updatedAt;

  DataModels({this.id, this.name, this.createdAt, this.updatedAt});

  DataModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}