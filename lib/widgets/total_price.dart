import 'package:barber_shop/constants/colors.dart';
import 'package:flutter/material.dart';

class TotalPriceDisplay extends StatelessWidget {
  const TotalPriceDisplay({super.key, required this.totalPrice});

  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    if (totalPrice == 0) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Text(
        'Total Price: ${totalPrice.toStringAsFixed(2)} L.E',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: KColors.darkerYellowColor,
        ),
      ),
    );
  }
}
