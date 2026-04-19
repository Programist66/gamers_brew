import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/coffee_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CoffeeRepository coffeeRepository;

  HomeBloc({required this.coffeeRepository}) : super(HomeLoading()) {
    on<LoadHomeData>(_onLoadHomeData);
  }

  Future<void> _onLoadHomeData(
    LoadHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      var images = await coffeeRepository.getCarouselImages();
      emit(HomeLoaded(carouselImages: images));
    } catch (e) {
      log(e.toString());
    }
  }
}
