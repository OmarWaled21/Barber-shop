import 'package:barber_shop/widgets/custom_button.dart';
import 'package:barber_shop/widgets/shop_home_list_view.dart';
import 'package:flutter/material.dart';

class HomeShopBody extends StatelessWidget {
  const HomeShopBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ShopHomeGridView(),
        const SizedBox(height: 16),
        CustomButton(onPressed: () {}, title: 'Order'),
      ],
    );
  }
}
