import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Promotion extends Equatable {

  final String name;
  final String imageUrl;

  const Promotion({
    required this.name,
    required this.imageUrl
  });

  @override
  List<Object?> get props => [name, imageUrl];

  static Promotion fromSnapshot(DocumentSnapshot snapshot) {
    Promotion promotion = Promotion(
        name: snapshot['promotionName'],
        imageUrl: snapshot['imageUrl']
    );
    return promotion;
  }

  static List<Promotion> promotions = [];

}