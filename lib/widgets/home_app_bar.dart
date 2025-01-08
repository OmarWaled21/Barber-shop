import 'package:barber_shop/constants/colors.dart';
import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:barber_shop/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomAppBar(
          title: 'Good Morning',
          centerTitle: false,
          titleSize: 30,
          titleColor: KColors.darkerYellowColor,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
        Container(
          padding:
              EdgeInsets.only(left: context.screenWidth * 0.04, bottom: 20),
          color: KColors.scaffoldBackGroundColor,
          width: context.screenWidth,
          child: const Text(
            'Omar !',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
