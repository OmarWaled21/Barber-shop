import 'package:barber_shop/constants/colors.dart';
import 'package:barber_shop/cubits/initialize_cubit/initialize_cubit.dart';
import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:barber_shop/helper/navigator_extention.dart';
import 'package:barber_shop/models/user_model.dart';
import 'package:barber_shop/services/branch_services.dart';
import 'package:barber_shop/views/home_view.dart';
import 'package:barber_shop/widgets/choose_branch_list_view.dart';
import 'package:barber_shop/widgets/custom_app_bar.dart';
import 'package:barber_shop/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseBranchView extends StatefulWidget {
  const ChooseBranchView({super.key});

  @override
  State<ChooseBranchView> createState() => _ChooseBranchViewState();
}

String? selectedBranchGovern;
String? selectedBranchLocation;

class _ChooseBranchViewState extends State<ChooseBranchView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.screenWidth, context.screenHeight * 0.09),
        child: CustomAppBar(
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: 'Choose Branch Location',
          titleColor: KColors.darkerYellowColor,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ChoosrBranchListView(
              onBranchSelected: (branch) {
                setState(() {
                  selectedBranchGovern = branch.govern;
                  selectedBranchLocation = branch.desc;
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: context.screenWidth * 0.25,
              right: context.screenWidth * 0.25,
              bottom: context.screenHeight * 0.1,
            ),
            child: CustomButton(
              onPressed: () async {
                UserModel user =
                    BlocProvider.of<InitializeCubit>(context).userModel;
                try {
                  if (selectedBranchGovern != null &&
                      selectedBranchLocation != null) {
                    await BranchServices().saveBranch(
                      UserModel(
                        name: user.name,
                        email: user.email,
                        phone: user.phone,
                        branchGovern: selectedBranchGovern,
                        branchLocation: selectedBranchLocation,
                      ),
                    );
                    context.pushAndRemoveUntil(const HomeView());
                  }
                } catch (e) {
                  debugPrint(e.toString());
                }
              },
              title: 'Continue',
            ),
          ),
        ],
      ),
    );
  }
}
