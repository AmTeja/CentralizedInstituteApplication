import 'package:cia/models/promotion_model.dart';
import 'package:cia/repositories/homepage/base_promotion_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PromotionRepository extends BasePromotionRepository{

  final FirebaseFirestore _firebaseFirestore;

  PromotionRepository({FirebaseFirestore? firebaseFirestore})
      :  _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Promotion>> getAllPromotions() {
    return _firebaseFirestore.collection('Promotions')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Promotion.fromSnapshot(doc)).toList();
    });
  }

}