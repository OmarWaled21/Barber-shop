import 'package:barber_shop/widgets/item_card.dart';
import 'package:flutter/material.dart';

class ServiceHomeGridView extends StatelessWidget {
  const ServiceHomeGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: 4,
      itemBuilder: (context, index) {
        return const ItemCard();
      },
    );
  }
}
