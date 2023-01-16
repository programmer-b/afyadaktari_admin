import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ApplicationButton extends StatelessWidget {
  const ApplicationButton({super.key, this.onTap, this.text});
  final void Function()? onTap;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width(),
      child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(), backgroundColor: Colors.blue[300]),
          child: Text(
            text ?? '',
            style: primaryTextStyle(color: white),
          )),
    );
  }
}
