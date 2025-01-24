import 'package:flutter/material.dart';

class RowConfirmSection extends StatelessWidget {
  const RowConfirmSection(
      {super.key, required this.title, required this.value, this.subValue});

  final String title;
  final String value;
  final String? subValue;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Text(
        '$title:',
        style: TextStyle(fontSize: 20, color: Colors.yellow.shade900),
      ),
      title: Text(
        value,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      subtitle: (subValue != null || subValue == '')
          ? Text(
              subValue!,
              style: const TextStyle(fontSize: 18),
            )
          : null,
    );
  }
}
