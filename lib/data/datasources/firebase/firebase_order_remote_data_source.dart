// lib/data/datasources/remote/firebase_order_remote_data_source.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soloesport/core/errors/exceptions.dart';
import '../../models/order_model.dart';

abstract class FirebaseOrderRemoteDataSource {
  Future<List<OrderModel>> getUserOrders(String userId);
  Future<OrderModel> getOrderById(String id);
  Future<OrderModel> createOrder(OrderModel order);
  Future<bool> cancelOrder(String id);
}

class FirebaseOrderRemoteDataSourceImpl implements FirebaseOrderRemoteDataSource {
  final FirebaseFirestore firestore;

  FirebaseOrderRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<OrderModel>> getUserOrders(String userId) async {
    try {
      final querySnapshot = await firestore
          .collection('orders')
          .where('user_id', isEqualTo: userId)
          .orderBy('created_at', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) {
            final data = doc.data();
            data['id'] = doc.id;
            return OrderModel.fromJson(data);
          })
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<OrderModel> getOrderById(String id) async {
    try {
      final docSnapshot = await firestore
          .collection('orders')
          .doc(id)
          .get();

      if (!docSnapshot.exists) {
        throw ServerException();
      }

      final data = docSnapshot.data()!;
      data['id'] = docSnapshot.id;

      return OrderModel.fromJson(data);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<OrderModel> createOrder(OrderModel order) async {
    try {
      final orderData = order.toJson();
      orderData['created_at'] = FieldValue.serverTimestamp();
      orderData['status'] = 'pending';

      final docRef = await firestore
          .collection('orders')
          .add(orderData);

      final createdDoc = await docRef.get();
      final createdData = createdDoc.data()!;
      createdData['id'] = createdDoc.id;

      return OrderModel.fromJson(createdData);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<bool> cancelOrder(String id) async {
    try {
      await firestore
          .collection('orders')
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
}
