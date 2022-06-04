part of 'promotion_bloc.dart';

abstract class PromotionState extends Equatable {
  const PromotionState();

  @override
  List<Object> get props => [];
}

class PromotionLoading extends PromotionState {}

class PromotionLoaded extends PromotionState {
  final List<Promotion> promotions;

  const PromotionLoaded({this.promotions = const <Promotion>[]});

  @override
  List<Object> get props => [promotions];
}
