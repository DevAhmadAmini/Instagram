import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String errorText;
  const ErrorDialog({super.key, required this.errorText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Cancel',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ],
      title: Center(
        child: Container(
          alignment: Alignment.topLeft,
          child: Text(
            errorText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
