import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    Key? key,
    this.onTap,
    this.validator,
    this.controller,
    this.initialValue,
    this.maxLines,
    this.keyboardType,
    this.textInputAction,
    this.readOnly = false,
    this.onFieldSubmitted,
    this.onEditingComplete,
    required this.hintText,
    this.obscureText = false,
  }) : super(key: key);

  final int? maxLines;
  final bool? readOnly;
  final String hintText;
  final bool? obscureText;
  final String? initialValue;
  final void Function()? onTap;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function()? onEditingComplete;
  final void Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly!,
      onFieldSubmitted: onFieldSubmitted,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onEditingComplete: onEditingComplete,
      validator: validator ??
              (val) {
            if (val != null && val.isNotEmpty) return null;
            return 'Field is require';
          },
      controller: controller,
      obscureText: obscureText!,
      cursorColor: Colors.black,
      maxLines: maxLines,
      initialValue: initialValue,
      decoration: InputDecoration(
        hintText: hintText,
        label: Text(hintText,style: TextStyle(color: Colors.grey),),
        contentPadding: const EdgeInsets.all(10),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black, width: .5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey, width: .5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black87, width: .5),
        ),
      ),
    );
  }
}
