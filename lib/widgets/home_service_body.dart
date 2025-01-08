import 'package:barber_shop/widgets/custom_button.dart';
import 'package:barber_shop/widgets/service_home_grid_view.dart';
import 'package:flutter/material.dart';

class HomeServiceBody extends StatelessWidget {
  const HomeServiceBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ServiceHomeGridView(),
        CustomButton(onPressed: () {}, title: 'Order'),
      ],
    );
  }
}
