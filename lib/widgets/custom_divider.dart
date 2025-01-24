import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 0),
      child: Divider(
        color: Colors.grey,
        thickness: 0.5,
      ),
    );
  }
}
