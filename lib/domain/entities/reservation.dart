import 'package:equatable/equatable.dart';

class Reservation extends Equatable {
  final String id;
  final String userId;
  final DateTime date;
  final DateTime timeSlot;
  final String equipmentType;
  final int quantity;
  final int hours;
  final double totalPrice;
  final String status;
  final DateTime createdAt;

  const Reservation({
    required this.id,
    required this.userId,
    required this.date,
    required this.timeSlot,
    required this.equipmentType,
    required this.quantity,
    required this.hours,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    date,
    timeSlot,
    equipmentType,
    quantity,
    hours,
    totalPrice,
    status,
    createdAt,
  ];
}
