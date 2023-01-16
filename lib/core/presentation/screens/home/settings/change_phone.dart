import 'package:afyadaktari_admin/core/data/utils/dimens.dart';
import 'package:afyadaktari_admin/core/presentation/screens/home/settings/state.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../../data/utils/utils.dart';
import '../../../components/text_field.dart';

class ChangePhone extends StatefulWidget {
  const ChangePhone({super.key});

  @override
  State<ChangePhone> createState() => _ChangePhoneState();
}

class _ChangePhoneState extends State<ChangePhone> {
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
    final writer = Provider.of<SettingsProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: Text(
          'Change Phone',
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
                hintText: 'Current mobile',
                textInputAction: TextInputAction.next,
                onChanged: (p0) => writer.setOldPhone(p0),
                keyboardType: TextInputType.number,
                validator: (p0) =>
                    writer.reqDataErr['errors']['current_mobile']?.join(),
              ),
              8.height,
              TextFieldWidget(
                hintText: 'New phone',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                validator: (p0) =>
                    writer.reqDataErr['errors']['new_mobile']?.join(),
                onChanged: (p0) => writer.setNewPhone(p0),
              ),
              8.height,
              TextFieldWidget(
                hintText: 'Confirm phone',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                validator: (p0) =>
                    writer.reqDataErr['errors']['confirm_mobile']?.join(),
                onChanged: (p0) => writer.setConfirmPhone(p0),
              ),
              18.height,
              RoundedLoadingButton(
                  controller: _buttonController,
                  onPressed: () async {
                    await writer.changePhone;
                    _buttonController.stop();

                    if (writer.apS) {
                      if (mounted) {
                        finish(context);
                      }
                      toastE(writer.reqData['message'] ??
                          'Mobile has successfully been changed');
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
