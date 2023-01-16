import 'package:flutter/material.dart';

import '../../../../domain/repository/auth/response/success/login_success.dart';

class DashBoardProvider extends ChangeNotifier {
  LoginSuccess? _creds;
  LoginSuccess? get creds => _creds;

  void setCreds(p0) {
    _creds = p0;
    notifyListeners();
  }
}
