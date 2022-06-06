import 'package:cia/config/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDataTable extends StatelessWidget {

  final Iterable<MapEntry<String, dynamic>> entries;

  const CustomDataTable({Key? key, required this.entries}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constrains) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: constrains.minWidth),
              child: DataTable(
                showBottomBorder: true,
                columns: const <DataColumn>[
                  DataColumn(label: SizedBox.shrink(), numeric: true),
                  DataColumn(label: SizedBox.shrink()),
                ],
                rows: entries.map((e) {
                  return DataRow(
                      cells: [
                        DataCell(Text(e.key.toString().capitalize().splitCapital(), style: Theme.of(context).textTheme.headline4,)),
                        DataCell(Text(e.value.runtimeType == DateTime
                            ? DateFormat('yMMMd').format(e.value)
                            : e.value.toString(),
                          style: Theme.of(context).textTheme.headline4,)),
                      ]
                  );
                }).toList(),
              ),
            ),
          );
        }
    );
  }
}
