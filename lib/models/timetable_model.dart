// To parse this JSON data, do
//
//     final timetable = timetableFromMap(jsonString);

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class Timetable {
  Timetable({
    required this.days,
  });

  final List<Day> days;

  factory Timetable.fromJson(String str) => Timetable.fromMap(json.decode(str));

  // String toJson() => json.encode(toMap());

  factory Timetable.fromMap(Map<String, dynamic> json) {
    return Timetable(
      days: [],
    );
  }
  //
  // Map<String, dynamic> toMap() => {
  //   "days": days.toMap(),
  // };
}

class Day {
  Day({
    required this.sessions,
    required this.day,
  });

  final String day;
  final List<TimetableSession> sessions;

  Day copyWith({
    String? day,
    List<TimetableSession>? sessions,
  }) =>
      Day(
        day: day ?? this.day,
        sessions: sessions ?? this.sessions,
      );

  // factory Day.fromJson(String str) => Day.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Day.fromSnapshot({
    required DocumentSnapshot daySnapshot,
    required List<TimetableSession> sessions,
  }) {
    return Day(
        day: daySnapshot["day"],
        sessions: sessions
    );
  }

  Map<String, dynamic> toMap() => {
    "day": day,
    "sessions": sessions,
  };
}

class TimetableSession {
  TimetableSession({
    required this.courseName,
    required this.courseCode,
    required this.startTime,
    required this.endTime,
    required this.assignedProfessors,
    required this.extendedSessions,
  });

  final String courseName;
  final String courseCode;
  final DateTime startTime;
  final DateTime endTime;
  final List<String> assignedProfessors;
  final int extendedSessions;

  TimetableSession copyWith({
    String? courseName,
    String? courseCode,
    DateTime? startTime,
    DateTime? endTime,
    List<String>? assignedProfessors,
    int? extendedSessions,
  }) =>
      TimetableSession(
        courseName: courseName ?? this.courseName,
        courseCode: courseCode ?? this.courseCode,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        assignedProfessors: assignedProfessors ?? this.assignedProfessors,
        extendedSessions: extendedSessions ?? this.extendedSessions,
      );

  String toJson() => json.encode(toMap());

  factory TimetableSession.fromSnapshot(DocumentSnapshot snapshot) => TimetableSession(
    courseName: snapshot["courseName"],
    courseCode: snapshot["courseCode"],
    startTime: (snapshot["startTime"] as Timestamp).toDate(),
    endTime: (snapshot["endTime"] as Timestamp).toDate(),
    assignedProfessors: List<String>.from(snapshot["assignedProfessors"].map((x) => x)),
    extendedSessions: snapshot["extendedSessions"],
  );

  Map<String, dynamic> toMap() => {
    "courseName": courseName,
    "courseCode": courseCode,
    "startTime": startTime.toIso8601String(),
    "endTime": endTime.toIso8601String(),
    "assignedProfessors": List<dynamic>.from(assignedProfessors.map((x) => x)),
    "extendedSessions": extendedSessions,
  };
}

// var res = await firestore.collection('Timetables').doc('BTECH42CSEA').collection('days').get();
// List<Day> days = [];
// for(var daySnapshot in res.docs) {
//   var sessions = await firestore.collection('Timetables')
//       .doc('BTECH42CSEA').collection('days')
//       .doc(daySnapshot['day']).collection('sessions').get();
//   Day d = Day.fromSnapshot(daySnapshot: daySnapshot, sessions: sessions.docs.map((doc) => Session.fromSnapshot(doc)).toList());
//   days.add(d);
// }
// Timetable timetable = Timetable(days: days);