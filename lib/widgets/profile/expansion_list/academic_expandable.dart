import 'package:cia/config/string_extensions.dart';
import 'package:cia/models/models.dart';
import 'package:cia/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AcademicExpandable extends StatelessWidget {
  const AcademicExpandable({
    Key? key,
    required this.context,
    required this.education,
  }) : super(key: key);

  final BuildContext context;
  final Education education;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      height: 250,
      color: Colors.white,
      child: CustomDataTable(
        entries: education.toMap().entries
      )
    );
  }
}