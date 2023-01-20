import 'package:afyadaktari_admin/core/presentation/screens/auth/reset_password/state.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../../data/utils/dimens.dart';
import '../../../../data/utils/utils.dart';
import '../../../components/text_field.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ResetPassword> {
  final RoundedLoadingButtonController _buttonController =
      RoundedLoadingButtonController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    _buttonController.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final writer = context.read<ResetPasswordProvider>();
    final watcher = context.watch<ResetPasswordProvider>();

    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: Text(
          'Reset password',
          style: primaryTextStyle(color: blackColor),
        ),
      ),
      body: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Form(
          key: _formkey,
          child: ListView(
            padding: screenpadding,
            children: [
              8.height,
              TextFieldWidget(
                hintText: 'New password',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                obscureText: !watcher.showNewPassword,
                suffixIcon: IconButton(
                    onPressed: () => writer.setNewPassword(),
                    icon: Icon(watcher.showNewPassword
                        ? Icons.visibility
                        : Icons.visibility_off)),
                validator: (p0) =>
                    writer.reqDataErr['errors']['password']?.join(),
                onChanged: (p0) => writer.setNewPass(p0),
              ),
              8.height,
              TextFieldWidget(
                hintText: 'Confirm password',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                obscureText: !watcher.showConfirmPassword,
                suffixIcon: IconButton(
                    onPressed: () => writer.setConfirmPassword(),
                    icon: Icon(watcher.showConfirmPassword
                        ? Icons.visibility
                        : Icons.visibility_off)),
                validator: (p0) =>
                    writer.reqDataErr['errors']['confirm_password']?.join(),
                onChanged: (p0) => writer.setConfirmPass(p0),
              ),
              18.height,
              RoundedLoadingButton(
                  controller: _buttonController,
                  onPressed: () async {
                    await writer.resetPasswordReq;
                    _buttonController.stop();

                    if (writer.apS) {
                      if (mounted) {
                        // finish(context);
                        RestartAppWidget.init(context);
                      }
                      toastS(writer.reqData['message'] ??
                          'Password has successfully been changed');
                    } else {
                      _formkey.currentState!.validate();
                    }
                  },
                  child: Text('Submit', style: primaryTextStyle(color: white)))
            ],
          ),
        ),
      ),
    );
  }
}
