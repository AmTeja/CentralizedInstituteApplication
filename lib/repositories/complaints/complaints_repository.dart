import 'package:cia/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ComplaintsRepository {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _firebaseAuth;

  ComplaintsRepository({FirebaseFirestore? firebaseFirestore, FirebaseAuth? firebaseAuth}) :
        _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Stream<List<Complaint>> get complaints {
    return _firebaseFirestore.collection('Complaints')
        .where('filedByEmail', isEqualTo:  _firebaseAuth.currentUser!.email)
        .snapshots(includeMetadataChanges: true).map((snapshot) {
      return (snapshot.docs.map((doc) => Complaint.fromSnapshot(doc))).toList();
    });
  }

  Future<void> complaint(Complaint complaint) async {
    try {
      await _firebaseFirestore.collection('Complaints').add(complaint.toMap());
    } catch (e) {
      throw Exception(e);
    }
  }

}