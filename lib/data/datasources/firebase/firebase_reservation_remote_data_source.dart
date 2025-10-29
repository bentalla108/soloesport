// lib/data/datasources/remote/firebase_reservation_remote_data_source.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soloesport/core/errors/exceptions.dart';
import '../../models/reservation_model.dart';

abstract class FirebaseReservationRemoteDataSource {
  Future<List<ReservationModel>> getUserReservations(String userId);
  Future<ReservationModel> getReservationById(String id);
  Future<ReservationModel> createReservation(ReservationModel reservation);
  Future<bool> cancelReservation(String id);
  Future<List<DateTime>> getAvailableTimeSlots(
    DateTime date,
    String equipmentType,
    int quantity,
  );
}

class FirebaseReservationRemoteDataSourceImpl implements FirebaseReservationRemoteDataSource {
  final FirebaseFirestore firestore;

  FirebaseReservationRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<ReservationModel>> getUserReservations(String userId) async {
    try {
      final querySnapshot = await firestore
          .collection('reservations')
          .where('user_id', isEqualTo: userId)
          .orderBy('date', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) {
            final data = doc.data();
            data['id'] = doc.id;
            return ReservationModel.fromJson(data);
          })
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<ReservationModel> getReservationById(String id) async {
    try {
      final docSnapshot = await firestore
          .collection('reservations')
          .doc(id)
          .get();

      if (!docSnapshot.exists) {
        throw ServerException();
      }

      final data = docSnapshot.data()!;
      data['id'] = docSnapshot.id;

      return ReservationModel.fromJson(data);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<ReservationModel> createReservation(ReservationModel reservation) async {
    try {
      // Vérifier la disponibilité
      final isAvailable = await _checkAvailability(
        reservation.date,
        reservation.timeSlot,
        reservation.equipmentType,
        reservation.quantity,
      );

      if (!isAvailable) {
        throw ValidationException('Créneau horaire non disponible');
      }

      final reservationData = reservation.toJson();
      reservationData['created_at'] = FieldValue.serverTimestamp();
      reservationData['status'] = 'pending';

      final docRef = await firestore
          .collection('reservations')
          .add(reservationData);

      final createdDoc = await docRef.get();
      final createdData = createdDoc.data()!;
      createdData['id'] = createdDoc.id;

      return ReservationModel.fromJson(createdData);
    } catch (e) {
      if (e is ValidationException) rethrow;
      throw ServerException();
    }
  }

  @override
  Future<bool> cancelReservation(String id) async {
    try {
      await firestore
          .collection('reservations')
          .doc(id)
          .update({
        'status': 'cancelled',
        'cancelled_at': FieldValue.serverTimestamp(),
      });

      return true;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<DateTime>> getAvailableTimeSlots(
    DateTime date,
    String equipmentType,
    int quantity,
  ) async {
    try {
      final startOfDay = DateTime(date.year, date.month, date.day);
      final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

      // Récupérer les réservations existantes pour cette date
      final querySnapshot = await firestore
          .collection('reservations')
          .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
          .where('date', isLessThanOrEqualTo: Timestamp.fromDate(endOfDay))
          .where('equipment_type', isEqualTo: equipmentType)
          .where('status', whereIn: ['pending', 'confirmed'])
          .get();

      // Créneaux disponibles (10h à 22h par tranches de 2h)
      final availableSlots = <DateTime>[
        DateTime(date.year, date.month, date.day, 10, 0),
        DateTime(date.year, date.month, date.day, 12, 0),
        DateTime(date.year, date.month, date.day, 14, 0),
        DateTime(date.year, date.month, date.day, 16, 0),
        DateTime(date.year, date.month, date.day, 18, 0),
        DateTime(date.year, date.month, date.day, 20, 0),
      ];

      // Compter les équipements réservés par créneau
      final reservedCountBySlot = <String, int>{};

      for (final doc in querySnapshot.docs) {
        final data = doc.data();
        final timeSlot = (data['time_slot'] as Timestamp).toDate();
        final reservedQuantity = data['quantity'] as int;
        final slotKey = timeSlot.toString();

        reservedCountBySlot[slotKey] = 
            (reservedCountBySlot[slotKey] ?? 0) + reservedQuantity;
      }

      // Capacité totale par équipement (exemple: 10 PC, 5 consoles)
      final totalCapacity = _getEquipmentCapacity(equipmentType);

      // Filtrer les créneaux disponibles
      return availableSlots.where((slot) {
        final slotKey = slot.toString();
        final reservedCount = reservedCountBySlot[slotKey] ?? 0;
        return (reservedCount + quantity) <= totalCapacity;
      }).toList();
    } catch (e) {
      throw ServerException();
    }
  }

  Future<bool> _checkAvailability(
    DateTime date,
    DateTime timeSlot,
    String equipmentType,
    int quantity,
  ) async {
    try {
      final availableSlots = await getAvailableTimeSlots(
        date,
        equipmentType,
        quantity,
      );

      return availableSlots.any((slot) => 
        slot.year == timeSlot.year &&
        slot.month == timeSlot.month &&
        slot.day == timeSlot.day &&
        slot.hour == timeSlot.hour
      );
    } catch (e) {
      return false;
    }
  }

  int _getEquipmentCapacity(String equipmentType) {
    switch (equipmentType) {
      case 'PC Gaming':
        return 10;
      case 'PS5':
        return 5;
      case 'Xbox Series X':
        return 5;
      default:
        return 5;
    }
  }
}
