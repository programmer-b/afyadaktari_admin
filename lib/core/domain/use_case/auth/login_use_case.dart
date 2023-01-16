import 'dart:developer';

import 'package:afyadaktari_admin/core/data/datasources/remote/data_sources.dart';
import 'package:afyadaktari_admin/core/data/utils/dart_extensions.dart';
import 'package:afyadaktari_admin/core/data/utils/strings/keys.dart';
import 'package:afyadaktari_admin/core/domain/repository/auth/response/failure/login_failure.dart';
import 'package:afyadaktari_admin/core/domain/repository/auth/response/success/login_success.dart';
import 'package:either_dart/either.dart';
import 'package:http/http.dart';

import '../../../data/utils/strings/uris.dart';
import '../../../data/utils/utils.dart';

Future<Either<LoginSuccess, LoginFailure>> doLogin(username, password) async {
  final DataSourcesImpl sourcesImpl = DataSourcesImpl();

  var body = {keyUsername: username, keyPassword: password};

  log('$body');

  final Response response = await sourcesImpl.post(url: loginUri, body: body);
  try {
    if (response.ok) {
      return Left(LoginSuccess.fromJson(response.decode));
    } else if (response.vlderr) {
      return Right(LoginFailure.fromJson(response.decode));
    } else {
      toastE('SERVER ERROR!');
      throw (response.body);
    }
  } catch (e) {
    rethrow;
  }
}
