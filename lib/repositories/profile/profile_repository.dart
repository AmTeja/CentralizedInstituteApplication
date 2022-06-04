import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cia/models/models.dart';

class ProfileRepository {

  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _firebaseAuth;

  ProfileRepository({FirebaseFirestore? firebaseFirestore, FirebaseAuth? firebaseAuth}) :
      _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Stream<StudentProfile> get profile {
     return _firebaseFirestore.collection('StudentProfiles')
         .where('email', isEqualTo:  _firebaseAuth.currentUser!.email)
         .snapshots(includeMetadataChanges: true).map((snapshot) {
           return (snapshot.docs.map((doc) => StudentProfile.fromSnapshot(doc))).toList()[0];
     });
  }

}