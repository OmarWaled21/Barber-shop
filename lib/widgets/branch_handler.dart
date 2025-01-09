import 'package:barber_shop/cubits/initialize_cubit/initialize_cubit.dart';
import 'package:barber_shop/views/home_view.dart';
import 'package:barber_shop/views/loading_view.dart';
import 'package:barber_shop/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BranchHandler extends StatelessWidget {
  const BranchHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitializeCubit, InitializeState>(
      builder: (context, state) {
        if (state is InitializeLoading) {
          return const LoadingView();
        } else if (state is InitializeAssigned) {
          return const HomeView();
        } else {
          return const LoginView();
        }
      },
    );
  }
}
