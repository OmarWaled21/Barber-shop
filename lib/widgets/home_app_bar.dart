import 'package:barber_shop/constants/colors.dart';
import 'package:barber_shop/cubits/initialize_cubit/initialize_cubit.dart';
import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:barber_shop/helper/navigator_extention.dart';
import 'package:barber_shop/models/user_model.dart';
import 'package:barber_shop/views/choose_branch_view.dart';
import 'package:barber_shop/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          titleSize: context.devicePixelRatio * 8,
          titleColor: KColors.darkerYellowColor,
          actions: [
            IconButton(
              onPressed: () => context.push(const ChooseBranchView()),
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
        BlocBuilder<InitializeCubit, InitializeState>(
          builder: (context, state) {
            UserModel user =
                BlocProvider.of<InitializeCubit>(context).userModel;

            return Container(
              padding: EdgeInsets.only(
                left: context.screenWidth * 0.04,
              ),
              color: KColors.scaffoldBackGroundColor,
              width: context.screenWidth,
              child: Text(
                '${user.name.split(' ')[0]} !',
                style: TextStyle(
                    fontSize: context.devicePixelRatio * 8,
                    fontWeight: FontWeight.bold),
              ),
            );
          },
        ),
      ],
    );
  }
}
