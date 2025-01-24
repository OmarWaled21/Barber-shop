import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:barber_shop/helper/navigator_extention.dart';
import 'package:barber_shop/helper/show_snack_bar.dart';
import 'package:barber_shop/models/shop_item_model.dart';
import 'package:barber_shop/services/home_shop_items_service.dart';
import 'package:barber_shop/views/confirm_view.dart';
import 'package:barber_shop/widgets/custom_button.dart';
import 'package:barber_shop/widgets/shop_home_list_view.dart';
import 'package:barber_shop/widgets/total_price.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeShopBody extends StatefulWidget {
  const HomeShopBody({super.key});

  @override
  State<HomeShopBody> createState() => _HomeShopBodyState();
}

class _HomeShopBodyState extends State<HomeShopBody> {
  final Set<ShopItemModel> _shopItem = {};

  double get _totalPrice {
    return _shopItem.fold(0, (sum, item) => sum + item.price);
  }

  void _toggleSelection(ShopItemModel serviceItem) {
    setState(() {
      if (_shopItem.contains(serviceItem)) {
        _shopItem.remove(serviceItem);
      } else {
        _shopItem.add(serviceItem);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        ShopHomeGridView(
          onToggleSelection: _toggleSelection,
          selectedShopItem: _shopItem,
        ),
        const SizedBox(height: 16),
        TotalPriceDisplay(totalPrice: _totalPrice),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.screenWidth * 0.2),
          child: CustomButton(
            onPressed: () async {
              if (_shopItem.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Please select at least one service."),
                  ),
                );
                return;
              }

              // Convert selected services Set to a List
              List<ShopItemModel> selectedShopItems = _shopItem.toList();

              await HomeShopItemsService.instance.saveBookingHistory(
                totalPrice: _totalPrice,
                selectedShopItems: selectedShopItems,
              );

              final User? user = FirebaseAuth.instance.currentUser;
              if (user == null) {
                throw Exception("User not logged in");
              }
              final userDoc = await FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .get();

              final userLocation = userDoc['location'] as String;

              if (userLocation.isEmpty) {
                // TODO: Implement location dialog
                showSnackBar(
                    context, "Please update your location in the profile.");
              } else {
                context.push(const ConfirmView());
              }
            },
            title: 'Order',
          ),
        ),
      ],
    );
  }
}
