import 'package:afyadaktari_admin/core/data/utils/dart_extensions.dart';
import 'package:afyadaktari_admin/core/data/utils/strings/keys.dart';
import 'package:nb_utils/nb_utils.dart';

class LoginRequest {
  String? username = getStringAsync(keyUsername);
  String? password = getStringAsync(keyPassword);
  bool? rememberMe;

  void save() async {
    await setValue(keyUsername, username);
    await setValue(keyPassword, password);
    await setValue(keyRememberMe, rememberMe);
  }

  Map<String, String> toJson() =>
      {keyUsername: username.sntnull, keyPassword: password.sntnull};
}
