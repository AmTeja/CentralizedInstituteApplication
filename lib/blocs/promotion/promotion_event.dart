part of 'promotion_bloc.dart';

abstract class PromotionEvent extends Equatable {
  const PromotionEvent();

  @override
  List<Object> get props => [];
}

class LoadPromotions extends PromotionEvent {}

class UpdatePromotions extends PromotionEvent {
  final List<Promotion> promotions;

  const UpdatePromotions(this.promotions);

  @override
  List<Object> get props => [promotions];
}
