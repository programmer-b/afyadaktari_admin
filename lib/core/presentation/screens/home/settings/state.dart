import 'dart:developer';

import 'package:afyadaktari_admin/core/domain/use_case/home/settings_use_case.dart';
import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  String _oldPhone = '';
  String _newPhone = '';
  String _confirmPhone = '';

  String get oldPhone => _oldPhone;
  String get newPhone => _newPhone;
  String get confirmPhone => _confirmPhone;

  String _oldPassword = '';
  String _newPassword = '';
  String _confirmPassword = '';

  String get oldPassword => _oldPassword;
  String get newPassword => _newPassword;
  String get confirmPassword => _confirmPassword;

  void setOldPhone(p0) => _oldPhone = p0;
  void setNewPhone(p0) => _newPhone = p0;
  void setConfirmPhone(p0) => _confirmPhone = p0;

  void setOldPassword(p0) => _oldPassword = p0;
  void setNewPassword(p0) => _newPassword = p0;
  void setConfirmPassword(p0) => _confirmPassword = p0;

  bool _loading = false;
  bool get loading => _loading;

  void load() {
    _loading = !_loading;
    notifyListeners();
  }

  bool _apS = false;
  bool get apS => _apS;

  Map<String, dynamic> _reqData = {};
  Map<String, dynamic> get reqData => _reqData;

  Map<String, dynamic> _reqDataErr = {};
  Map<String, dynamic> get reqDataErr => _reqDataErr;

  Future<void> get changePhone async {
    _apS = false;
    _reqData = {};
    _reqDataErr = {};

    load();
    var body = {
      'current_mobile': _oldPhone,
      'new_mobile': _newPhone,
      'confirm_mobile': confirmPhone
    };

    var res = await changePhoneReq(body);
    _change(body, res);
  }

  Future<void> get changePassword async {
    _apS = false;
    _reqData = {};
    _reqDataErr = {};

    load();
    var body = {
      'current_password': _oldPassword,
      'new_password': _newPassword,
      'confirm_password': confirmPassword
    };

    var res = await changePasswordReq(body);
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

  bool _showOldPassword = true;
  bool _showNewPassword = false;
  bool _showConfirmPassword = false;

  bool get showOldPassword => _showOldPassword;
  bool get showNewPassword => _showNewPassword;
  bool get showConfirmPassword => _showConfirmPassword;

  IconData _oldPasswordIcon = Icons.visibility;
  IconData _newPasswordIcon = Icons.visibility;
  IconData _confirmPasswordIcon = Icons.visibility;

  IconData get oldPasswordIcon => _oldPasswordIcon;
  IconData get newPasswordIcon => _newPasswordIcon;
  IconData get confirmPasswordIcon => _confirmPasswordIcon;

  void setShowOldPassword() {
    _showOldPassword = !_showOldPassword;
    _oldPasswordIcon =
        _showOldPassword ? Icons.visibility_off : Icons.visibility;
    notifyListeners();
  }

  void setShowNewPassword() {
    _showNewPassword = !_showNewPassword;
    _newPasswordIcon =
        _showNewPassword ? Icons.visibility_off : Icons.visibility;
    notifyListeners();
  }

  void setShowConfirmPassword() {
    _showConfirmPassword = !_showConfirmPassword;
    _confirmPasswordIcon =
        _showConfirmPassword ? Icons.visibility_off : Icons.visibility;
    notifyListeners();
  }
}
