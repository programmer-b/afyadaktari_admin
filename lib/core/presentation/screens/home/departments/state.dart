import 'dart:convert';
import 'dart:developer';

import 'package:afyadaktari_admin/core/domain/repository/auth/response/success/departments_list.dart';
import 'package:afyadaktari_admin/core/domain/use_case/home/doctors_use_case.dart';
import 'package:flutter/material.dart';

class DepartmentsProvider extends ChangeNotifier {
  Map<String, dynamic> _departs = {};
  Map<String, dynamic> get docs => _departs;

  bool _loading = false;
  bool get loading => _loading;

  bool _departmentsEmpty = true;
  bool get doctorsEmpty => _departmentsEmpty;

  int _departmentsCount = -1;
  int get departmentsCount => _departmentsCount;

  DepartmentsList? _departmentsList;
  DepartmentsList? get doctorsList => _departmentsList;

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
}
