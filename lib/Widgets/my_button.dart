import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final VoidCallback ontap;
  final String buttonText;
  final Color? color;

  const MyButton({
    super.key,
    required this.ontap,
    required this.buttonText,
    this.color = Colors.blueAccent,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: ontap,
      child: Text(
        buttonText,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
