import 'package:afyadaktari_admin/core/data/utils/dimens.dart';
import 'package:afyadaktari_admin/core/domain/repository/auth/request/mobile_request.dart';
import 'package:afyadaktari_admin/core/presentation/components/text_field.dart';
import 'package:afyadaktari_admin/core/presentation/screens/auth/otp_handler/view.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class VerifyPhoneView extends StatefulWidget {
  const VerifyPhoneView({super.key});

  @override
  State<VerifyPhoneView> createState() => _VerifyPhoneViewState();
}

class _VerifyPhoneViewState extends State<VerifyPhoneView> {
  final mobile = TextEditingController();
  final MobileRequest _r = MobileRequest();

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  @override
  void dispose() {
    _btnController.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => finish(context),
          color: Colors.black54,
        ),
      ),
      body: Column(
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
                    onChanged: (p0) => _r.mobile = p0,
                    textInputAction: TextInputAction.done,
                    prefixIcon: const Icon(Icons.phone),
                  ),
                  22.height,
                  RoundedLoadingButton(
                      controller: _btnController,
                      onPressed: () {
                        //send mobile and receive pin
                        const OTPHandlerView().launch(context);
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
    );
  }
}
