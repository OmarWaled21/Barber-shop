import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:barber_shop/widgets/service_item_card.dart';
import 'package:flutter/material.dart';

class ServiceHomeGridView extends StatelessWidget {
  const ServiceHomeGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: context.devicePixelRatio * 0.5),
        itemCount: 4,
        itemBuilder: (context, index) {
          return const ServiceItemCard();
        },
      ),
    );
  }
}
