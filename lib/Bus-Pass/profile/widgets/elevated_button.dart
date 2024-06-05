import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const CustomElevatedButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(8.0),
        fixedSize: const Size(400, 50),
        textStyle: const TextStyle(
          fontSize: 18,
        ),
        backgroundColor: const Color.fromRGBO(39, 66, 129, 1),
        foregroundColor: Colors.white,
        elevation: 10,
        alignment: Alignment.centerLeft,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      icon: Icon(icon),
      label: Text(label),
      onPressed: onPressed,
    );
  }
}
