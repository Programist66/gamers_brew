import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamers_brew/features/home/bloc/product_event.dart';
import 'package:gamers_brew/features/home/bloc/product_state.dart';
import '../repository/coffee_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final CoffeeRepository coffeeRepository;

  ProductBloc({required this.coffeeRepository})
    : super(const ProductLoading()) {
    on<LoadProductData>(_onLoadProductData);
    on<ChangeCategory>(_onChangeCategory);
  }

  Future<void> _onLoadProductData(
    LoadProductData event,
    Emitter<ProductState> emit,
  ) async {
    emit(const ProductLoading());
    try {
      final items = await coffeeRepository.getCatalog();
      final categories = await coffeeRepository.getCategories();
      emit(
        ProductLoaded(
          items: items,
          selectedCategory: 'Все',
          categories: categories,
        ),
      );
    } catch (e) {
      log("Error initial loading: $e");
    }
  }

  void _onChangeCategory(
    ChangeCategory event,
    Emitter<ProductState> emit,
  ) async {
    List<String> currentCategories = [];
    if (state is ProductLoaded) {
      currentCategories = (state as ProductLoaded).categories;
    } else if (state is ProductLoading) {
      currentCategories = (state as ProductLoading).categories;
    }

    emit(
      ProductLoading(
        categories: currentCategories,
        selectedCategory: event.category,
      ),
    );

    try {
      final items = await coffeeRepository.getCatalog(
        event.category == 'Все' ? 'Все' : event.category,
      );

      emit(
        ProductLoaded(
          items: items,
          selectedCategory: event.category,
          categories: currentCategories,
        ),
      );
    } catch (e) {
      log("Error loading category ${event.category}: $e");
    }
  }
}
