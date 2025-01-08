import 'package:barber_shop/cubits/branch_cubit/branch_cubit.dart';
import 'package:barber_shop/views/home_view.dart';
import 'package:barber_shop/views/loading_view.dart';
import 'package:barber_shop/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BranchHandler extends StatelessWidget {
  const BranchHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BranchCubit, BranchState>(
      builder: (context, state) {
        if (state is BranchLoading) {
          return const LoadingView();
        } else if (state is BranchAssigned) {
          return const HomeView();
        } else {
          return const LoginView();
        }
      },
    );
  }
}
