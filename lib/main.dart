import 'package:barber_shop/cubits/branch_cubit/branch_cubit.dart';
import 'package:barber_shop/firebase_options.dart';
import 'package:barber_shop/helper/simple_bloc_opserver.dart';
import 'package:barber_shop/widgets/branch_handler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  Bloc.observer = SimpleBlocOpserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BranchCubit()..checkUserBranch(),
      child: MaterialApp(
        title: 'Barber Shop',
        theme: ThemeData(fontFamily: 'OpenSans'),
        debugShowCheckedModeBanner: false,
        home: const BranchHandler(),
      ),
    );
  }
}
