import 'package:afyadaktari_admin/core/presentation/screens/home/settings/state.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../../data/utils/dimens.dart';
import '../../../../data/utils/utils.dart';
import '../../../components/text_field.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
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
    final writer = context.read<SettingsProvider>();
    final watcher = context.watch<SettingsProvider>();

    log('SHOW OLD PASSWORD: ${watcher.showOldPassword}');
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: Text(
          'Change Password',
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
                hintText: 'Current password',
                textInputAction: TextInputAction.next,
                onChanged: (p0) => writer.setOldPassword(p0),
                keyboardType: TextInputType.text,
                obscureText: !watcher.showOldPassword,
                suffixIcon: IconButton(
                    onPressed: () => writer.setShowOldPassword(),
                    icon: Icon(watcher.oldPasswordIcon)),
                validator: (p0) =>
                    writer.reqDataErr['errors']['current_password']?.join(),
              ),
              8.height,
              TextFieldWidget(
                hintText: 'New password',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                obscureText: !watcher.showNewPassword,
                suffixIcon: IconButton(
                    onPressed: () => writer.setShowNewPassword(),
                    icon: Icon(watcher.newPasswordIcon)),
                validator: (p0) =>
                    writer.reqDataErr['errors']['new_password']?.join(),
                onChanged: (p0) => writer.setNewPassword(p0),
              ),
              8.height,
              TextFieldWidget(
                hintText: 'Confirm password',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                obscureText: !watcher.showConfirmPassword,
                suffixIcon: IconButton(
                    onPressed: () => writer.setShowConfirmPassword(),
                    icon: Icon(watcher.confirmPasswordIcon)),
                validator: (p0) =>
                    writer.reqDataErr['errors']['confirm_password']?.join(),
                onChanged: (p0) => writer.setConfirmPassword(p0),
              ),
              18.height,
              RoundedLoadingButton(
                  controller: _buttonController,
                  onPressed: () async {
                    await writer.changePassword;
                    _buttonController.stop();

                    if (writer.apS) {
                      if (mounted) {
                        finish(context);
                      }
                      toastE(writer.reqData['message'] ??
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
