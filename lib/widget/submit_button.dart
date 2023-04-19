import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  const SubmitButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed!();
      },
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          letterSpacing: 2,
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        primary: const Color.fromARGB(225, 0, 74, 173),
      ),
    );
  }
}
