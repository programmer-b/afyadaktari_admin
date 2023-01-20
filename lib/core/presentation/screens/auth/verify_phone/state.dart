import 'dart:developer';

import 'package:afyadaktari_admin/core/domain/use_case/home/doctors_use_case.dart';
import 'package:flutter/material.dart';

class VerifyPhoneProvider extends ChangeNotifier {
  String _phone = '';
  String get phone => _phone;

  String _userId = '';
  String get userId => _userId;

  settPhone(p0) => _phone = p0;

  bool _success = false;
  bool get success => _success;

  bool _error = false;
  bool get error => _error;

  Map<String, dynamic> _data = {};
  Map<String, dynamic> get data => _data;

  Map<String, dynamic> _dataErr = {};
  Map<String, dynamic> get dataErr => _dataErr;

  static String tempToken = "";
  static String tempUserId = "";

  Future<void> get resetPassword async {
    _success = false;
    _data = {};
    _error = false;
    _dataErr = {};

    var body = {'mobile': _phone};
    final res = await requestPassReset(body);
    log(res.toString());

    if (res.isLeft) {
      _success = true;
      _data = res.left;
      _phone = _data['data']["phone number"];
      _userId = "${_data['data']["user_id"]}";
      tempUserId = _userId;
      tempToken = "${_data['data']["token"]}";
    } else {
      _error = true;
      _dataErr = res.right;
    }
    notifyListeners();
  }
}
