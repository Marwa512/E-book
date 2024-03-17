import 'package:flutter/material.dart';

import '../../features/authentication/presentation/manger/auth_cubit.dart';

class CustomFormTextField extends StatelessWidget {
  const CustomFormTextField(
      {super.key,
      this.hintText,
      this.onChanged,
      this.obscureText = false,
      required this.inputType,
      required this.controller,
      required this.validator,
      this.labelText,
      this.icon,
      this.color,
      this.iconFunction,
      this.enabled = true});

  final void Function(String?)? onChanged;
  final String? hintText;
  final TextEditingController controller;
  final bool? obscureText;
  final bool enabled;
  final Color? color;
  final TextInputType inputType;
  final String? Function(String?)? validator;
  final IconData? icon;
  final String? labelText;
  final void Function(String?)? iconFunction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: obscureText!,
      keyboardType: inputType,
      autofocus: false,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.withOpacity(.1),
        labelText: labelText,
        labelStyle: const TextStyle(fontSize: 20, color: Colors.black),
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 20),
        enabled: enabled,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16)
        ),
        suffixIcon: IconButton(
          icon: Icon(icon),
          onPressed: () {
            iconFunction;
            EbookAuthCubit.get(context).changePasswordVisibility();
          },
        ),
      ),
    );
  }
}
