import 'package:barber_shop/cubits/branch_cubit/branch_cubit.dart';
import 'package:barber_shop/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BranchCubit(),
      child: MaterialApp(
        title: 'Barber Shop',
        theme: ThemeData(fontFamily: 'OpenSans'),
        debugShowCheckedModeBanner: false,
        home: const LoginView(),
      ),
    );
  }
}
