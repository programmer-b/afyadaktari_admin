import 'package:afyadaktari_admin/core/data/utils/dimens.dart';
import 'package:afyadaktari_admin/core/data/utils/strings/common.dart';
import 'package:afyadaktari_admin/core/presentation/components/application_button.dart';
import 'package:afyadaktari_admin/core/presentation/screens/home/dash_board/dash_board_provider.dart';
import 'package:afyadaktari_admin/core/presentation/screens/home/doctors/view.dart';
import 'package:afyadaktari_admin/core/presentation/screens/home/settings/view.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../departments/view.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<DashBoardProvider>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Admin DashBoard',
          style: primaryTextStyle(color: blackColor),
        ),
        elevation: 1.0,
        actions: [
          IconButton(
              onPressed: () => const SettingsPage().launch(context),
              icon: const Icon(Icons.settings)),
          IconButton(
              onPressed: () => RestartAppWidget.init(context),
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        child: ListView(padding: screenpadding, children: [
          8.height,
          ApplicationButton(
            text: doctorText,
            onTap: () => const DoctorsView().launch(context),
          ),
          12.height,
          ApplicationButton(
            text: departsmentsText,
            onTap: () => const DepartmentsView().launch(context),
          ),
        ]),
      ),
    );
  }
}
