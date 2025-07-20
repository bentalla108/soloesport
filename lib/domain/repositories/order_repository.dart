// lib/domain/repositories/order_repository.dart
import 'package:dartz/dartz.dart' hide Order;
import '../entities/order.dart' show Order;
import '../../core/errors/failures.dart';

abstract class OrderRepository {
  Future<Either<Failure, List<Order>>> getUserOrders(String userId);
  Future<Either<Failure, Order>> getOrderById(String id);
  Future<Either<Failure, Order>> createOrder(Order order);
  Future<Either<Failure, bool>> cancelOrder(String id);
}
