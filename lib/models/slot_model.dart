import 'package:cia/screens/attendance_screen.dart';
import 'package:cia/screens/screens.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SlotData extends Equatable {

  final String title;
  final IconData iconData;
  final void Function(BuildContext) onTap;

  const SlotData({required this.title, required this.iconData, required this.onTap,});

  static List<SlotData> slots = [
    SlotData(title: "Attendance", iconData: Icons.front_hand, onTap: (BuildContext context) => Navigator.push(context, AttendanceScreen.route())),
    SlotData(title: "Performance", iconData: Icons.school, onTap: (BuildContext context) {}),
    SlotData(title: "Personal Details", iconData: Icons.person, onTap: (BuildContext context) => Navigator.push(context, ProfileScreen.route())),
    SlotData(title: "Complaints", iconData: Icons.question_mark_rounded, onTap: (BuildContext context) => Navigator.push(context, ComplaintsAndQueriesScreen.route()))
  ];

  @override
  List<Object?> get props => [title, iconData, onTap];
}