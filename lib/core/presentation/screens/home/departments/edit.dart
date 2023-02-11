import 'package:afyadaktari_admin/core/presentation/screens/home/departments/state.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class EditSpeciality extends StatefulWidget {
  const EditSpeciality({super.key, required this.id, required this.name});
  final int id;
  final String name;

  @override
  State<EditSpeciality> createState() => _EditSpecialityState();
}

class _EditSpecialityState extends State<EditSpeciality> {
  int get id => widget.id;
  String get name => widget.name;

  final _btnController = RoundedLoadingButtonController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _btnController.stop();
  }

  @override
  void initState() {
    super.initState();
    context.read<DepartmentsProvider>().setDepartname(name);
  }

  @override
  Widget build(BuildContext context) {
    final reader = context.read<DepartmentsProvider>();
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: Text(
          'Edit Speciality',
          style: primaryTextStyle(color: blackColor),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            16.height,
            TextFormField(
              initialValue: name,
              decoration: const InputDecoration(hintText: 'Speciality'),
              onChanged: (p0) => reader.setDepartname(p0),
            ),
            18.height,
            RoundedLoadingButton(
                controller: _btnController,
                onPressed: () async {
                  await reader.updateDepart(id);
                  if (reader.departUpdateSuccess) {
                    if (mounted) {
                      finish(context);
                    }
                  } else {
                    _formKey.currentState!.validate();
                  }
                },
                child: Text('Submit', style: primaryTextStyle(color: white)))
          ],
        ),
      ),
    ));
  }
}
