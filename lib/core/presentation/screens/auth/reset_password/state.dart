import 'dart:developer';

import 'package:afyadaktari_admin/core/domain/use_case/home/doctors_use_case.dart';
import 'package:afyadaktari_admin/core/presentation/screens/auth/verify_phone/state.dart';
import 'package:flutter/cupertino.dart';

class ResetPasswordProvider extends ChangeNotifier {
  bool _showNewPassword = false;
  bool get showNewPassword => _showNewPassword;

  bool _showConfirmPassword = false;
  bool get showConfirmPassword => _showConfirmPassword;

  setNewPassword() {
    _showNewPassword = !_showNewPassword;
    notifyListeners();
  }

  setConfirmPassword() {
    _showConfirmPassword = !_showConfirmPassword;
    notifyListeners();
  }

  String _newPass = '';
  String get newPass => _newPass;

  String _confirmPass = '';
  String get confirmPass => _confirmPass;

  setNewPass(p0) => _newPass = p0;
  setConfirmPass(p0) => _confirmPass = p0;

  bool _apS = false;
  bool get apS => _apS;

  Map<String, dynamic> _reqData = {};
  Map<String, dynamic> get reqData => _reqData;

  Map<String, dynamic> _reqDataErr = {};
  Map<String, dynamic> get reqDataErr => _reqDataErr;

  bool _loading = false;
  bool get loading => _loading;

  void load() {
    _loading = !_loading;
    notifyListeners();
  }

  Future<void> get resetPasswordReq async {
    _apS = false;
    _reqData = {};
    _reqDataErr = {};

    load();
    var body = {
      'user_id': VerifyPhoneProvider.tempUserId,
      'password': _newPass,
      'confirm_password': _confirmPass
    };

    var res = await resetPassword(body);
    _change(body, res);
  }

  _change(body, res) {
    log(res.toString());

    if (res.isLeft) {
      _apS = true;
      _reqData = res.left;
    } else if (res.isRight) {
      _reqDataErr = res.right;
    }
    notifyListeners();
  }
}
