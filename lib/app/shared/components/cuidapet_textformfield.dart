import 'package:flutter/material.dart';

class CuidapetTextFormField extends TextFormField {
  CuidapetTextFormField({
    TextEditingController? controller,
    TextInputType? keyboardType,
    required String label,
    FormFieldValidator<String>? validator,
    bool? obscureText = false,
    IconButton? suffixIcon,
  }) : super(
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              fontSize: 15,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              gapPadding: 0,
            ),
            suffixIcon: suffixIcon,
          ),
          obscureText: obscureText!,
          validator: validator,
        );
}
