import 'dart:developer';

import 'package:barber_shop/constants/assets.gen.dart';
import 'package:barber_shop/constants/colors.dart';
import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:barber_shop/helper/navigator_extention.dart';
import 'package:barber_shop/helper/show_snack_bar.dart';
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

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                  'Register',
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
                  const Text("Already have an account?"),
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: const Text(
                      " Login now",
                      style: TextStyle(color: KColors.darkerYellowColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 64),
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
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
    context.pushAndRemoveUntil(const HomeView());
  }
}
