import 'package:flutter/material.dart';

class ReuseableButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  const ReuseableButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 65),
      child: Container(
        height: 32,
        width: 220,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: TextButton(
          onPressed: onPressed,
          child: Center(
            child: Text(
              buttonText,
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
        ),
      ),
    );
  }
}
