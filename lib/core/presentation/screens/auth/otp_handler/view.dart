import 'package:afyadaktari_admin/core/data/utils/dart_extensions.dart';
import 'package:afyadaktari_admin/core/data/utils/dimens.dart';
import 'package:afyadaktari_admin/core/data/utils/utils.dart';
import 'package:afyadaktari_admin/core/presentation/screens/auth/otp_handler/state.dart';
import 'package:afyadaktari_admin/core/presentation/screens/auth/reset_password/view.dart';
import 'package:afyadaktari_admin/core/presentation/screens/auth/verify_phone/state.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OTPHandlerView extends StatefulWidget {
  const OTPHandlerView({super.key});

  @override
  State<OTPHandlerView> createState() => _OTPHandlerViewState();
}

class _OTPHandlerViewState extends State<OTPHandlerView> {
  final _controller = OtpTimerButtonController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // _controller.startTimer();
  }

  _load(context) async => showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text("Loading..."),
              ],
            ),
          );
        },
      );

  _voidSubmitOTP(OTPHandlerProvider writer, BuildContext context) async {
    hideKeyboard(context);
    _load(context);
    await writer
        .verifyNumber(context.read<VerifyPhoneProvider>().userId)
        .then((value) => finish(context));
    if (writer.success) {
      toastS(writer.data['message'] ?? 'OTP validated successfully');
      if (mounted) {
        // RestartAppWidget.init(context);
        const ResetPassword().launch(context);
      }
    }
    if (writer.error) {
      _formKey.currentState!.validate();
    }
  }

  @override
  Widget build(BuildContext context) {
    final verifyPhoneProvider = context.read<VerifyPhoneProvider>();
    final writer = context.read<OTPHandlerProvider>();

    return ChangeNotifierProvider(
      create: (context) => OTPHandlerProvider(),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              color: Colors.black54,
              onPressed: () => finish(context),
            ),
          ),
          body: Container(
            padding: screenpadding,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Divider(),
                  8.height,
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Verify your mobile number.',
                      style: boldTextStyle(size: 24),
                    ),
                  ),
                  8.height,
                  Container(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: 'Enter the PIN we sent to: ',
                          style: primaryTextStyle()),
                      TextSpan(
                          text: verifyPhoneProvider.phone.hide,
                          style: primaryTextStyle(color: Colors.blue))
                    ])),
                  ),
                  8.height,
                  Padding(
                    padding: screenpadding,
                    child: Pinput(
                      validator: (value) =>
                          writer.dataErr['errors']?['OTP']?.join(),
                      onChanged: (p0) => writer.setOTP(p0),
                      onCompleted: (value) => _voidSubmitOTP(writer, context),
                      onSubmitted: (value) => _voidSubmitOTP(writer, context),
                      length: 6,
                    ),
                  ),
                  18.height,
                  Builder(builder: (context) {
                    return OtpTimerButton(
                        controller: _controller,
                        onPressed: () async {
                          ///Resend one time pin
                          _load(context);
                          await verifyPhoneProvider.resetPassword
                              .then((value) => finish(context));
                          _controller.startTimer();
                        },
                        text: const Text('Resend PIN'),
                        duration: 5);
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
