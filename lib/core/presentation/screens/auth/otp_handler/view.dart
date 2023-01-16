import 'package:afyadaktari_admin/core/data/utils/dimens.dart';
import 'package:afyadaktari_admin/core/domain/repository/auth/request/otp_request.dart';
import 'package:afyadaktari_admin/core/presentation/screens/auth/otp_handler/state.dart';
import 'package:afyadaktari_admin/core/presentation/screens/auth/verify_phone/state.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OTPHandlerView extends StatefulWidget {
  const OTPHandlerView({super.key});

  @override
  State<OTPHandlerView> createState() => _OTPHandlerViewState();
}

class _OTPHandlerViewState extends State<OTPHandlerView> {
  final _controller = OtpTimerButtonController();
  final OTPRequest _r = OTPRequest();

  @override
  void initState() {
    super.initState();

    // _controller.startTimer();
  }

  @override
  Widget build(BuildContext context) {
    var phone = context.read<VerifyPhoneProvider>().phone;

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
                        text: phone, style: primaryTextStyle(color: Colors.blue))
                  ])),
                ),
                8.height,
                Padding(
                  padding: screenpadding,
                  child: PinFieldAutoFill(
                    onCodeChanged: (p0) => _r.otp = p0,
                    decoration: BoxLooseDecoration(
                      strokeColorBuilder:
                          FixedColorBuilder(Colors.black.withOpacity(0.3)),
                    ),
                  ),
                ),
                18.height,
                OtpTimerButton(
                    controller: _controller,
                    onPressed: () {
                      ///Resend one time pin
                      _controller.startTimer();
                    },
                    text: const Text('Resend PIN'),
                    duration: 5)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
