import 'dart:convert';

import 'package:afyadaktari_admin/core/data/datasources/remote/data_sources.dart';
import 'package:afyadaktari_admin/core/data/utils/dart_extensions.dart';
import 'package:afyadaktari_admin/core/data/utils/strings/uris.dart';
import 'package:either_dart/either.dart';

Future<Either<Map<String, dynamic>, Map<String, dynamic>>> changePhoneReq(
    body) async {
  return await _change(changePhoneUrl, body);
}

Future<Either<Map<String, dynamic>, Map<String, dynamic>>> changePasswordReq(
    body) async {
  return await _change(changePasswordUrl, body);
}

Future<Either<Map<String, dynamic>, Map<String, dynamic>>> _change(url, body) async {
  final DataSourcesImpl impl = DataSourcesImpl();
  var res = await impl.post(url: url, body: body);
  if (res.ok) {
    return Left(jsonDecode(res.body));
  } else if (res.vlderr) {
    return Right(jsonDecode(res.body));
  }
  throw (res.body);
}
