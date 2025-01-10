import 'package:barber_shop/models/shop_item_model.dart';
import 'package:barber_shop/services/home_shop_items_service.dart';
import 'package:barber_shop/views/loading_view.dart';
import 'package:barber_shop/widgets/shop_item_card.dart';
import 'package:flutter/material.dart';

class ShopHomeGridView extends StatelessWidget {
  const ShopHomeGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: HomeShopItemsService().getServiceItems(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Expanded(child: LoadingView());
        }

        if (snapshot.hasError ||
            snapshot.data == null ||
            snapshot.data!.isEmpty) {
          return const Center(
              child: Text("No services found or an error occurred."));
        }
        final List<ShopItemModel> shopItems = snapshot.data!;
        return Expanded(
          child: ListView.builder(
            itemCount: shopItems.length,
            itemBuilder: (context, index) {
              return ShopItemCard(shopItem: shopItems[index]);
            },
          ),
        );
      },
    );
  }
}
