import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cia/models/models.dart';
import 'package:cia/repositories/repositories.dart';
import 'package:equatable/equatable.dart';

part 'promotion_event.dart';
part 'promotion_state.dart';

class PromotionBloc extends Bloc<PromotionEvent, PromotionState> {

  final PromotionRepository _promotionRepository;
  StreamSubscription? _promotionSubscription;

  PromotionBloc({required PromotionRepository promotionRepository})
      : _promotionRepository = promotionRepository,
        super(PromotionLoading()) {
    on<LoadPromotions>(_mapLoadPromotionsToState);
    on<UpdatePromotions>(_mapUpdatePromotionsToState);
  }

  void _mapLoadPromotionsToState(
      LoadPromotions event,
      Emitter<PromotionState> emit
      ) {
    _promotionSubscription?.cancel();
    _promotionSubscription = _promotionRepository.getAllPromotions()
        .listen((promotions) => add(UpdatePromotions(promotions)));
  }

  void _mapUpdatePromotionsToState(
      UpdatePromotions event,
      Emitter<PromotionState> emit,
      ) {
    emit(PromotionLoaded(promotions: event.promotions));
  }
}
