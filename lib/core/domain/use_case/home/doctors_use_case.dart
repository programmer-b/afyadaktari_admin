import 'dart:convert';
import 'dart:developer';

import 'package:afyadaktari_admin/core/data/utils/dart_extensions.dart';
import 'package:afyadaktari_admin/core/data/utils/strings/uris.dart';
import 'package:either_dart/either.dart';
import 'package:nb_utils/nb_utils.dart' hide log;

import '../../../data/datasources/remote/data_sources.dart';

Future<Map<String, dynamic>> get doctors async {
  final DataSourcesImpl sourcesImpl = DataSourcesImpl();

  var docs = await sourcesImpl.get(url: requestDoctorsUrl);
  return jsonDecode(docs.body);
}

Future<Map<String, dynamic>> get departments async {
  final DataSourcesImpl sourcesImpl = DataSourcesImpl();

  var departments = await sourcesImpl.get(url: requestDepartmentsUrl);
  return jsonDecode(departments.body);
}

Future<Either<Map<String, dynamic>, Map<String, dynamic>>> createDoctor(
    body) async {
  return await _create(createDoctorUrl, body);
}

Future<Either<Map<String, dynamic>, Map<String, dynamic>>> _create(
    url, body) async {
  final DataSourcesImpl impl = DataSourcesImpl();
  var res = await impl.post(url: url, body: body);
  if (res.ok) {
    return Left(jsonDecode(res.body));
  } else if (res.vlderr) {
    return Right(jsonDecode(res.body));
  }
  throw (res.body);
}
