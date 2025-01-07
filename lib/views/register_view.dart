import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:barber_shop/widgets/custom_app_bar.dart';
import 'package:barber_shop/widgets/register_view_body.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.screenWidth, context.screenHeight * 0.09),
        child: const CustomAppBar(
          title: 'Barber Shop',
          leading: SizedBox(),
        ),
      ),
      body: const RegisterViewBody(),
    );
  }
}
