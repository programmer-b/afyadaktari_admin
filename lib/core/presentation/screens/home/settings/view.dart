import 'package:afyadaktari_admin/core/data/utils/dimens.dart';
import 'package:afyadaktari_admin/core/presentation/screens/home/settings/change_password.dart';
import 'package:afyadaktari_admin/core/presentation/screens/home/settings/change_phone.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../data/utils/strings/common.dart';
import '../../../components/application_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: Text(
          'Profile',
          style: primaryTextStyle(color: blackColor),
        ),
      ),
      body: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        child: ListView(
          padding: screenpadding,
          children: [
            8.height,
            ApplicationButton(
              text: changePhoneText,
              onTap: () => const ChangePhone().launch(context),
            ),
            12.height,
            ApplicationButton(
              text: changePasswordText,
              onTap: () => const ChangePassword().launch(context),
            )
          ],
        ),
      ),
    );
  }
}
