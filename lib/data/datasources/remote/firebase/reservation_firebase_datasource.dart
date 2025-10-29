// lib/data/datasources/remote/reservation_firebase_datasource.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soloesport/core/errors/failures.dart';
import 'package:soloesport/data/models/reservation_model.dart';

abstract class ReservationFirebaseDataSource {
  Future<List<ReservationModel>> getUserReservations(String userId);
  Future<ReservationModel> createReservation(ReservationModel reservation);
  Future<bool> cancelReservation(String id);
  Future<List<DateTime>> getAvailableTimeSlots(
    DateTime date,
    String equipmentType,
    int quantity,
  );
  Stream<List<ReservationModel>> getUserReservationsStream(String userId);
}

class ReservationFirebaseDataSourceImpl
    implements ReservationFirebaseDataSource {
  final FirebaseFirestore firestore;

  ReservationFirebaseDataSourceImpl({required this.firestore});

  @override
  Future<List<ReservationModel>> getUserReservations(String userId) async {
    try {
      final querySnapshot = await firestore
          .collection('reservations')
          .where('userId', isEqualTo: userId)
          .orderBy('reservationDate', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => ReservationModel.fromJson({
                ...doc.data(),
                'id': doc.id,
              }))
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<ReservationModel> createReservation(
    ReservationModel reservation,
  ) async {
    try {
      // Vérifier la disponibilité
      final isAvailable = await _checkAvailability(
        reservation.reservationDate,
        reservation.timeSlot,
        reservation.equipmentType,
        reservation.quantity,
      );

      if (!isAvailable) {
        throw ValidationException(
          'Cet créneau horaire n\'est plus disponible',
        );
      }

      // Créer la réservation
      final reservationData = {
        'userId': reservation.userId,
        'reservationDate': Timestamp.fromDate(reservation.reservationDate),
        'timeSlot': Timestamp.fromDate(reservation.timeSlot),
        'equipmentType': reservation.equipmentType,
        'quantity': reservation.quantity,
        'duration': reservation.duration,
        'numberOfGuests': reservation.numberOfGuests,
        'totalPrice': reservation.totalPrice,
        'paymentMethod': reservation.paymentMethod,
        'status': 'confirmed',
        'qrCode': reservation.qrCode,
        'createdAt': FieldValue.serverTimestamp(),
      };

      final docRef = await firestore
          .collection('reservations')
          .add(reservationData);

      // Récupérer la réservation créée
      final createdDoc = await docRef.get();

      return ReservationModel.fromJson({
        ...createdDoc.data()!,
        'id': createdDoc.id,
      });
    } catch (e) {
      if (e is ValidationException) {
        throw e;
      }
      throw ServerException();
    }
  }

  @override
  Future<bool> cancelReservation(String id) async {
    try {
      // Vérifier que la réservation existe
      final doc = await firestore.collection('reservations').doc(id).get();

      if (!doc.exists) {
        throw ServerException();
      }

      // Mettre à jour le statut
      await firestore.collection('reservations').doc(id).update({
        'status': 'cancelled',
        'cancelledAt': FieldValue.serverTimestamp(),
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
      // Définir les horaires possibles (10h à 22h, toutes les 2 heures)
      final allTimeSlots = <DateTime>[
        DateTime(date.year, date.month, date.day, 10, 0),
        DateTime(date.year, date.month, date.day, 12, 0),
        DateTime(date.year, date.month, date.day, 14, 0),
        DateTime(date.year, date.month, date.day, 16, 0),
        DateTime(date.year, date.month, date.day, 18, 0),
        DateTime(date.year, date.month, date.day, 20, 0),
      ];

      // Récupérer les réservations pour cette date
      final startOfDay = DateTime(date.year, date.month, date.day);
      final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

      final querySnapshot = await firestore
          .collection('reservations')
          .where('reservationDate',
              isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
          .where('reservationDate',
              isLessThanOrEqualTo: Timestamp.fromDate(endOfDay))
          .where('equipmentType', isEqualTo: equipmentType)
          .where('status', isEqualTo: 'confirmed')
          .get();

      // Calculer la capacité disponible pour chaque créneau
      final Map<DateTime, int> bookedQuantities = {};
      for (final slot in allTimeSlots) {
        bookedQuantities[slot] = 0;
      }

      for (final doc in querySnapshot.docs) {
        final reservation = ReservationModel.fromJson({
          ...doc.data(),
          'id': doc.id,
        });

        // Trouver le créneau correspondant
        final matchingSlot = allTimeSlots.firstWhere(
          (slot) => slot.isAtSameMomentAs(reservation.timeSlot),
          orElse: () => reservation.timeSlot,
        );

        bookedQuantities[matchingSlot] =
            (bookedQuantities[matchingSlot] ?? 0) + reservation.quantity;
      }

      // Capacité totale selon le type d'équipement
      final maxCapacity = _getMaxCapacity(equipmentType);

      // Filtrer les créneaux disponibles
      final availableSlots = allTimeSlots.where((slot) {
        final booked = bookedQuantities[slot] ?? 0;
        final available = maxCapacity - booked;
        return available >= quantity && slot.isAfter(DateTime.now());
      }).toList();

      return availableSlots;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Stream<List<ReservationModel>> getUserReservationsStream(String userId) {
    return firestore
        .collection('reservations')
        .where('userId', isEqualTo: userId)
        .orderBy('reservationDate', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ReservationModel.fromJson({
                  ...doc.data(),
                  'id': doc.id,
                }))
            .toList());
  }

  // Méthodes utilitaires privées

  Future<bool> _checkAvailability(
    DateTime date,
    DateTime timeSlot,
    String equipmentType,
    int quantity,
  ) async {
    try {
      final querySnapshot = await firestore
          .collection('reservations')
          .where('reservationDate', isEqualTo: Timestamp.fromDate(date))
          .where('timeSlot', isEqualTo: Timestamp.fromDate(timeSlot))
          .where('equipmentType', isEqualTo: equipmentType)
          .where('status', isEqualTo: 'confirmed')
          .get();

      int totalBooked = 0;
      for (final doc in querySnapshot.docs) {
        final reservation = ReservationModel.fromJson({
          ...doc.data(),
          'id': doc.id,
        });
        totalBooked += reservation.quantity;
      }

      final maxCapacity = _getMaxCapacity(equipmentType);
      final available = maxCapacity - totalBooked;

      return available >= quantity;
    } catch (e) {
      return false;
    }
  }

  int _getMaxCapacity(String equipmentType) {
    switch (equipmentType) {
      case 'PC Gaming':
        return 20; // 20 PC Gaming disponibles
      case 'Xbox Series X':
        return 10; // 10 Xbox disponibles
      case 'PS5':
        return 10; // 10 PS5 disponibles
      default:
        return 0;
    }
  }
}
