class LoginSuccess {
  int? statusCode;
  String? message;
  Data? data;
  String? total;

  LoginSuccess({this.statusCode, this.message, this.data, this.total});

  LoginSuccess.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  String? phoneNumber;
  String? token;

  Data({this.userId, this.phoneNumber, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    phoneNumber = json['phone number'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['phone number'] = phoneNumber;
    data['token'] = token;
    return data;
  }
}
