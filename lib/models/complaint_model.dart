
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Complaint extends Equatable {

  const Complaint({
    required this.resolved,
    required this.filedByRollNo,
    required this.filedByEmail,
    required this.title,
    required this.description,
  });

  final bool resolved;
  final String filedByRollNo;
  final String filedByEmail;
  final String title;
  final String description;

  factory Complaint.fromSnapshot(DocumentSnapshot snapshot) => Complaint(
      resolved: snapshot['resolved'],
      filedByRollNo: snapshot['filedByRollNo'],
      filedByEmail: snapshot['filedByEmail'],
      title: snapshot['title'],
      description: snapshot['description']
  );

  Map<String, dynamic> toMap() => {
    "resolved" : resolved,
    "filedByRollNo" : filedByRollNo,
    "filedByEmail" : filedByEmail,
    "title" : title,
    "description" : description
  };

  @override
  // TODO: implement props
  List<Object?> get props => [title, description, filedByEmail, filedByRollNo, resolved];

}