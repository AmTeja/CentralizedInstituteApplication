import 'package:cia/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AnnouncementsRepository {

  final FirebaseFirestore _firebaseFirestore;

    AnnouncementsRepository({
      FirebaseFirestore? firebaseFirestore,
    }) : _firebaseFirestore = firebaseFirestore?? FirebaseFirestore.instance;

  Stream<List<Announcement>> get announcement async* {
    DateTime now = DateTime.now();
    DateTime latest = DateTime(now.year, now.month, now.day, 23, 59, 59);
    DateTime last = latest.subtract(const Duration(days: 7, hours: 23, minutes: 59, seconds: 59));

    CollectionReference announcementsRef = _firebaseFirestore.collection('Announcements');
    yield* announcementsRef
        .where('postedOn',
        isGreaterThanOrEqualTo:  last,
        isLessThanOrEqualTo: latest)
        .orderBy('postedOn').limit(20).snapshots().map((announcementSnaps) {
          print(announcementSnaps.docs.length);
      return announcementSnaps.docs.map((e) {
        return Announcement.fromSnapshot(e);
      }).toList();
    });
  }
}