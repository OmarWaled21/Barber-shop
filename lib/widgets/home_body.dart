import 'package:barber_shop/constants/colors.dart';
import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:barber_shop/widgets/home_service_body.dart';
import 'package:barber_shop/widgets/home_shop_body.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Listen for tab changes and trigger a rebuild
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: KColors.scaffoldBackGroundColor,
                borderRadius: _tabController.index == 0
                    ? const BorderRadius.only(bottomRight: Radius.circular(20))
                    : const BorderRadius.only(bottomLeft: Radius.circular(20)),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              labelStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              unselectedLabelStyle: const TextStyle(
                color: KColors.greyColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              tabs: const [
                Tab(text: 'Services'),
                Tab(text: 'Shop'),
              ],
            ),
            SizedBox(
              width: context.screenWidth,
              height: context.screenHeight * 0.74,
              child: const TabBarView(
                children: [
                  HomeServiceBody(),
                  HomeShopBody(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
