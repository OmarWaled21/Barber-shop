import 'package:barber_shop/constants/colors.dart';
import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:barber_shop/models/shop_item_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ShopItemCard extends StatelessWidget {
  const ShopItemCard({
    super.key,
    required this.shopItem,
    required this.isSelected,
    required this.onSelected,
  });

  final ShopItemModel shopItem;
  final bool isSelected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Card(
        color: isSelected ? KColors.mainColor : KColors.scaffoldBackGroundColor,
        child: SizedBox(
          width: context.screenWidth,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              spacing: 16,
              children: [
                CachedNetworkImage(
                  imageUrl: shopItem.image,
                  height: context.devicePixelRatio * 20,
                ),
                DescShopItemColumn(shopItem: shopItem),
                const Spacer(),
                Text(
                  '${shopItem.price} L.E',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: context.devicePixelRatio * 8),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DescShopItemColumn extends StatelessWidget {
  const DescShopItemColumn({super.key, required this.shopItem});

  final ShopItemModel shopItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          shopItem.title,
          style: TextStyle(
            fontSize: context.devicePixelRatio * 8,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          shopItem.desc,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: context.devicePixelRatio * 4),
        ),
      ],
    );
  }
}
