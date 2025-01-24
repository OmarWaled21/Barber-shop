import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.leading,
    this.actions,
    required this.title,
    this.color,
    this.centerTitle = true,
    this.titleSize = 25,
    this.titleColor = Colors.black,
  });

  final Widget? leading;
  final List<Widget>? actions;
  final String title;
  final Color? color;
  final bool centerTitle;
  final double titleSize;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      actions: actions,
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: titleSize,
          color: titleColor,
        ),
      ),
      centerTitle: centerTitle,
      backgroundColor: color,
    );
  }
}
