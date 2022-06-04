import 'package:flutter/material.dart';

class ExpansionItem {
  ExpansionItem({
    required this.headerValue,
    required this.headerIcon,
    this.expandedWidget,
    this.isExpanded = false,
    required this.tag,
  });

  String headerValue;
  IconData headerIcon;
  Widget? expandedWidget;
  bool isExpanded;
  String tag;
}