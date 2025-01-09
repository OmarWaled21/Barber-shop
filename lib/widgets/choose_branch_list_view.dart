import 'package:barber_shop/widgets/branch_details_container.dart';
import 'package:flutter/widgets.dart';

class ChoosrBranchListView extends StatefulWidget {
  const ChoosrBranchListView({super.key});

  @override
  State<ChoosrBranchListView> createState() => _ChoosrBranchListViewState();
}

class _ChoosrBranchListViewState extends State<ChoosrBranchListView> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
          },
          child: BranchDetailsContainer(isSelected: selectedIndex == index),
        );
      },
    );
  }
}
