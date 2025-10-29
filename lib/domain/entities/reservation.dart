// lib/domain/entities/reservation.dart
class Reservation {
  final String id;
  final String userId;
  final DateTime date;
  final DateTime timeSlot;
  final String equipmentType;
  final int quantity;
  final int hours;
  final int guests;
  final int totalPrice;
  final int depositPaid;
  final String status; // 'pending', 'confirmed', 'completed', 'cancelled'
  final DateTime createdAt;
  final DateTime? cancelledAt;

  Reservation({
    required this.id,
    required this.userId,
    required this.date,
    required this.timeSlot,
    required this.equipmentType,
    required this.quantity,
    required this.hours,
    required this.guests,
    required this.totalPrice,
    required this.depositPaid,
    required this.status,
    required this.createdAt,
    this.cancelledAt,
  });
}
