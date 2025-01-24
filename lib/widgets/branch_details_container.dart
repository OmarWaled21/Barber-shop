import 'package:barber_shop/constants/assets.gen.dart';
import 'package:barber_shop/constants/colors.dart';
import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:barber_shop/models/branch_model.dart';
import 'package:barber_shop/services/branch_services.dart';
import 'package:flutter/material.dart';

class BranchDetailsContainer extends StatelessWidget {
  const BranchDetailsContainer(
      {super.key, required this.isSelected, required this.branch});
  final bool isSelected;
  final BranchModel branch;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.screenWidth * 0.03),
      margin: EdgeInsets.symmetric(
        horizontal: context.screenWidth * 0.04,
        vertical: context.screenHeight * 0.01,
      ),
      decoration: BoxDecoration(
        color: isSelected ? KColors.mainColor : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Image.asset(
            Assets.shop.path,
            width: context.screenWidth * 0.2,
          ),
          SizedBox(width: context.screenWidth * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  branch.govern,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: context.screenHeight * 0.005),
                Text(
                  branch.desc,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () =>
                BranchServices().openMapsSheet(context, branch.lat, branch.lng),
            iconSize: 40,
            icon: Icon(
              Icons.location_on,
              color: Colors.yellow.shade900,
            ),
          ),
        ],
      ),
    );
  }
}
