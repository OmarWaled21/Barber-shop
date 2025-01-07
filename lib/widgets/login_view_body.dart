import 'package:barber_shop/constants/assets.gen.dart';
import 'package:barber_shop/constants/colors.dart';
import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:barber_shop/helper/navigator_extention.dart';
import 'package:barber_shop/views/home_view.dart';
import 'package:barber_shop/views/register_view.dart';
import 'package:barber_shop/widgets/custom_button.dart';
import 'package:barber_shop/widgets/custom_text_form_field.dart';
import 'package:barber_shop/widgets/custom_text_form_field_password.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.screenWidth * 0.04),
        child: Form(
          key: formKey,
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
              const CustomTextFormField(
                title: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              const CustomTextFormFieldPassword(title: 'Password'),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text("Don't have an account yet?"),
                  GestureDetector(
                    onTap: () {
                      context.push(const RegisterView());
                    },
                    child: const Text(
                      " Register now",
                      style: TextStyle(color: KColors.darkerYellowColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 64),
              CustomButton(
                title: 'Log in',
                onPressed: () {
                  setState(() => isLoading = true);
                  if (formKey.currentState!.validate()) {
                    context.push(const HomeView());
                  }
                  setState(() => isLoading = false);
                },
              ),
              const Spacer(flex: 3)
            ],
          ),
        ),
      ),
    );
  }
}
