import 'package:afyadaktari_admin/core/data/utils/dimens.dart';
import 'package:afyadaktari_admin/core/presentation/screens/home/departments/state.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../../data/utils/utils.dart';
import '../../../components/text_field.dart';

class CreateDepartment extends StatefulWidget {
  const CreateDepartment({super.key});

  @override
  State<CreateDepartment> createState() => _CreateDepartmentState();
}

class _CreateDepartmentState extends State<CreateDepartment> {
  final _btnController = RoundedLoadingButtonController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _btnController.stop();
  }

  @override
  Widget build(BuildContext context) {
    final watcher = context.watch<DepartmentsProvider>();
    final writer = context.read<DepartmentsProvider>();

    return Scaffold(
      appBar: AppBar(
          elevation: 1.0,
          title: Text(
            'Create a Speciality',
            style: primaryTextStyle(color: blackColor),
          )),
      body: Form(
          key: _formKey,
          child: ListView(
            padding: screenpadding,
            children: [
              TextFieldWidget(
                hintText: 'Name',
                textInputAction: TextInputAction.done,
                onChanged: (p0) => writer.setName(p0),
                keyboardType: TextInputType.text,
                validator: (p0) => writer.reqDataErr['errors']['name']?.join(),
              ),
              18.height,
              RoundedLoadingButton(
                  controller: _btnController,
                  onPressed: () async {
                    await writer.writeDepartment();
                    if (writer.apS) {
                      toastS(writer.reqData['message']);
                      if (mounted) {
                        finish(context);
                      }
                    } else {
                      _formKey.currentState!.validate();
                    }
                    _btnController.stop();
                  },
                  child: Text('Submit', style: primaryTextStyle(color: white)))
            ],
          )),
    );
  }
}
