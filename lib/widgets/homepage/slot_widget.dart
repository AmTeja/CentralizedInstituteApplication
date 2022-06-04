import 'package:cia/config/theme.dart';
import 'package:cia/models/models.dart';
import 'package:flutter/material.dart';

class Slot extends StatelessWidget {
  final SlotData slotData;

  const Slot({Key? key, required this.slotData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 120.0,
      height: 120.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(slotData.iconData, size: 27, color: const Color(0xFF3B3B3B),),
          const SizedBox(height: 5.0,),
          Text(slotData.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5!
                .copyWith(color: secondaryTextColor),)
        ],
      ),
    );
  }
}
