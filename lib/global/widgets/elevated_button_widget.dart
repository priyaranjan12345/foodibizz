import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final String buttonName;
  final VoidCallback onPressed;
  const ElevatedButtonWidget(
      {super.key, required this.buttonName, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(elevation: 4.0),
        onPressed: onPressed,
        child: Text(buttonName));
  }
}
