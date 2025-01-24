import 'package:barber_shop/constants/colors.dart';
import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:barber_shop/models/service_item_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ServiceItemCard extends StatelessWidget {
  const ServiceItemCard({
    super.key,
    required this.serviceItem,
    required this.isSelected,
    required this.onSelected,
  });

  final ServiceItemModel serviceItem;
  final bool isSelected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: context.screenWidth * 0.03),
        color: isSelected ? KColors.mainColor : KColors.scaffoldBackGroundColor,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CachedNetworkImage(
                imageUrl: serviceItem.image,
                height: context.devicePixelRatio * 25,
              ),
              Text(
                serviceItem.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: context.devicePixelRatio * 7,
                ),
              ),
              Text(
                '${serviceItem.price} L.E',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: context.devicePixelRatio * 7,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
