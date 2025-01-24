import 'package:barber_shop/cubits/initialize_cubit/initialize_cubit.dart';
import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:barber_shop/helper/show_snack_bar.dart';
import 'package:barber_shop/models/user_model.dart';
import 'package:barber_shop/services/profile_service.dart';
import 'package:barber_shop/widgets/custom_text_form_field.dart';
import 'package:barber_shop/widgets/profile_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final data = await ProfileService.instance.getUserData();
      setState(() {
        nameController.text = data['name'] ?? '';
        emailController.text = data['email'] ?? '';
        phoneController.text = data['phone'] ?? '';
        locationController.text = data['location'] ?? '';
      });
    } catch (e) {
      showSnackBar(context, "Error fetching user data: $e");
    }
  }

  Future<void> _saveUserData() async {
    try {
      await ProfileService.instance.saveUserData(
        name: nameController.text,
        phone: phoneController.text,
        location: locationController.text,
      );

      // Update the cubit after saving user data
      final updatedUserData = UserModel(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
      );

      BlocProvider.of<InitializeCubit>(context)
          .assignUserModel(updatedUserData);

      showSnackBar(context, "Profile updated");
    } catch (e) {
      showSnackBar(context, "Error saving user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ProfileAppBar(onSave: _saveUserData),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: context.screenHeight * 0.02,
                horizontal: context.screenWidth * 0.07,
              ),
              child: Column(
                spacing: context.screenHeight * 0.02,
                children: [
                  CustomTextFormField(
                    title: 'Name',
                    textEditingController: nameController,
                  ),
                  CustomTextFormField(
                    title: 'Email',
                    textEditingController: emailController,
                    enabled: false,
                  ),
                  CustomTextFormField(
                    title: 'Phone',
                    textEditingController: phoneController,
                  ),
                  CustomTextFormField(
                    title: 'Location',
                    textEditingController: locationController,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
