class DoctorsList {
  int? statusCode;
  String? message;
  Data? data;
  int? total;

  DoctorsList({this.statusCode, this.message, this.data, this.total});

  DoctorsList.fromJson(Map<String, dynamic> json) {
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
  String? idNumber;
  String? staffNumber;
  String? firstName;
  String? middleName;
  String? lastName;
  String? email;
  String? gender;
  String? phoneNumber;
  String? speciality;
  String? dateOfBirth;
  String? image;
  String? address;
  String? status;
  int? createdAt;
  int? updatedAt;

  DataModels(
      {this.id,
      this.idNumber,
      this.staffNumber,
      this.firstName,
      this.middleName,
      this.lastName,
      this.email,
      this.gender,
      this.phoneNumber,
      this.speciality,
      this.dateOfBirth,
      this.image,
      this.address,
      this.status,
      this.createdAt,
      this.updatedAt});

  DataModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idNumber = json['id_number'];
    staffNumber = json['staff_number'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    email = json['email'];
    gender = json['gender'];
    phoneNumber = json['phone_number'];
    speciality = json['speciality'];
    dateOfBirth = json['date_of_birth'];
    image = json['image'];
    address = json['address'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_number'] = idNumber;
    data['staff_number'] = staffNumber;
    data['first_name'] = firstName;
    data['middle_name'] = middleName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['gender'] = gender;
    data['phone_number'] = phoneNumber;
    data['speciality'] = speciality;
    data['date_of_birth'] = dateOfBirth;
    data['image'] = image;
    data['address'] = address;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
