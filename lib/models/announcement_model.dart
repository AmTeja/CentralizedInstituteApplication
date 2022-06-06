import 'package:cloud_firestore/cloud_firestore.dart';

enum AnnouncementType { poster, tile }

class Announcement {

  final String? title;
  final String description;
  final String contactNo;
  final String contactEmail;
  final DateTime postedOn;
  final AnnouncementType type;
  final String imageUrl;

  Announcement({
      this.title,
      required this.description,
      required this.contactNo,
      required this.contactEmail,
      required this.postedOn,
      required this.type,
      required this.imageUrl
  });

  factory Announcement.fromSnapshot(DocumentSnapshot snapshot) {
    return Announcement(
        description: snapshot['description'],
        contactNo: snapshot['contactNo'],
        contactEmail: snapshot['contactEmail'],
        postedOn: (snapshot['postedOn'] as Timestamp).toDate(),
        imageUrl: snapshot['imageUrl'],
        title: snapshot['announcementType'].toString().toLowerCase() == "poster" ? "" : snapshot['title'] ?? "",
        type: snapshot['announcementType'].toString().toLowerCase() == "poster"
            ? AnnouncementType.poster
            : AnnouncementType.tile
    );
  }


}