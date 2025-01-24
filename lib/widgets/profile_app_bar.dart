import 'package:barber_shop/constants/colors.dart';
import 'package:barber_shop/helper/navigator_extention.dart';
import 'package:barber_shop/views/home_view.dart';
import 'package:barber_shop/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({
    super.key,
    required this.onSave,
  });

  final Future<void> Function() onSave;

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: 'Edit Profile',
      centerTitle: true,
      color: KColors.mainColor,
      leading: IconButton(
        onPressed: () => context.pushAndRemoveUntil(const HomeView()),
        icon: const Icon(Icons.arrow_back_ios),
      ),
      actions: [
        MaterialButton(
          onPressed: onSave,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(color: KColors.darkerYellowColor, width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text('Save'),
          ),
        ),
      ],
    );
  }
}
