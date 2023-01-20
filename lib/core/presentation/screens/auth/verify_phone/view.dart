import 'package:afyadaktari_admin/core/data/utils/dimens.dart';
import 'package:afyadaktari_admin/core/data/utils/utils.dart';
import 'package:afyadaktari_admin/core/domain/repository/auth/request/mobile_request.dart';
import 'package:afyadaktari_admin/core/presentation/components/text_field.dart';
import 'package:afyadaktari_admin/core/presentation/screens/auth/otp_handler/view.dart';
import 'package:afyadaktari_admin/core/presentation/screens/auth/verify_phone/state.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class VerifyPhoneView extends StatefulWidget {
  const VerifyPhoneView({super.key});

  @override
  State<VerifyPhoneView> createState() => _VerifyPhoneViewState();
}

class _VerifyPhoneViewState extends State<VerifyPhoneView> {
  final mobile = TextEditingController();

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _btnController.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final writer = context.read<VerifyPhoneProvider>();
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => finish(context),
          color: Colors.black54,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const Divider(),
            Expanded(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                padding: screenpadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Forgot your password?',
                      style: boldTextStyle(color: black, size: 24),
                    ),
                    8.height,
                    Text(
                      'Enter your mobile number below to verify its you.',
                      style: primaryTextStyle(),
                    ),
                    12.height,
                    TextFieldWidget(
                      keyboardType: TextInputType.phone,
                      controller: mobile,
                      onChanged: (p0) => writer.settPhone(p0),
                      textInputAction: TextInputAction.done,
                      prefixIcon: const Icon(Icons.phone),
                      validator: (p0) =>
                          writer.dataErr['errors']['mobile']?.join(),
                    ),
                    22.height,
                    RoundedLoadingButton(
                        controller: _btnController,
                        onPressed: () async {
                          //send mobile and receive pin
                          await writer.resetPassword;
                          if (writer.success) {
                            toastS(writer.data['message'] ??
                                "OTP sent successfully");
                            if (mounted) {
                              const OTPHandlerView().launch(context);
                            }
                          }
                          if (writer.error) {
                            toastE(writer.dataErr['message'] ??
                                'Something went wrong. Please try again later');
                            _formKey.currentState!.validate();
                          }
                          _btnController.stop();
                        },
                        child: Text(
                          'Submit',
                          style: primaryTextStyle(color: white),
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
