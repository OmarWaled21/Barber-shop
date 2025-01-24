import 'package:barber_shop/constants/colors.dart';
import 'package:barber_shop/cubits/initialize_cubit/initialize_cubit.dart';
import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:barber_shop/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBar(
          backgroundColor: KColors.scaffoldBackGroundColor,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.menu), // Drawer icon
              onPressed: () {
                Scaffold.of(context).openEndDrawer(); // Open the endDrawer
              },
            ),
          ],
          title: Text(
            'Good Morning',
            style: TextStyle(
              fontSize: context.devicePixelRatio * 8,
              color: KColors.darkerYellowColor,
            ),
          ),
          centerTitle: false,
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
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
