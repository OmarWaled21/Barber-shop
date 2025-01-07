import 'package:barber_shop/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.title,
    this.textEditingController,
  });

  final String title;
  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null) {
          return 'Field required';
        }
        return null;
      },
      controller: textEditingController,
      cursorColor: KColors.darkerYellowColor,
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
