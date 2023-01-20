import 'dart:developer';

import 'package:afyadaktari_admin/core/domain/use_case/home/doctors_use_case.dart';
import 'package:flutter/material.dart';

class OTPHandlerProvider extends ChangeNotifier {
  String _otp = "";
  String get otp => _otp;

  setOTP(p0) => _otp = p0;

  bool _success = false;
  bool get success => _success;

  bool _error = false;
  bool get error => _error;

  Map<String, dynamic> _data = {};
  Map<String, dynamic> get data => _data;

  Map<String, dynamic> _dataErr = {};
  Map<String, dynamic> get dataErr => _dataErr;


  Future<void> verifyNumber(userId) async {
    _success = false;
    _data = {};
    _error = false;
    _dataErr = {};

    var body = {'user_id': "$userId", 'OTP': _otp};
    log(body.toString());
    final res = await verifyOTP(body);
    log(res.toString());

    if (res.isLeft) {
      _success = true;
      _data = res.left;
    } else {
      _error = true;
      _dataErr = res.right;
    }
    notifyListeners();
  }
}
