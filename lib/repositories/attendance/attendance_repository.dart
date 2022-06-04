import 'package:cia/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AttendanceRepository {

  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _firebaseAuth;

  AttendanceRepository({
    FirebaseFirestore? firebaseFirestore,
    FirebaseAuth? firebaseAuth
    }) :
      _firebaseFirestore = firebaseFirestore?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Stream<List<Session>> get attendance async* {
    CollectionReference attendanceRef = _firebaseFirestore.collection('Attendances');
    var docId = await attendanceRef.where('email', isEqualTo: _firebaseAuth.currentUser!.email).get().then((docs){
      return docs.docs[0].id;
    });
    yield* attendanceRef.doc(docId).collection('AttendanceSessions')
        .where('startTime', isLessThanOrEqualTo: DateTime.now()).orderBy('startTime').limit(42).snapshots().map((sessionsSnaps) {
      return sessionsSnaps.docs.map((e) {
        return Session.fromSnapshot(e);
      }).toList();
    });
  }

  Stream<AttendanceProfile> get attendanceProfile  {
    try {
      CollectionReference attendanceRef = _firebaseFirestore.collection('Attendances');
      return attendanceRef.where('email', isEqualTo: _firebaseAuth.currentUser!.email).snapshots().map((profileSnaps) {
        return profileSnaps.docs.map((e) => AttendanceProfile.fromSnap(e)).toList()[0];
      });
    } catch(e) {
      print(e);
      throw Exception(e);
    }
  }
}