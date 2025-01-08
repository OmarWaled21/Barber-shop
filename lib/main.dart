import 'package:barber_shop/cubits/branch_cubit/branch_cubit.dart';
import 'package:barber_shop/helper/simple_bloc_opserver.dart';
import 'package:barber_shop/views/home_view.dart';
import 'package:barber_shop/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = SimpleBlocOpserver();
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
        home: const HomeView(),
      ),
    );
  }
}
