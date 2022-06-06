import 'package:cia/config/string_extensions.dart';
import 'package:cia/models/models.dart';
import 'package:cia/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        padding: const EdgeInsets.only(left: 16.0, bottom: 32.0),
        color: Colors.white,
        child: CustomDataTable(
          entries: bio.toMap().entries,)
    );
  }
}
