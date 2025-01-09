import 'dart:developer';

import 'package:barber_shop/constants/assets.gen.dart';
import 'package:barber_shop/constants/colors.dart';
import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:barber_shop/helper/navigator_extention.dart';
import 'package:barber_shop/helper/show_snack_bar.dart';
import 'package:barber_shop/models/user_model.dart';
import 'package:barber_shop/services/register_service.dart';
import 'package:barber_shop/views/home_view.dart';
import 'package:barber_shop/widgets/custom_button.dart';
import 'package:barber_shop/widgets/custom_text_form_field.dart';
import 'package:barber_shop/widgets/custom_text_form_field_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<RegisterViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final RegisterService registerService = RegisterService();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.screenWidth * 0.04),
        child: Form(
          key: formKey,
          child: Column(
            spacing: 16,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 1),
              Image.asset(
                Assets.logo.path,
                height: context.screenHeight * .2,
              ),
              // const SizedBox(height: 16),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Register',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              // const SizedBox(height: 16),
              CustomTextFormField(
                title: 'Name',
                textEditingController: nameController,
              ),
              CustomTextFormField(
                title: 'Phone',
                textEditingController: phoneController,
                keyboardType: TextInputType.phone,
              ),
              CustomTextFormField(
                title: 'Email',
                textEditingController: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              // const SizedBox(height: 16),
              CustomTextFormFieldPassword(
                title: 'Password',
                textEditingController: passwordController,
              ),
              // const SizedBox(height: 16),
              Row(
                children: [
                  const Text("Already have an account?"),
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: const Text(
                      " Login now",
                      style: TextStyle(color: KColors.darkerYellowColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomButton(
                title: 'Register',
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    setState(() => isLoading = true);
                    try {
                      await registerMethod();
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        showSnackBar(
                            context, 'The password provided is too weak!');
                      } else if (e.code == 'email-already-in-use') {
                        showSnackBar(context,
                            'The account already exist for this email.');
                      }
                    } catch (e) {
                      log(e.toString());
                    }
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

  Future<void> registerMethod() async {
    try {
      UserModel? user = await registerService.register(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        phone: phoneController.text,
      );

      if (user != null) {
        debugPrint('User registered successfully: ${user.name}');
      }
      context.pushAndRemoveUntil(const HomeView());
    } catch (e) {
      debugPrint("Registration failed: $e");
    }
  }
}
