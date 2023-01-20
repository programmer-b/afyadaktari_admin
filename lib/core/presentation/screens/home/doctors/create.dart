import 'package:afyadaktari_admin/core/data/utils/dart_extensions.dart';
import 'package:afyadaktari_admin/core/data/utils/dimens.dart';
import 'package:afyadaktari_admin/core/data/utils/utils.dart';
import 'package:afyadaktari_admin/core/presentation/components/date_picker.dart';
import 'package:afyadaktari_admin/core/presentation/components/text_field.dart';
import 'package:afyadaktari_admin/core/presentation/screens/home/departments/state.dart';
import 'package:afyadaktari_admin/core/presentation/screens/home/doctors/state.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class CreateDoctor extends StatefulWidget {
  const CreateDoctor({super.key});

  @override
  State<CreateDoctor> createState() => _CreateDoctorState();
}

class _CreateDoctorState extends State<CreateDoctor> {
  final _btnController = RoundedLoadingButtonController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _btnController.stop();
  }

  Future<void> _showBottomSheet(Widget child) async {
    await showModalBottomSheet<void>(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        context: context,
        builder: (context) => child);
  }

  final List<String> genderItems = ['Male', 'Female', 'Custom'];

  Future<void> _pickGender(BuildContext context) async =>
      await _showBottomSheet(SizedBox(
        height: context.height() * 0.4,
        child: Column(
          children: _listTileItems(context, genderItems, type: "gender"),
        ),
      ));

  Future<void> _pickDate() async {
    await _showBottomSheet(const DatePickerComponent());
  }

  List<Widget> _listTileItems(BuildContext context, List values,
          {required String type}) =>
      values
          .map((e) => ListTile(
                title: Text(
                  e,
                  style: boldTextStyle(),
                ),
                onTap: () {
                  switch (type) {
                    case "gender":
                      context.read<DoctorsProvider>().setGender(e);
                      finish(context);
                      break;

                    default:
                      finish(context);
                      null;
                  }
                },
              ))
          .toList();

  Future<List<String>> _fetchDepartments() async {
    final provider = context.read<DepartmentsProvider>();
    await provider.fetchDepartments;

    List<String> result = [];

    for (int i = 0; i < provider.departs['data']['count']; i++) {
      result.add(provider.departs['data']['dataModels'][i]['name']);
    }

    return result;
  }

  Future<void> _pickSpecialty(BuildContext context) async {
    final provider = context.read<DoctorsProvider>();

    await _showBottomSheet(Container(
      padding: screenpadding,
      height: context.height() * 0.4,
      child: FutureBuilder<List<String>>(
          future: _fetchDepartments(),
          builder: (context, AsyncSnapshot<List<String>> snap) {
            if (snap.ready) {
              final List<String> data = snap.data ?? [];

              return data.isEmpty
                  ? Center(
                      child: Text(
                        'Specialty record is empty.',
                        style: boldTextStyle(size: 21, color: Colors.black54),
                      ),
                    )
                  : Column(
                      children: [
                        Text(
                          'Please select doctor specialty :',
                          style: boldTextStyle(color: blackColor),
                        ),
                        12.height,
                        for (int i = 0; i < data.length; i++)
                          ListTile(
                            tileColor: Colors.grey[200],
                            title: Text(data[i]),
                            onTap: () {
                              provider.setSpecialty(data[i]);
                              finish(context);
                            },
                          ).paddingSymmetric(vertical: 8)
                      ],
                    );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final writer = Provider.of<DoctorsProvider>(context, listen: false);
    final watcher = context.watch<DoctorsProvider>();

    final speciality = TextEditingController(text: watcher.specialty);
    final dateofBirth = TextEditingController(text: watcher.dateOfBirth);
    final gender = TextEditingController(text: watcher.gender);

    return Scaffold(
      appBar: AppBar(
          elevation: 1.0,
          title: Text(
            'Create a Doctor',
            style: primaryTextStyle(color: blackColor),
          )),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: screenpadding,
          children: [
            TextFieldWidget(
              hintText: 'Id number',
              textInputAction: TextInputAction.next,
              onChanged: (p0) => writer.setIdNo(p0),
              keyboardType: TextInputType.number,
              validator: (p0) =>
                  writer.reqDataErr['errors']['id_number']?.join(),
            ),
            8.height,
            TextFieldWidget(
              hintText: 'First name',
              textInputAction: TextInputAction.next,
              onChanged: (p0) => writer.setFirstName(p0),
              validator: (p0) =>
                  writer.reqDataErr['errors']['first_name']?.join(),
            ),
            8.height,
            TextFieldWidget(
              hintText: 'Middle name',
              textInputAction: TextInputAction.next,
              validator: (p0) =>
                  writer.reqDataErr['errors']['middle_name']?.join(),
              onChanged: (p0) => writer.setMiddleName(p0),
            ),
            8.height,
            TextFieldWidget(
              hintText: 'Last name',
              textInputAction: TextInputAction.next,
              validator: (p0) =>
                  writer.reqDataErr['errors']['last_name']?.join(),
              onChanged: (p0) => writer.setLastName(p0),
            ),
            8.height,
            TextFieldWidget(
              hintText: 'Email',
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              validator: (p0) => writer.reqDataErr['errors']['email']?.join(),
              onChanged: (p0) => writer.setEmail(p0),
            ),
            8.height,
            TextFieldWidget(
              hintText: 'Phone number',
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              validator: (p0) =>
                  writer.reqDataErr['errors']['phone_number']?.join(),
              onChanged: (p0) => writer.setPhoneNumber(p0),
            ),
            8.height,
            TextFieldWidget(
              hintText: 'Gender',
              textInputAction: TextInputAction.next,
              validator: (p0) => writer.reqDataErr['errors']['gender']?.join(),
              onTap: () => _pickGender(context),
              readOnly: true,
              controller: gender,
            ),
            8.height,
            TextFieldWidget(
              hintText: 'Speciality',
              textInputAction: TextInputAction.next,
              validator: (p0) =>
                  writer.reqDataErr['errors']['speciality']?.join(),
              onTap: () => _pickSpecialty(context),
              readOnly: true,
              controller: speciality,
            ),
            8.height,
            TextFieldWidget(
              hintText: 'Date of birth',
              textInputAction: TextInputAction.next,
              validator: (p0) =>
                  writer.reqDataErr['errors']['date_of_birth']?.join(),
              readOnly: true,
              onTap: () => _pickDate(),
              controller: dateofBirth,
            ),
            8.height,
            TextFieldWidget(
              hintText: 'Address',
              textInputAction: TextInputAction.done,
              validator: (p0) => writer.reqDataErr['errors']['address']?.join(),
              onChanged: (p0) => writer.setAddress(p0),
            ),
            18.height,
            RoundedLoadingButton(
                controller: _btnController,
                onPressed: () async {
                  await writer.writeDoctor();
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
        ),
      ),
    );
  }
}
