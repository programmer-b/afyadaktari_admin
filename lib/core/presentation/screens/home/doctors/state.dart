import 'dart:convert';
import 'dart:developer';

import 'package:afyadaktari_admin/core/domain/repository/auth/response/success/doctors_list.dart';
import 'package:flutter/cupertino.dart';
import '../../../../domain/use_case/home/doctors_use_case.dart';

class DoctorsProvider extends ChangeNotifier {
  Map<String, dynamic> _docs = {};
  Map<String, dynamic> get docs => _docs;

  bool _loading = false;
  bool get loading => _loading;

  void load() {
    _loading = !_loading;
    notifyListeners();
  }

  Future<void> get fetchDoctors async {
    _docs = {};
    _doctorsEmpty = true;
    _doctorsCount = -1;
    load();
    _docs = await doctors;
    _doctorsEmpty = _docs['data']['count'] == 0;
    _doctorsCount = _docs['data']['count'];
    log('COUNT: ${_docs['data']['count']}');
    if (!_doctorsEmpty) _doctorsList = DoctorsList.fromJson(_docs);
    log('DOCS: ${jsonEncode(_docs)}');
    load();
  }

  String _idNo = "";
  String get idNo => _idNo;

  String _firstName = "";
  String get firstName => _firstName;

  String _middleName = "";
  String get middleName => _middleName;

  String _lastName = "";
  String get lastName => _lastName;

  String _email = "";
  String get email => _email;

  String _gender = "";
  String get gender => _gender;

  String _phoneNumber = "";
  String get phoneNumber => _phoneNumber;

  String _specialty = "";
  String get specialty => _specialty;

  String _dateOfBirth = "";
  String get dateOfBirth => _dateOfBirth;

  String _address = "";
  String get address => _address;

  Map<String, dynamic> _reqData = {};
  Map<String, dynamic> get reqData => _reqData;

  Map<String, dynamic> _reqDataErr = {};
  Map<String, dynamic> get reqDataErr => _reqDataErr;

  DoctorsList? _doctorsList;
  DoctorsList? get doctorsList => _doctorsList;

  bool _doctorsEmpty = true;
  bool get doctorsEmpty => _doctorsEmpty;

  int _doctorsCount = -1;
  int get doctorsCount => _doctorsCount;

  bool _apS = false;
  bool get apS => _apS;

  setIdNo(p0) => _idNo = p0;
  setFirstName(p0) => _firstName = p0;
  setMiddleName(p0) => _middleName = p0;
  setLastName(p0) => _lastName = p0;
  setEmail(p0) => _email = p0;
  setGender(p0) => _gender = p0;
  setPhoneNumber(p0) => _phoneNumber = p0;
  setSpecialty(p0) => _specialty = p0;
  setDateOfBirth(p0) => _dateOfBirth = p0;
  setAddress(p0) => _address = p0;

  Future<void> writeDoctor() async {
    _apS = false;
    _reqData = {};
    _reqDataErr = {};

    load();

    final body = {
      "id_number": _idNo,
      "first_name": _firstName,
      "middle_name": _middleName,
      "last_name": _lastName,
      "email": _email,
      "gender": _gender,
      "phone_number": _phoneNumber,
      "speciality": _specialty,
      "date_of_birth": _dateOfBirth,
      "address": _address
    };

    var res = await createDoctor(body);

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
