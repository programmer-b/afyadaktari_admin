import 'package:afyadaktari_admin/core/presentation/screens/home/doctors/state.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

class DatePickerComponent extends StatelessWidget {
  const DatePickerComponent({super.key});


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Cancel',
                style: boldTextStyle(),
              ).onTap(() {
                context.read<DoctorsProvider>().initDates();
                Navigator.pop(context);
              }),
              Text(
                'Confirm',
                style: boldTextStyle(),
              ).onTap(() {
                context.read<DoctorsProvider>().confirmDate();
                Navigator.pop(context);
              })
            ],
          ).paddingSymmetric(horizontal: 16, vertical: 16),
          Container(
              height: 200,
              padding: const EdgeInsets.all(8),
              child: ScrollDatePicker(
                maximumDate: DateTime(3000),
                minimumDate: DateTime(1000),
                options: const DatePickerOptions(),
                selectedDate:
                    context.read<DoctorsProvider>().selectedDate,
                locale: const Locale('en'),
                onDateTimeChanged: (DateTime value) {
                  context.read<DoctorsProvider>().setDate(value);
                },
              )),
        ],
      ),
    );
  }
}