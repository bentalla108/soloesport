// lib/domain/usecases/orders/cancel_order.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../repositories/order_repository.dart';

class CancelOrder implements UseCase<bool, CancelOrderParams> {
  final OrderRepository repository;

  CancelOrder(this.repository);

  @override
  Future<Either<Failure, bool>> call(CancelOrderParams params) {
    return repository.cancelOrder(params.id);
  }
}

class CancelOrderParams extends Equatable {
  final String id;

  const CancelOrderParams({required this.id});

  @override
  List<Object> get props => [id];
}
