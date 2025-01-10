import 'package:barber_shop/constants/colors.dart';
import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:barber_shop/widgets/custom_button.dart';
import 'package:barber_shop/widgets/shop_home_list_view.dart';
import 'package:flutter/material.dart';

class HomeShopBody extends StatelessWidget {
  const HomeShopBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        const ShopHomeGridView(),
        const SizedBox(height: 16),
        const Padding(
          padding: EdgeInsets.only(left: 16),
          child: Text(
            'Total Price: 50 L.E',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: KColors.darkerYellowColor,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.screenWidth * 0.2),
          child: CustomButton(onPressed: () {}, title: 'Order'),
        ),
      ],
    );
  }
}
