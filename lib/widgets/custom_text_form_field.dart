import 'package:barber_shop/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.title,
    this.textEditingController,
    this.keyboardType = TextInputType.text,
  });

  final String title;
  final TextEditingController? textEditingController;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Field required';
        }
        if (keyboardType == TextInputType.emailAddress) {
          if (!value.contains('@')) {
            return 'Missing @';
          }
          if (!value.contains('.com')) {
            return 'Missing .com';
          }
        }

        return null;
      },
      controller: textEditingController,
      cursorColor: KColors.darkerYellowColor,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: KColors.darkerYellowColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: KColors.darkerYellowColor),
        ),
        labelText: title,
        labelStyle: const TextStyle(color: KColors.darkerYellowColor),
      ),
    );
  }
}
