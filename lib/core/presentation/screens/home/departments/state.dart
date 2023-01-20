import 'dart:convert';
import 'dart:developer';

import 'package:afyadaktari_admin/core/domain/repository/auth/response/success/departments_list.dart';
import 'package:afyadaktari_admin/core/domain/use_case/home/doctors_use_case.dart';
import 'package:flutter/material.dart';

class DepartmentsProvider extends ChangeNotifier {
  Map<String, dynamic> _departs = {};
  Map<String, dynamic> get departs => _departs;

  bool _loading = false;
  bool get loading => _loading;

  bool _departmentsEmpty = true;
  bool get departmentsEmpty => _departmentsEmpty;

  int _departmentsCount = -1;
  int get departmentsCount => _departmentsCount;

  DepartmentsList? _departmentsList;
  DepartmentsList? get departmentsList => _departmentsList;

  void load() {
    _loading = !_loading;
    notifyListeners();
  }

  Future<void> get fetchDepartments async {
    _departs = {};
    _departmentsEmpty = true;
    _departmentsCount = -1;
    load();
    _departs = await departments;
    _departmentsEmpty = _departs['data']['count'] == 0;
    _departmentsCount = _departs['data']['count'];
    log('COUNT: ${_departs['data']['count']}');
    if (!_departmentsEmpty) {
      _departmentsList = DepartmentsList.fromJson(_departs);
    }
    log('DOCS: ${jsonEncode(_departs)}');
    load();
  }

  String _name = "";
  String get name => _name;

  setName(p0) => _name = p0;

  bool _apS = false;
  bool get apS => _apS;

  Map<String, dynamic> _reqData = {};
  Map<String, dynamic> get reqData => _reqData;

  Map<String, dynamic> _reqDataErr = {};
  Map<String, dynamic> get reqDataErr => _reqDataErr;

  Future<void> writeDepartment() async {
    _apS = false;
    _reqData = {};
    _reqDataErr = {};

    load();

    final body = {"name": _name};

    var res = await createDepartment(body);

    if (res.isLeft) {
      _apS = true;
      _reqData = res.left;
    } else if (res.isRight) {
      _reqDataErr = res.right;
    }

    // log(jsonEncode(res.toString()));
    load();
  }
}
