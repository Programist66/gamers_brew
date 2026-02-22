import 'package:equatable/equatable.dart';

enum OrderStatus { cooking, ready, completed }

class OrderModel extends Equatable {
  final String id;
  final DateTime createdAt;
  final double totalAmount;
  final OrderStatus status;
  final List<String> itemsSummary;

  const OrderModel({
    required this.id,
    required this.createdAt,
    required this.totalAmount,
    required this.status,
    required this.itemsSummary,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      totalAmount: (json['total'] as num).toDouble(),
      status: OrderStatus.values.firstWhere((e) => e.name == json['status']),
      itemsSummary: List<String>.from(json['items_summary']),
    );
  }

  @override
  List<Object?> get props => [id, status, totalAmount];
}