import 'dart:developer';
import 'package:barber_shop/constants/assets.gen.dart';
import 'package:barber_shop/constants/colors.dart';
import 'package:barber_shop/cubits/initialize_cubit/initialize_cubit.dart';
import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:barber_shop/helper/navigator_extention.dart';
import 'package:barber_shop/helper/show_snack_bar.dart';
import 'package:barber_shop/services/login_service.dart';
import 'package:barber_shop/views/home_view.dart';
import 'package:barber_shop/views/register_view.dart';
import 'package:barber_shop/widgets/custom_button.dart';
import 'package:barber_shop/widgets/custom_text_form_field.dart';
import 'package:barber_shop/widgets/custom_text_form_field_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final LoginService loginService = LoginService(); // Initialize the service

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
              CustomTextFormField(
                title: 'Email',
                textEditingController: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              CustomTextFormFieldPassword(
                title: 'Password',
                textEditingController: passwordController,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text("Don't have an account yet?"),
                  GestureDetector(
                    onTap: () => context.push(const RegisterView()),
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
                onPressed: loginButton,
              ),
              const Spacer(flex: 3)
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loginButton() async {
    setState(() => isLoading = true);
    if (formKey.currentState!.validate()) {
      try {
        final userModel = await loginService.loginWithEmailPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // Call the InitializeCubit to assign the UserModel
        if (userModel != null) {
          context.read<InitializeCubit>().assignUserModel(userModel);
        }

        // Navigate to the HomeView and remove previous screens from the stack
        context.pushAndRemoveUntil(const HomeView());
      } catch (e) {
        log('Error during login: $e');
        showSnackBar(context, 'Login failed. Please try again.');
      }
    }
    setState(() => isLoading = false);
  }
}
