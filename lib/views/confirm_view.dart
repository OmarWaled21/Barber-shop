import 'package:barber_shop/cubits/initialize_cubit/initialize_cubit.dart';
import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:barber_shop/helper/navigator_extention.dart';
import 'package:barber_shop/models/user_model.dart';
import 'package:barber_shop/widgets/custom_app_bar.dart';
import 'package:barber_shop/widgets/custom_button.dart';
import 'package:barber_shop/widgets/order_number.dart';
import 'package:barber_shop/widgets/row_confirm_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmView extends StatelessWidget {
  const ConfirmView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.screenWidth, context.screenHeight * 0.09),
        child: CustomAppBar(
          title: 'Confirm Booking',
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: context.screenWidth * 0.07),
              child: ListView(
                children: [
                  const OrderNumber(),
                  BlocBuilder<InitializeCubit, InitializeState>(
                    builder: (context, state) {
                      UserModel user =
                          BlocProvider.of<InitializeCubit>(context).userModel;

                      return Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 2.5),
                        child: RowConfirmSection(
                          title: 'Name',
                          value: user.name,
                        ),
                      );
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.5),
                    child: RowConfirmSection(
                      title: 'Service',
                      value: 'Shaving, Cream Path',
                    ),
                  ),
                  SizedBox(height: context.screenHeight * 0.03),
                  const RowConfirmSection(
                      title: 'Total Price', value: '500 L.E'),
                  SizedBox(height: context.screenHeight * 0.03),
                  const RowConfirmSection(
                    title: 'Branch',
                    value: 'Cairo',
                    subValue: 'Obour 4th district',
                  ),
                  SizedBox(height: context.screenHeight * 0.03),
                  const RowConfirmSection(
                    title: 'Booked Time',
                    value: '8/1/2025',
                    subValue: '8:00 PM',
                  ),
                  SizedBox(height: context.screenHeight * 0.03),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.screenWidth * 0.07,
                  vertical: context.screenHeight * 0.02),
              child: CustomButton(title: 'Confirm Order', onPressed: () {}),
            ),
          ),
        ],
      ),
    );
  }
}
