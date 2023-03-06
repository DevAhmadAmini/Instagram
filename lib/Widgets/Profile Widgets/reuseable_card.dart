import 'package:flutter/material.dart';

class ReuseableCard extends StatelessWidget {
  final String text;
  final int? num;
  const ReuseableCard({super.key, required this.text, required this.num});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ),
          Text(
            num.toString(),
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
