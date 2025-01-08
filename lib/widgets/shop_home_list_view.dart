import 'package:barber_shop/widgets/shop_item_card.dart';
import 'package:flutter/material.dart';

class ShopHomeGridView extends StatelessWidget {
  const ShopHomeGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return const ShopItemCard();
        },
      ),
    );
  }
}
