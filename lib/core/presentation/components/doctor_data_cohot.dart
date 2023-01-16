import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class DoctorDataCohot extends StatelessWidget {
  const DoctorDataCohot({Key? key, required this.keyS, required this.value})
      : super(key: key);
  final String keyS;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black38),
          borderRadius: const BorderRadius.all(Radius.circular(6))),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.black12,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Text(
              keyS,
              style: boldTextStyle(size: 14),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Text(
              value,
              style: const TextStyle(fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}
