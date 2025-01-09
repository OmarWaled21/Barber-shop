import 'package:barber_shop/models/branch_model.dart';
import 'package:barber_shop/services/branch_services.dart';
import 'package:barber_shop/views/loading_view.dart';
import 'package:barber_shop/widgets/branch_details_container.dart';
import 'package:flutter/widgets.dart';

class ChoosrBranchListView extends StatefulWidget {
  const ChoosrBranchListView({super.key, required this.onBranchSelected});
  final Function(BranchModel) onBranchSelected;

  @override
  State<ChoosrBranchListView> createState() => _ChoosrBranchListViewState();
}

class _ChoosrBranchListViewState extends State<ChoosrBranchListView> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: BranchServices().getBranches(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<BranchModel> branches = snapshot.data!;

          return ListView.builder(
            itemCount: branches.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() => selectedIndex = index);
                  widget.onBranchSelected(branches[index]); // Notify parent
                },
                child: BranchDetailsContainer(
                  isSelected: selectedIndex == index,
                  branch: branches[index],
                ),
              );
            },
          );
        } else {
          return const LoadingView();
        }
      },
    );
  }
}
