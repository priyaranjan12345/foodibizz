import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final TextInputType? keyboardKey;
  final FocusNode? focusNode;
  final Function(String? value)? onChanged;
  final Function(String? value)? onFieldSubmitted;
  const TextFieldWidget(
      {Key? key,
      this.label,
      this.hint,
      this.controller,
      this.keyboardKey,
      this.focusNode,
      this.onChanged,
      this.onFieldSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardKey,
      focusNode: focusNode,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 10),
        labelText: label,
        labelStyle: const TextStyle(fontSize: 12),
        fillColor: Colors.transparent,
        disabledBorder: const OutlineInputBorder(),
        errorBorder: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(),
      ),
    );
  }
}
