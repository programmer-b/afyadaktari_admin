import 'dart:convert';

import 'package:afyadaktari_admin/core/domain/repository/auth/response/success/doctors_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

extension StringNotNull on String? {
  String get sntnull => (this ?? '').trim();
}

extension StringExtensions on String {
  String get hide {
    int l = length;
    String s0 = substring(0, l - 8);
    String s2 = substring(l - 2);

    return '$s0******$s2';
  }

  Uri get uri => Uri.parse(this);
}

extension RespEsp on http.Response {
  bool get ok => (statusCode ~/ 100) == 2;
  bool get vlderr => (statusCode ~/ 100) == 4;
  bool get svrerr => (statusCode ~/ 100) == 5;
  Map<String, dynamic> get decode => jsonDecode(body);
}

extension Doctors on DoctorsList {
  String firstName(int index) => data?.dataModels?[index].firstName ?? '';
  String lastName(int index) => data?.dataModels?[index].lastName ?? '';
  String middleName(int index) => data?.dataModels?[index].middleName ?? '';
  String fullName(int index) =>
      '${firstName(index)} ${middleName(index)} ${lastName(index)} ';
  String staffNo(int index) => data?.dataModels?[index].staffNumber ?? '';
  String speciality(int index) => data?.dataModels?[index].speciality ?? '';
}

extension KeysAndValues on Map {
  String keyAt(int index) =>
      "${keys.elementAt(index)}".replaceAll('_', ' ').capitalize();
  String valueAt(int index) => "${values.elementAt(index)}";
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension SnapshotReady on AsyncSnapshot {
  bool get ready {
    return connectionState == ConnectionState.done;
  }
}
