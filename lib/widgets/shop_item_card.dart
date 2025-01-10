import 'package:barber_shop/models/shop_item_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ShopItemCard extends StatelessWidget {
  const ShopItemCard({super.key, required this.shopItem});

  final ShopItemModel shopItem;

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
            child: CachedNetworkImage(imageUrl: shopItem.image),
          ),
          title: Text(
            shopItem.title,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            shopItem.desc,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 18),
          ),
          trailing: Text(
            '${shopItem.price} L.E',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
        ),
      ),
    );
  }
}
