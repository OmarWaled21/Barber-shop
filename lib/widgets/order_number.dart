import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:flutter/material.dart';

class OrderNumber extends StatelessWidget {
  const OrderNumber({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: Text(
            '1',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
          ),
        ),
        Divider(
          indent: context.screenWidth * 0.4,
          endIndent: context.screenWidth * 0.4,
          thickness: 1.5,
          color: Colors.black,
        ),
      ],
    );
  }
}
