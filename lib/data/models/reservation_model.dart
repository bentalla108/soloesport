// lib/data/models/reservation_model.dart
import '../../domain/entities/reservation.dart';

class ReservationModel extends Reservation {
  ReservationModel({
    required String id,
    required String userId,
    required DateTime date,
    required DateTime timeSlot,
    required String equipmentType,
    required int quantity,
    required int hours,
    required int guests,
    required int totalPrice,
    required int depositPaid,
    required String status,
    required DateTime createdAt,
    DateTime? cancelledAt,
  }) : super(
         id: id,
         userId: userId,
         date: date,
         timeSlot: timeSlot,
         equipmentType: equipmentType,
         quantity: quantity,
         hours: hours,
         guests: guests,
         totalPrice: totalPrice,
         depositPaid: depositPaid,
         status: status,
         createdAt: createdAt,
         cancelledAt: cancelledAt,
       );

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      id: json['id'],
      userId: json['user_id'],
      date: DateTime.parse(json['date']),
      timeSlot: DateTime.parse(json['time_slot']),
      equipmentType: json['equipment_type'],
      quantity: json['quantity'],
      hours: json['hours'],
      guests: json['guests'],
      totalPrice: json['total_price'],
      depositPaid: json['deposit_paid'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      cancelledAt:
          json['cancelled_at'] != null
              ? DateTime.parse(json['cancelled_at'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'date': date.toIso8601String(),
      'time_slot': timeSlot.toIso8601String(),
      'equipment_type': equipmentType,
      'quantity': quantity,
      'hours': hours,
      'guests': guests,
      'total_price': totalPrice,
      'deposit_paid': depositPaid,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'cancelled_at': cancelledAt?.toIso8601String(),
    };
  }
}
