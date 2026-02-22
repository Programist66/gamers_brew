import 'package:equatable/equatable.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();
  @override
  List<Object?> get props => [];
}

class LoadProductData extends ProductEvent {}

class ChangeCategory extends ProductEvent {
  final String category;
  const ChangeCategory(this.category);

  @override
  List<Object?> get props => [category];
}