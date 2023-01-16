import 'package:afyadaktari_admin/core/data/utils/dart_extensions.dart';
import 'package:afyadaktari_admin/core/data/utils/strings/keys.dart';
import 'package:afyadaktari_admin/core/domain/repository/auth/request/login_request.dart';
import 'package:afyadaktari_admin/core/domain/repository/auth/response/success/login_success.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../domain/use_case/auth/login_use_case.dart';

class LoginProvider extends ChangeNotifier {
  bool _rememberMe = getBoolAsync(keyRememberMe);
  bool get rememberMe => _rememberMe;

  void setRememberMe() {
    _rememberMe = !_rememberMe;
    notifyListeners();
    storeRememberMe();
  }

  void storeRememberMe() async => await setValue(keyRememberMe, _rememberMe);

  IconData _passwordIcon = Icons.visibility;
  IconData get passwordIcon => _passwordIcon;

  bool _passwordVisible = false;
  bool get passwordVisible => _passwordVisible;

  void togglePasswordVisibility() {
    _passwordVisible = !_passwordVisible;
    _passwordIcon = _passwordVisible ? Icons.visibility : Icons.visibility_off;
    notifyListeners();
  }

  String? _password;
  String? _username;

  String? get password => _password;
  String? get username => _username;

  final LoginRequest request = LoginRequest();

  void stP(p0) {
    _password = p0;
    request.password = p0;
    log('PASS: ${request.password}');
  }

  void stU(p0) {
    _username = p0;
    request.username = p0;
    log('USERNAME: ${request.username}');
  }

  static LoginSuccess? credentials;

  String? passErr;
  String? usnErr;

  bool success = false;

  LoginSuccess? _creds;
  LoginSuccess? get creds => _creds;

  Future<void> get login async {
    success = false;

    if (rememberMe) {
      await setValue(keyUsername, username);
      await setValue(keyPassword, password);
    }

    var a = await doLogin(username.sntnull, password.sntnull);
    if (a.isLeft) {
      _creds = a.left;
      credentials = _creds;
      success = true;
    } else if (a.isRight) {
      passErr = a.right.errors?.password?.join();
      usnErr = a.right.errors?.username?.join();
    }
    notifyListeners();
  }
}
