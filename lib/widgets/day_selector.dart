import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:barber_shop/widgets/day_header_row.dart';
import 'package:flutter/material.dart';

class DaySelector extends StatefulWidget {
  const DaySelector({super.key});

  @override
  State<DaySelector> createState() => _DaySelectorState();
}

class _DaySelectorState extends State<DaySelector> {
  int? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenHeight * 0.21,
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: context.screenWidth * 0.05,
          // vertical: context.screenHeight * 0.01,
        ),
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const HeaderRow(),
              Expanded(
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: 14, // Example days count
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedDay = index;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: _selectedDay == index
                              ? Colors.yellow.shade700
                              : null,
                        ),
                        child: Text(
                          "${index + 1}",
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
