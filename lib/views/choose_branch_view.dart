import 'package:barber_shop/constants/colors.dart';
import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:barber_shop/helper/navigator_extention.dart';
import 'package:barber_shop/widgets/choose_branch_list_view.dart';
import 'package:barber_shop/widgets/custom_app_bar.dart';
import 'package:barber_shop/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ChooseBranchView extends StatelessWidget {
  const ChooseBranchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.screenWidth, context.screenHeight * 0.09),
        child: CustomAppBar(
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: 'Choose Branch Location',
          titleColor: KColors.darkerYellowColor,
        ),
      ),
      body: Column(
        children: [
          const Expanded(
            child: ChoosrBranchListView(),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: context.screenWidth * 0.25,
              right: context.screenWidth * 0.25,
              bottom: context.screenHeight * 0.1,
            ),
            child: CustomButton(onPressed: () {}, title: 'Continue'),
          ),
        ],
      ),
    );
  }
}
