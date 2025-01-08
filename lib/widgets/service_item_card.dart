import 'package:barber_shop/constants/assets.gen.dart';
import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:flutter/material.dart';

class ServiceItemCard extends StatelessWidget {
  const ServiceItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        margin: EdgeInsets.symmetric(
          vertical: context.screenHeight * 0.01,
          horizontal: context.screenWidth * 0.03,
        ),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                Assets.cream.path,
                height: context.screenHeight * 0.12,
              ),
              const Text(
                'Cream Path',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const Text(
                '100 L.E',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
