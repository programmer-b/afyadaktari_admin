import 'dart:convert';

import 'package:afyadaktari_admin/core/data/utils/dart_extensions.dart';
import 'package:afyadaktari_admin/core/presentation/screens/home/departments/state.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../../../data/datasources/remote/data_sources.dart';
import '../../../../data/utils/dimens.dart';
import '../../../../data/utils/strings/uris.dart';
import '../../../../data/utils/utils.dart';

class DepartmentsView extends StatefulWidget {
  const DepartmentsView({super.key});

  @override
  State<DepartmentsView> createState() => _DepartmentsViewState();
}

class _DepartmentsViewState extends State<DepartmentsView> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _refreshIndicatorKey.currentState!.show();
    });
  }

  Future<void> _deleteDepartment(int id) async {
    final impl = DataSourcesImpl();
    final res = await impl.delete(url: '$deleteDepartmentUrl$id');
    if (res.ok) {
      toastS(jsonDecode(res.body)['message'] ?? 'Deleted successfully');
      _refreshIndicatorKey.currentState!.show();
    } else {
      toastE('Something went wrong. Try again later');
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<DepartmentsProvider>();
    final providerWatch = context.watch<DepartmentsProvider>();

    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Scaffold(
        appBar: AppBar(
          elevation: 1.0,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          ],
          title: Text(
            'Departments List',
            style: primaryTextStyle(color: blackColor),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () => provider.fetchDepartments,
          key: _refreshIndicatorKey,
          child: ListView(
            padding: screenpadding,
            children: [
              if (providerWatch.departmentsCount == 0)
                Center(
                  child: Text(
                    'No departments on record.',
                    style: boldTextStyle(color: Colors.black45, size: 21),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}