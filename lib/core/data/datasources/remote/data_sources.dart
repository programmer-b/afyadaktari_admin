import 'dart:developer';
import 'dart:io';

import 'package:afyadaktari_admin/core/data/utils/strings/common.dart';
import 'package:afyadaktari_admin/core/data/utils/utils.dart';
import 'package:afyadaktari_admin/core/presentation/screens/auth/login/login_provider.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;


abstract class DataSources {
  DataSources();

  Future<Response> post(
      {Map<String, dynamic>? body,
      Map<String, String>? headers,
      required String url});
  Future<Response> put(
      {Map<String, dynamic>? body,
      Map<String, String>? headers,
      required String url});
  Future<Response> delete(
      {Map<String, dynamic>? body,
      Map<String, String>? headers,
      required String url});
  Future<Response> get(
      {Map<String, dynamic>? body,
      Map<String, String>? headers,
      required String url});
}

class DataSourcesImpl implements DataSources {
  DataSourcesImpl();

  String? get token => LoginProvider.credentials?.data?.token;

  late final Map<String, String> headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  @override
  Future<Response> delete(
      {Map<String, dynamic>? body,
      Map<String, String>? headers,
      required String url}) async {
    try {
      return await http.delete(Uri.parse(url),
          body: body, headers: headers ?? this.headers);
    } on SocketException {
      toastE(internetErrorText);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> get(
      {Map<String, dynamic>? body,
      Map<String, String>? headers,
      required String url}) async {
    try {
      return await http.get(Uri.parse(url), headers: headers ?? this.headers);
    } on SocketException {
      toastE(internetErrorText);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> post(
      {Map<String, dynamic>? body,
      Map<String, String>? headers,
      required String url}) async {
    try {
      var r = await http.post(Uri.parse(url), body: body, headers: headers ?? this.headers);
      log(r.body);
      return r;
    } on SocketException {
      toastE(internetErrorText);
      rethrow;
    } catch (e) {
      toastE("$e");
      rethrow;
    }
  }

  @override
  Future<Response> put(
      {Map<String, dynamic>? body,
      Map<String, String>? headers,
      required String url}) async {
    try {
      return await http.put(Uri.parse(url),
          body: body, headers: headers ?? this.headers);
    } on SocketException {
      toastE(internetErrorText);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
