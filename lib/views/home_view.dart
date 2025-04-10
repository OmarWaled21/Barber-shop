import 'package:barber_shop/constants/colors.dart';
import 'package:barber_shop/views/drawer_view.dart';
import 'package:barber_shop/widgets/home_app_bar.dart';
import 'package:barber_shop/widgets/home_body.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: KColors.backGroundColor,
      endDrawer: DrawerView(),
      body: Column(
        children: [
          HomeAppBar(),
          HomeBody(),
        ],
      ),
    );
  }
}
