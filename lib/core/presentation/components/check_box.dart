import 'package:flutter/material.dart';

class CheckBoxWidget extends StatelessWidget {
  const CheckBoxWidget({Key? key, required this.value, this.onChanged})
      : super(key: key);
  final bool value;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ClipOval(
            child: Checkbox(
      value: value,
      onChanged: onChanged,
      activeColor: Colors.blue,
      checkColor: Colors.white,
      tristate: false,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusNode: FocusNode(),
      autofocus: false,
    )));
  }
}
