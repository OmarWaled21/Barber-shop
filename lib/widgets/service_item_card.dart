import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:barber_shop/models/service_item_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ServiceItemCard extends StatelessWidget {
  const ServiceItemCard({super.key, required this.serviceItem});

  final ServiceItemModel serviceItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        height: 200,
        child: Card(
          margin: EdgeInsets.symmetric(
            horizontal: context.screenWidth * 0.03,
          ),
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CachedNetworkImage(
                  imageUrl: serviceItem.image,
                  height: context.screenHeight * 0.12,
                ),
                Text(
                  serviceItem.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  '${serviceItem.price} L.E',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
