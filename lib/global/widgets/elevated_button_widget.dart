import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final String buttonName;
  final VoidCallback onPressed;
  const ElevatedButtonWidget(
      {super.key, required this.buttonName, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 20)),
        onPressed: onPressed,
        child: Text(buttonName));
  }
}
