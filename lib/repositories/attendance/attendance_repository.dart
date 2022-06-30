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

    var studentDoc = await FirebaseFirestore.instance.collection('StudentProfiles').where('email', isEqualTo: _firebaseAuth.currentUser!.email).get();
    String rollNo = studentDoc.docs[0].get('rollNo');
    DateTime now = DateTime.now();
    DateTime latest = DateTime(now.year, now.month, now.day, 23, 59, 59);
    DateTime last = latest.subtract(const Duration(days: 7, hours: 23, minutes: 59, seconds: 59));

    CollectionReference attendanceRef = _firebaseFirestore.collection('Attendances');
    var docId = await attendanceRef.where('rollNo', isEqualTo: rollNo).get().then((docs){
      return docs.docs[0].id;
    });
    yield* attendanceRef.doc(docId).collection('AttendanceSessions')
        .where('startTime',
        isGreaterThanOrEqualTo:  last,
        isLessThanOrEqualTo: latest)
        .orderBy('startTime').limit(42).snapshots().map((sessionsSnaps) {
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