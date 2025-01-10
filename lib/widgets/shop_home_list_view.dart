import 'package:barber_shop/constants/colors.dart';
import 'package:barber_shop/models/shop_item_model.dart';
import 'package:barber_shop/services/home_shop_items_service.dart';
import 'package:barber_shop/views/loading_view.dart';
import 'package:barber_shop/widgets/shop_item_card.dart';
import 'package:flutter/material.dart';

class ShopHomeGridView extends StatefulWidget {
  const ShopHomeGridView({
    super.key,
    required this.selectedShopItem,
    required this.onToggleSelection,
  });
  final Set<ShopItemModel> selectedShopItem;
  final Function(ShopItemModel) onToggleSelection;

  @override
  State<ShopHomeGridView> createState() => _ShopHomeGridViewState();
}

class _ShopHomeGridViewState extends State<ShopHomeGridView> {
  late final Future<List<ShopItemModel>> _getShopItem;

  @override
  void initState() {
    super.initState();
    _getShopItem = HomeShopItemsService().getShoptems();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getShopItem,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Expanded(
              child: LoadingView(
            backgroundColor: KColors.backGroundColor,
          ));
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
              return ShopItemCard(
                shopItem: shopItems[index],
                onSelected: () => widget.onToggleSelection(shopItems[index]),
                isSelected: widget.selectedShopItem.contains(shopItems[index]),
              );
            },
          ),
        );
      },
    );
  }
}
