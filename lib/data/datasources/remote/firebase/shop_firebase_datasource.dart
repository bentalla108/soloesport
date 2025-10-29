// lib/data/datasources/remote/shop_firebase_datasource.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soloesport/core/errors/failures.dart';
import 'package:soloesport/data/models/product_model.dart';
import 'package:soloesport/data/models/order_model.dart';

abstract class ShopFirebaseDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<List<ProductModel>> getProductsByCategory(String category);
  Future<ProductModel> getProductById(String id);
  Future<List<ProductModel>> getFeaturedProducts();
  Future<OrderModel> createOrder(OrderModel order);
  Future<List<OrderModel>> getUserOrders(String userId);
  Future<OrderModel> getOrderById(String id);
  Future<bool> cancelOrder(String id);
  Stream<List<ProductModel>> getProductsStream();
}

class ShopFirebaseDataSourceImpl implements ShopFirebaseDataSource {
  final FirebaseFirestore firestore;

  ShopFirebaseDataSourceImpl({required this.firestore});

  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final querySnapshot = await firestore
          .collection('products')
          .where('isAvailable', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => ProductModel.fromJson({
                ...doc.data(),
                'id': doc.id,
              }))
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(String category) async {
    try {
      if (category == 'Tous') {
        return getAllProducts();
      }

      final querySnapshot = await firestore
          .collection('products')
          .where('category', isEqualTo: category)
          .where('isAvailable', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => ProductModel.fromJson({
                ...doc.data(),
                'id': doc.id,
              }))
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    try {
      final doc = await firestore.collection('products').doc(id).get();

      if (!doc.exists) {
        throw ServerException();
      }

      return ProductModel.fromJson({
        ...doc.data()!,
        'id': doc.id,
      });
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final querySnapshot = await firestore
          .collection('products')
          .where('isFeatured', isEqualTo: true)
          .where('isAvailable', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .limit(10)
          .get();

      return querySnapshot.docs
          .map((doc) => ProductModel.fromJson({
                ...doc.data(),
                'id': doc.id,
              }))
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<OrderModel> createOrder(OrderModel order) async {
    try {
      // Vérifier la disponibilité des produits
      for (final item in order.items) {
        final product = await getProductById(item['productId']);
        if (!product.isAvailable) {
          throw ValidationException('${product.name} n\'est plus disponible');
        }
        if (product.stock < item['quantity']) {
          throw ValidationException(
            '${product.name} - stock insuffisant',
          );
        }
      }

      // Créer la commande
      final orderData = {
        'userId': order.userId,
        'items': order.items,
        'totalPrice': order.totalPrice,
        'shippingAddress': order.shippingAddress,
        'paymentMethod': order.paymentMethod,
        'status': 'pending',
        'createdAt': FieldValue.serverTimestamp(),
      };

      final docRef = await firestore.collection('orders').add(orderData);

      // Mettre à jour le stock des produits
      for (final item in order.items) {
        await firestore.collection('products').doc(item['productId']).update({
          'stock': FieldValue.increment(-item['quantity']),
        });
      }

      // Récupérer la commande créée
      final createdDoc = await docRef.get();

      return OrderModel.fromJson({
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
  Future<List<OrderModel>> getUserOrders(String userId) async {
    try {
      final querySnapshot = await firestore
          .collection('orders')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => OrderModel.fromJson({
                ...doc.data(),
                'id': doc.id,
              }))
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<OrderModel> getOrderById(String id) async {
    try {
      final doc = await firestore.collection('orders').doc(id).get();

      if (!doc.exists) {
        throw ServerException();
      }

      return OrderModel.fromJson({
        ...doc.data()!,
        'id': doc.id,
      });
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<bool> cancelOrder(String id) async {
    try {
      // Récupérer la commande
      final orderDoc = await firestore.collection('orders').doc(id).get();

      if (!orderDoc.exists) {
        throw ServerException();
      }

      final order = OrderModel.fromJson({
        ...orderDoc.data()!,
        'id': orderDoc.id,
      });

      // Vérifier que la commande peut être annulée
      if (order.status != 'pending' && order.status != 'confirmed') {
        throw ValidationException(
          'Cette commande ne peut plus être annulée',
        );
      }

      // Annuler la commande
      await firestore.collection('orders').doc(id).update({
        'status': 'cancelled',
        'cancelledAt': FieldValue.serverTimestamp(),
      });

      // Restaurer le stock des produits
      for (final item in order.items) {
        await firestore.collection('products').doc(item['productId']).update({
          'stock': FieldValue.increment(item['quantity']),
        });
      }

      return true;
    } catch (e) {
      if (e is ValidationException) {
        throw e;
      }
      throw ServerException();
    }
  }

  @override
  Stream<List<ProductModel>> getProductsStream() {
    return firestore
        .collection('products')
        .where('isAvailable', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ProductModel.fromJson({
                  ...doc.data(),
                  'id': doc.id,
                }))
            .toList());
  }
}
