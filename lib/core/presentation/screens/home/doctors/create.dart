import 'package:afyadaktari_admin/core/data/utils/dimens.dart';
import 'package:afyadaktari_admin/core/data/utils/utils.dart';
import 'package:afyadaktari_admin/core/presentation/components/text_field.dart';
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

  @override
  Widget build(BuildContext context) {
    final writer = Provider.of<DoctorsProvider>(context, listen: false);

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
              onChanged: (p0) => writer.setGender(p0),
            ),
            8.height,
            TextFieldWidget(
              hintText: 'Speciality',
              textInputAction: TextInputAction.next,
              validator: (p0) =>
                  writer.reqDataErr['errors']['speciality']?.join(),
              onChanged: (p0) => writer.setSpecialty(p0),
            ),
            8.height,
            TextFieldWidget(
              hintText: 'Date of birth',
              textInputAction: TextInputAction.next,
              validator: (p0) =>
                  writer.reqDataErr['errors']['date_of_birth']?.join(),
              onChanged: (p0) => writer.setDateOfBirth(p0),
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
