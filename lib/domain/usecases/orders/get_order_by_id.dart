// lib/domain/usecases/orders/get_order_by_id.dart
import 'package:dartz/dartz.dart' hide Order;
import 'package:equatable/equatable.dart';
import '../../entities/order.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../repositories/order_repository.dart';

class GetOrderById implements UseCase<Order, GetOrderByIdParams> {
  final OrderRepository repository;

  GetOrderById(this.repository);

  @override
  Future<Either<Failure, Order>> call(GetOrderByIdParams params) {
    return repository.getOrderById(params.id);
  }
}

class GetOrderByIdParams extends Equatable {
  final String id;

  const GetOrderByIdParams({required this.id});

  @override
  List<Object> get props => [id];
}
