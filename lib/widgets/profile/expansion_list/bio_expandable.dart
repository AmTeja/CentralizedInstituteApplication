import 'package:cia/models/models.dart';
import 'package:flutter/material.dart';

class BioExpandable extends StatelessWidget {
  const BioExpandable({
    Key? key,
    required this.context,
    required this.bio,
  }) : super(key: key);

  final BuildContext context;
  final Bio bio;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      height: 250,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Aadhar Number: ${bio.aadharNo}", style: Theme.of(context).textTheme.headline3,),
        ],
      ),
    );
  }
}
