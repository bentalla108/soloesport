import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/reservation.dart';

class ReservationModel extends Reservation {
  const ReservationModel({
    required String id,
    required String userId,
    required DateTime date,
    required DateTime timeSlot,
    required String equipmentType,
    required int quantity,
    required int hours,
    required double totalPrice,
    required String status,
    required DateTime createdAt,
  }) : super(
    id: id,
    userId: userId,
    date: date,
    timeSlot: timeSlot,
    equipmentType: equipmentType,
    quantity: quantity,
    hours: hours,
    totalPrice: totalPrice,
    status: status,
    createdAt: createdAt,
  );

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      id: json['id'],
      userId: json['userId'],
      date: (json['date'] as Timestamp).toDate(),
      timeSlot: (json['timeSlot'] as Timestamp).toDate(),
      equipmentType: json['equipmentType'],
      quantity: json['quantity'],
      hours: json['hours'],
      totalPrice: (json['totalPrice'] as num).toDouble(),
      status: json['status'],
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'date': Timestamp.fromDate(date),
      'timeSlot': Timestamp.fromDate(timeSlot),
      'equipmentType': equipmentType,
      'quantity': quantity,
      'hours': hours,
      'totalPrice': totalPrice,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
