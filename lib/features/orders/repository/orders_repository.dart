import 'package:gamers_brew/core/network/dio_client.dart';
import 'package:gamers_brew/features/orders/model/order_model.dart';

class OrdersRepository {
  final DioClient _client;
  OrdersRepository(this._client);

  Future<List<OrderModel>> fetchOrders() async {
    await Future.delayed(const Duration(seconds: 1));
    
    return [
      OrderModel(
        id: '8821',
        createdAt: DateTime.now(),
        totalAmount: 850,
        status: OrderStatus.cooking,
        itemsSummary: ['2x Капучино', '1x Донат'],
      ),
      OrderModel(
        id: '8821',
        createdAt: DateTime.now(),
        totalAmount: 850,
        status: OrderStatus.cooking,
        itemsSummary: ['2x Капучино', '1x Донат'],
      ),
      OrderModel(
        id: '8821',
        createdAt: DateTime.now(),
        totalAmount: 850,
        status: OrderStatus.cooking,
        itemsSummary: ['2x Капучино', '1x Донат'],
      ),
      OrderModel(
        id: '8821',
        createdAt: DateTime.now(),
        totalAmount: 850,
        status: OrderStatus.cooking,
        itemsSummary: ['2x Капучино', '1x Донат'],
      ),
      OrderModel(
        id: '8821',
        createdAt: DateTime.now(),
        totalAmount: 850,
        status: OrderStatus.cooking,
        itemsSummary: ['2x Капучино', '1x Донат'],
      ),
      OrderModel(
        id: '8821',
        createdAt: DateTime.now(),
        totalAmount: 850,
        status: OrderStatus.cooking,
        itemsSummary: ['2x Капучино', '1x Донат'],
      ),
      OrderModel(
        id: '8821',
        createdAt: DateTime.now(),
        totalAmount: 850,
        status: OrderStatus.cooking,
        itemsSummary: ['2x Капучино', '1x Донат'],
      ),
      OrderModel(
        id: '8821',
        createdAt: DateTime.now(),
        totalAmount: 850,
        status: OrderStatus.cooking,
        itemsSummary: ['2x Капучино', '1x Донат'],
      ),
      OrderModel(
        id: '8821',
        createdAt: DateTime.now(),
        totalAmount: 850,
        status: OrderStatus.cooking,
        itemsSummary: ['2x Капучино', '1x Донат'],
      ),OrderModel(
        id: '8821',
        createdAt: DateTime.now(),
        totalAmount: 850,
        status: OrderStatus.cooking,
        itemsSummary: ['2x Капучино', '1x Донат'],
      ),
      OrderModel(
        id: '8821',
        createdAt: DateTime.now(),
        totalAmount: 850,
        status: OrderStatus.cooking,
        itemsSummary: ['2x Капучино', '1x Донат'],
      ),
      OrderModel(
        id: '8821',
        createdAt: DateTime.now(),
        totalAmount: 850,
        status: OrderStatus.cooking,
        itemsSummary: ['2x Капучино', '1x Донат'],
      ),
      OrderModel(
        id: '8821',
        createdAt: DateTime.now(),
        totalAmount: 850,
        status: OrderStatus.cooking,
        itemsSummary: ['2x Капучино', '1x Донат'],
      ),
      OrderModel(
        id: '8821',
        createdAt: DateTime.now(),
        totalAmount: 850,
        status: OrderStatus.cooking,
        itemsSummary: ['2x Капучино', '1x Донат'],
      ),
      OrderModel(
        id: '8821',
        createdAt: DateTime.now(),
        totalAmount: 850,
        status: OrderStatus.cooking,
        itemsSummary: ['2x Капучино', '1x Донат'],
      ),
      OrderModel(
        id: '8821',
        createdAt: DateTime.now(),
        totalAmount: 850,
        status: OrderStatus.cooking,
        itemsSummary: ['2x Капучино', '1x Донат'],
      ),
    ];
  }
}