import 'package:afyadaktari_admin/core/data/utils/dart_extensions.dart';

class OTPRequest {
  String? otp;
  Map<String, String> json() => {'OTP': otp.sntnull};
}
