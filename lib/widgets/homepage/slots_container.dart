import 'package:cia/models/models.dart';
import 'package:cia/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SlotsContainer extends StatelessWidget {
  const SlotsContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      height: 120,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GestureDetector(
                  onTap: () => SlotData.slots[index].onTap(context),
                  child: Slot(slotData: SlotData.slots[index])),
            );
          },
          itemCount: SlotData.slots.length),
    );
  }
}
