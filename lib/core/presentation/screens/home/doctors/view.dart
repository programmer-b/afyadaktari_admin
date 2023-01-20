import 'dart:convert';

import 'package:afyadaktari_admin/core/data/datasources/remote/data_sources.dart';
import 'package:afyadaktari_admin/core/data/utils/dart_extensions.dart';
import 'package:afyadaktari_admin/core/data/utils/dimens.dart';
import 'package:afyadaktari_admin/core/data/utils/strings/uris.dart';
import 'package:afyadaktari_admin/core/data/utils/utils.dart';
import 'package:afyadaktari_admin/core/presentation/components/doctor_menu.dart';
import 'package:afyadaktari_admin/core/presentation/screens/home/doctors/create.dart';
import 'package:afyadaktari_admin/core/presentation/screens/home/doctors/doctor_details.dart';
import 'package:afyadaktari_admin/core/presentation/screens/home/doctors/state.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class DoctorsView extends StatefulWidget {
  const DoctorsView({super.key});

  @override
  State<DoctorsView> createState() => _DoctorsViewState();
}

class _DoctorsViewState extends State<DoctorsView> with NavigatorObserver {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _refreshIndicatorKey.currentState!.show();
    });
  }

  Future<void> _deleteDoctor(int id) async {
    final impl = DataSourcesImpl();
    final res = await impl.delete(url: '$deleteDoctorUrl$id');
    if (res.ok) {
      toastS(jsonDecode(res.body)['message'] ?? 'Deleted successfully');
      _refreshIndicatorKey.currentState!.show();
    } else {
      toastE('Something went wrong. Try again later');
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<DoctorsProvider>();
    final providerWatch = context.watch<DoctorsProvider>();

    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
        title: Text(
          'Doctors List',
          style: primaryTextStyle(color: blackColor),
        ),
      ),
      body: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () async =>
              await context.read<DoctorsProvider>().fetchDoctors,
          child: ListView(
            padding: screenpadding,
            children: [
              if (providerWatch.doctorsCount == 0)
                Center(
                  child: Text(
                    'No Doctors on record.',
                    style: boldTextStyle(color: Colors.black45, size: 21),
                  ),
                ),
              if (!providerWatch.doctorsEmpty)
                Column(
                  children: [
                    for (int i = 0; i < provider.docs['data']['count']; i++)
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          title: Text(provider.doctorsList?.fullName(i) ?? ''),
                          subtitle: Text(
                              '${provider.doctorsList?.speciality(i) ?? ''}-${provider.doctorsList?.staffNo(i) ?? ''}'),
                          trailing: Doctormenu(
                            onSelected: (DocMenu value) {
                              switch (value) {
                                case DocMenu.view:
                                  DoctorDetails(id: i).launch(context,
                                      pageRouteAnimation:
                                          PageRouteAnimation.Slide);
                                  break;
                                case DocMenu.addSchedule:
                                  break;
                                case DocMenu.delete:
                                  _deleteDoctor(provider.doctorsList?.data
                                          ?.dataModels?[i].id ??
                                      -1);
                                  break;
                              }
                            },
                          ),
                          tileColor: Colors.grey[200],
                        ),
                      )
                  ],
                )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async => await const CreateDoctor()
              .launch(context,
                  pageRouteAnimation: PageRouteAnimation.SlideBottomTop)
              .then((value) => _refreshIndicatorKey.currentState!.show()),
          icon: const Icon(
            Icons.add,
            color: white,
          ),
          label: Text(
            'Create',
            style: primaryTextStyle(color: white),
          )),
    );
  }
}
