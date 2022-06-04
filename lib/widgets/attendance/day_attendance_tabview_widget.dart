
import 'package:cia/models/models.dart';
import 'package:flutter/material.dart';

class DayAttendanceTabView extends StatelessWidget {

  final MapEntry<DateTime, List<Session>> sessions;

  const DayAttendanceTabView({Key? key, required this.sessions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      alignment: Alignment.center,
      child: ListView.builder(
          itemCount: sessions.value.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(sessions.value[index].courseName, style: Theme.of(context).textTheme.headline3!.copyWith(color: const Color(0xFF464B63)),),
              subtitle: Text("Classes Attended ${sessions.value[index].numAttended.toString()}/${sessions.value[index].numHeld}", style: Theme.of(context).textTheme.headline5,),
            );
          }),
    );
  }
}
