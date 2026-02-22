import 'package:equatable/equatable.dart';
import '../../../core/models/coffee_item.dart';

sealed class ProductState extends Equatable {
  const ProductState();
  @override
  List<Object?> get props => [];
}

final class ProductLoading extends ProductState {
  final List<String> categories;
  final String selectedCategory;

  const ProductLoading({
    this.categories = const [], 
    this.selectedCategory = 'Все',
  });

  @override
  List<Object?> get props => [categories, selectedCategory];
}

final class ProductLoaded extends ProductState {
  final List<CoffeeItem> items;
  final String selectedCategory;
  final List<String> categories;

  const ProductLoaded({
    required this.items,
    required this.selectedCategory,
    required this.categories,
  });

  ProductLoaded copyWith({
    List<CoffeeItem>? items,
    String? selectedCategory,
    List<String>? categories,
  }) {
    return ProductLoaded(
      items: items ?? this.items,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object?> get props => [items, selectedCategory, categories];
}
