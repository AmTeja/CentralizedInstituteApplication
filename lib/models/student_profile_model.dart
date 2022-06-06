import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class StudentProfile extends Equatable {

  final String firstName;
  final String? middleName;
  final String? lastName;
  final String rollNo;
  final Education? education;
  final Bio? bio;
  final String? phoneNo;
  final String? email;
  final String? docID;

  const StudentProfile({
    required this.firstName,
    this.middleName,
    this.lastName,
    required this.rollNo,
    this.education,
    this.phoneNo,
    this.email,
    this.bio,
    this.docID
  });

  static const empty = StudentProfile(firstName: '', rollNo: '');

  bool get isEmpty => this == StudentProfile.empty;
  bool get isNotEmpty => this != StudentProfile.empty;

  @override
  List<Object?> get props => [firstName, middleName, lastName];

  static StudentProfile fromSnapshot(DocumentSnapshot snap) {
    Map<String, dynamic> nameMap = snap['name'];
    StudentProfile studentProfile = StudentProfile(
        firstName: nameMap['first'],
        middleName: nameMap['middle'],
        lastName: nameMap['last'],
        rollNo: snap['rollNo'],
        phoneNo: snap['phoneNo'],
        email: snap['email'],
        bio: Bio.fromMap(snap['bio'] as Map<String, dynamic>),
        docID: snap.id,
        education: Education.fromMap(snap['education'] as Map<String, dynamic>)
    );

    return studentProfile;
  }

}

class Bio {
  final String? aadharNo;
  final String? address;
  final String? caste;
  final DateTime? dateOfBirth;
  final String? gender;
  final String? nationality;
  final String? religion;

  Bio({
    this.aadharNo,
      this.address,
      this.caste,
      this.dateOfBirth,
      this.gender,
      this.nationality,
      this.religion
      });
  
  static Bio fromMap(Map<String, dynamic> json) {
    Bio bio = Bio(
      aadharNo: json['aadharNo'],
      address: json['address'],
      caste: json['caste'],
      dateOfBirth: (json['dob'] as Timestamp).toDate(),
      gender: json['gender'],
      nationality: json['nationality'],
      religion: json['religion']
    );
    return bio;
  }

  Map<String, dynamic> toMap() => {
    "aadharNo" : aadharNo,
    "address" : address,
    "caste" : caste,
    "dateOfBirth" : dateOfBirth,
    "gender" : gender,
    "nationality" : nationality,
    "religion" : religion
  };

}


class Education {
  final String branchCode;
  final String branchName;
  final String section;

  Education({
    required this.branchCode,
    required this.branchName,
    required this.section
  });

  static Education fromMap(Map<String, dynamic> json) {
    Education education = Education(
        branchCode: json['branchCode'],
        branchName: json['branchName'],
        section: json['section']
    );
    return education;
  }

  Map<String, dynamic> toMap() => {
    'branchName' : branchName,
    'branchCode' : branchCode,
    'section' : section
  };
}