import 'package:cia/models/models.dart';

abstract class BasePromotionRepository {
  Stream<List<Promotion>> getAllPromotions();
}