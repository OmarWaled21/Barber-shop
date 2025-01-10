import 'package:barber_shop/models/service_item_model.dart';
import 'package:barber_shop/services/home_service_items_service.dart';
import 'package:barber_shop/views/loading_view.dart';
import 'package:barber_shop/widgets/service_item_card.dart';
import 'package:flutter/material.dart';

class ServiceHomeGridView extends StatelessWidget {
  const ServiceHomeGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: HomeServiceItemsService().getServiceItems(),
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

        final List<ServiceItemModel> serviceItems = snapshot.data!;
        return Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 20, mainAxisExtent: 200),
            itemCount: serviceItems.length,
            itemBuilder: (context, index) {
              return ServiceItemCard(serviceItem: serviceItems[index]);
            },
          ),
        );
      },
    );
  }
}
