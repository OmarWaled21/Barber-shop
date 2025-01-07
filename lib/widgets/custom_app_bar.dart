import 'package:barber_shop/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.leading,
    this.actions,
    required this.title,
    this.color = KColors.mainColor,
  });

  final Widget? leading;
  final List<Widget>? actions;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      actions: actions,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      centerTitle: true,
      backgroundColor: KColors.mainColor,
    );
  }
}
