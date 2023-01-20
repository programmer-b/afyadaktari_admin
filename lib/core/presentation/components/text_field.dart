import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      {Key? key,
      this.textInputAction,
      this.controller,
      this.validator,
      this.onChanged,
      this.onSaved,
      this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.obscureText = false,
      this.keyboardType,
      this.readOnly = false,
      this.onTap})
      : super(key: key);

  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final bool readOnly;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly,
      keyboardType: keyboardType,
      textInputAction: textInputAction ?? TextInputAction.next,
      obscureText: obscureText,
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      onSaved: onSaved,
      decoration: InputDecoration(
          hintText: hintText, prefixIcon: prefixIcon, suffixIcon: suffixIcon),
    );
  }
}
