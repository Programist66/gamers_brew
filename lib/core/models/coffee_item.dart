import 'package:equatable/equatable.dart';

class CoffeeItem extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;

  const CoffeeItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl, required this.category,
  });

  @override
  List<Object?> get props => [id, name, price, imageUrl, description, category];
}