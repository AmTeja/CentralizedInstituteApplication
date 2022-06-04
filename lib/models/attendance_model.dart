// To parse this JSON data, do
//
//     final attendance = attendanceFromMap(jsonString);

import 'dart:convert';
import 'package:cia/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceProfile {

  const AttendanceProfile({
    required this.totalHeld,
    required this.totalAttended,
    required this.courseProfiles
  });

  final int totalHeld;
  final int totalAttended;
  final List<CourseProfile> courseProfiles;

  factory AttendanceProfile.fromSnap(DocumentSnapshot snapshot) {
    return AttendanceProfile(
        totalHeld: snapshot['totalHeld'],
        totalAttended: snapshot['totalAttended'],
        courseProfiles: (List<Map<String, dynamic>>.from(snapshot["courses"].map((x) => x))).map((e) {
          return CourseProfile.fromMap(e);
        }).toList(),
    );
  }

  static const empty = AttendanceProfile(totalHeld: 0, totalAttended: 0, courseProfiles: []);

}

class CourseProfile {

  CourseProfile({
    required this.courseName,
    required this.courseCode,
    required this.totalHeld,
    required this.totalAttended
  });

  final String courseName;
  final String courseCode;
  int totalAttended;
  int totalHeld;

  CourseProfile copyWith({
    String? courseName,
    String? courseCode,
    int? totalHeld,
    int? totalAttended
  }) {
    return CourseProfile(
        courseName: courseName ?? this.courseName,
        courseCode: courseCode ?? this.courseCode,
        totalHeld: totalHeld ?? this.totalHeld,
        totalAttended: totalAttended ?? this.totalAttended
    );
  }

  factory CourseProfile.fromMap(Map<String, dynamic> json) {
    return CourseProfile(
        courseName: json['courseName'],
        courseCode: json['courseCode'],
        totalHeld: json['totalHeld'],
        totalAttended: json['totalAttended']
    );
  }
}

class Session {
  Session({
    required this.attended,
    required this.courseName,
    required this.courseCode,
    required this.startTime,
    required this.markedBy,
    required this.endTime,
    this.numHeld = 1,
    this.numAttended
  });

  final bool attended;
  final String courseName;
  final String courseCode;
  final DateTime startTime;
  final String markedBy;
  final DateTime endTime;
  final int? numHeld;
  final int? numAttended;

  Session copyWith({
    bool? attended,
    String? courseName,
    String? courseCode,
    DateTime? startTime,
    String? markedBy,
    DateTime? endTime,
    int? numAttended,
    int? numHeld
  }) =>
      Session(
        attended: attended ?? this.attended,
        courseName: courseName ?? this.courseName,
        courseCode: courseCode ?? this.courseCode,
        startTime: startTime ?? this.startTime,
        markedBy: markedBy ?? this.markedBy,
        endTime: endTime ?? this.endTime,
        numAttended: numAttended ?? this.numAttended,
        numHeld: numHeld ?? this.numHeld
      );

  // factory Session.fromJson(String str) => Session.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Session.fromSnapshot(DocumentSnapshot snapshot) => Session(
    attended: snapshot["attended"],
    courseName: snapshot["courseName"],
    courseCode: snapshot["courseCode"],
    startTime: (snapshot["startTime"] as Timestamp).toDate(),
    markedBy: snapshot["markedBy"],
    endTime: (snapshot["endTime"] as Timestamp).toDate(),
    numAttended: snapshot["attended"] ? 1 : 0,
  );

  Map<String, dynamic> toMap() => {
    "attended": attended,
    "courseName": courseName,
    "courseCode": courseCode,
    "startTime": startTime.toIso8601String(),
    "markedBy": markedBy,
    "endTime": endTime.toIso8601String(),
    "numHeld" : numHeld,
    "numAttended" : numAttended
  };
}
