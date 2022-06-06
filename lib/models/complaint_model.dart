
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Complaint extends Equatable {

  const Complaint({
    this.resolved = false,
    required this.filedByEmail,
    required this.title,
    required this.description,
    required this.filedOn,
  });

  final bool resolved;
  final String filedByEmail;
  final String title;
  final String description;
  final DateTime filedOn;

  factory Complaint.fromSnapshot(DocumentSnapshot snapshot) => Complaint(
      resolved: snapshot['resolved'],
      filedByEmail: snapshot['filedByEmail'],
      title: snapshot['title'],
      description: snapshot['description'],
      filedOn: (snapshot['filedOn'] as Timestamp).toDate()
  );

  Map<String, dynamic> toMap() => {
    "resolved" : resolved,
    "filedByEmail" : filedByEmail,
    "title" : title,
    "description" : description,
    "filedOn" : filedOn,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [title, description, filedByEmail, filedOn ,resolved];

}