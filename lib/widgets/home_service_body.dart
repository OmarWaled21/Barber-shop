import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:barber_shop/helper/navigator_extention.dart';
import 'package:barber_shop/models/service_item_model.dart';
import 'package:barber_shop/services/home_service_items_service.dart';
import 'package:barber_shop/views/booking_view.dart';
import 'package:barber_shop/widgets/custom_button.dart';
import 'package:barber_shop/widgets/service_home_grid_view.dart';
import 'package:barber_shop/widgets/total_price.dart';
import 'package:flutter/material.dart';

class HomeServiceBody extends StatefulWidget {
  const HomeServiceBody({super.key});

  @override
  State<HomeServiceBody> createState() => _HomeServiceBodyState();
}

class _HomeServiceBodyState extends State<HomeServiceBody> {
  final Set<ServiceItemModel> _selectedServices = {};

  double get _totalPrice {
    return _selectedServices.fold(0, (sum, item) => sum + item.price);
  }

  void _toggleSelection(ServiceItemModel serviceItem) {
    setState(() {
      if (_selectedServices.contains(serviceItem)) {
        _selectedServices.remove(serviceItem);
      } else {
        _selectedServices.add(serviceItem);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        ServiceHomeGridView(
          selectedServices: _selectedServices,
          onToggleSelection: _toggleSelection,
        ),
        TotalPriceDisplay(totalPrice: _totalPrice),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.screenWidth * 0.2),
          child: CustomButton(
            onPressed: () async {
              if (_selectedServices.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Please select at least one service."),
                  ),
                );
                return;
              }

              // Convert selected services Set to a List
              List<ServiceItemModel> selectedServicesList =
                  _selectedServices.toList();

              await HomeServiceItemsService().saveBookingHistory(
                totalPrice: _totalPrice,
                selectedServices: selectedServicesList,
              );

              context.push(const BookingDateView());
            },
            title: 'Book',
          ),
        ),
      ],
    );
  }
}
