import 'package:barber_shop/widgets/service_item_card.dart';
import 'package:flutter/material.dart';

class ServiceHomeGridView extends StatelessWidget {
  const ServiceHomeGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 20, mainAxisExtent: 200),
        itemCount: 4,
        itemBuilder: (context, index) {
          return const ServiceItemCard();
        },
      ),
    );
  }
}
