import 'package:barber_shop/constants/assets.gen.dart';
import 'package:flutter/material.dart';

class ShopItemCard extends StatelessWidget {
  const ShopItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Image.asset(Assets.hairCut.path),
          ),
          title: const Text(
            'Secissors',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: const Text(
            'a test description',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 18),
          ),
          trailing: const Text(
            '15 L.E',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
        ),
      ),
    );
  }
}
