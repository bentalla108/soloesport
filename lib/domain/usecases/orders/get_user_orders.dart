// lib/domain/usecases/orders/get_user_orders.dart
import 'package:dartz/dartz.dart' hide Order;
import 'package:equatable/equatable.dart';
import 'package:soloesport/domain/entities/order.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../repositories/order_repository.dart';

class GetUserOrders implements UseCase<List<Order>, GetUserOrdersParams> {
  final OrderRepository repository;

  GetUserOrders(this.repository);

  @override
  Future<Either<Failure, List<Order>>> call(GetUserOrdersParams params) {
    return repository.getUserOrders(params.userId);
  }
}

class GetUserOrdersParams extends Equatable {
  final String userId;

  const GetUserOrdersParams({required this.userId});

  @override
  List<Object> get props => [userId];
}
