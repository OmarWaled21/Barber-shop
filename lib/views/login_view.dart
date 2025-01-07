import 'package:barber_shop/constants/assets.gen.dart';
import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:barber_shop/widgets/custom_app_bar.dart';
import 'package:barber_shop/widgets/custom_button.dart';
import 'package:barber_shop/widgets/custom_text_form_field.dart';
import 'package:barber_shop/widgets/custom_text_form_field_password.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.screenWidth, context.screenHeight * 0.09),
        child: const CustomAppBar(title: 'Barber Shop'),
      ),
      body: const LoginViewBody(),
    );
  }
}

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.screenWidth * 0.04),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 1),
            Image.asset(
              Assets.logo.path,
              height: context.screenHeight * .2,
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Login',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            const CustomTextFormField(title: 'Email'),
            const SizedBox(height: 16),
            const CustomTextFormFieldPassword(title: 'Password'),
            const SizedBox(height: 64),
            const CustomButton(),
            const Spacer(flex: 3)
          ],
        ),
      ),
    );
  }
}
