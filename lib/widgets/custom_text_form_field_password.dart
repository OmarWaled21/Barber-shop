import 'package:barber_shop/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormFieldPassword extends StatefulWidget {
  const CustomTextFormFieldPassword({
    super.key,
    required this.title,
    this.textEditingController,
  });

  final String title;
  final TextEditingController? textEditingController;

  @override
  State<CustomTextFormFieldPassword> createState() =>
      _CustomTextFormFieldPasswordState();
}

class _CustomTextFormFieldPasswordState
    extends State<CustomTextFormFieldPassword> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null) {
          return 'Field required';
        }
        return null;
      },
      controller: widget.textEditingController,
      obscureText: isObscure,
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
        labelText: widget.title,
        labelStyle: const TextStyle(color: KColors.darkerYellowColor),
        suffix: InkWell(
          onTap: () {
            setState(() => isObscure = !isObscure);
          },
          child: Icon(
            isObscure ? Icons.visibility_off_rounded : Icons.visibility,
          ),
        ),
      ),
    );
  }
}
