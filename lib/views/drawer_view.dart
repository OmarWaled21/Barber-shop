import 'package:barber_shop/constants/colors.dart';
import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:barber_shop/helper/navigator_extention.dart';
import 'package:barber_shop/views/choose_branch_view.dart';
import 'package:barber_shop/views/login_view.dart';
import 'package:barber_shop/views/profile_view.dart';
import 'package:barber_shop/widgets/custom_button.dart';
import 'package:barber_shop/widgets/custom_drawer_header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: context.screenWidth * 0.6,
      child: Column(
        children: [
          const CustomDrawerHeader(),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              context.push(const ProfileView());
            },
          ),
          ListTile(
            leading: const Icon(Icons.location_on_rounded),
            title: const Text('Branch Location'),
            onTap: () {
              context.push(const ChooseBranchView()); // Close the drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.history_edu),
            title: const Text('History'),
            onTap: () {
              // Add navigation logic for settings
              context.pop(); // Close the drawer
            },
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.screenWidth * 0.1,
              vertical: context.screenHeight * 0.05,
            ),
            child: CustomButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                context.pushAndRemoveUntil(const LoginView());
              },
              title: 'Log out',
              color: KColors.redColor,
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
