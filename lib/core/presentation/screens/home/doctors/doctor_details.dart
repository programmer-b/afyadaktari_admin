import 'dart:developer';

import 'package:afyadaktari_admin/core/data/utils/dart_extensions.dart';
import 'package:afyadaktari_admin/core/presentation/components/doctor_data_cohot.dart';
import 'package:afyadaktari_admin/core/presentation/screens/home/doctors/state.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class DoctorDetails extends StatefulWidget {
  const DoctorDetails({super.key, required this.id});
  final int id;

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  int get id => widget.id;
  @override
  Widget build(BuildContext context) {
    final provider = context.read<DoctorsProvider>();
    final Map<String,dynamic> data = provider.docs['data']['dataModels'][id].cast<String,dynamic>();
    log("${data.length}");

    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Doctor details', style: primaryTextStyle(color: blackColor),),
          elevation: 1.0,
        ),
        body: ListView(
          children: [
            for (int i = 0; i < data.length; i++)
              DoctorDataCohot(keyS: data.keyAt(i), value: data.valueAt(i)),
          ],
        ),
      ),
    );
  }
}
