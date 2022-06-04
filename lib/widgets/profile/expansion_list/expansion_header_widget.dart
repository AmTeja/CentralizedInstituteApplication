import 'package:cia/models/models.dart';
import 'package:flutter/material.dart';

class ExpansionHeader extends StatelessWidget {

  final ExpansionItem expansionItem;

  const ExpansionHeader({Key? key, required this.expansionItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4)
          ),
          child: Icon(expansionItem.headerIcon, color: const Color(0xFF707070),),
        ),
        title: Text(expansionItem.headerValue, style: Theme.of(context).textTheme.headline3,),
      ),
    );
  }
}
