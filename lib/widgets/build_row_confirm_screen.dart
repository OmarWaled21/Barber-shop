import 'package:flutter/material.dart';

class BuildRowConfirmScreen extends StatelessWidget {
  const BuildRowConfirmScreen({
    super.key,
    required this.title,
    required this.value,
    this.subValue,
  });

  final String title;
  final String value;
  final String? subValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        if (subValue != null) ...[
          const SizedBox(height: 5),
          Text(
            subValue!,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ],
    );
  }
}
