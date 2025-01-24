import 'package:barber_shop/constants/colors.dart';
import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key, this.backgroundColor});

  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: SizedBox(
          height: context.screenHeight * 0.3,
          child: const LoadingIndicator(
            indicatorType: Indicator.ballTrianglePath,
            colors: [
              KColors.mainColor,
              KColors.darkerYellowColor,
              KColors.greyColor,
            ],
          ),
        ),
      ),
    );
  }
}
