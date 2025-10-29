// lib/data/datasources/remote/firebase_product_remote_data_source.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soloesport/core/errors/exceptions.dart';
import '../../models/product_model.dart';

abstract class FirebaseProductRemoteDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<List<ProductModel>> getProductsByCategory(String category);
  Future<ProductModel> getProductById(String id);
  Future<List<ProductModel>> getFeaturedProducts();
  Future<List<ProductModel>> searchProducts(String query);
}

class FirebaseProductRemoteDataSourceImpl implements FirebaseProductRemoteDataSource {
  final FirebaseFirestore firestore;

  FirebaseProductRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final querySnapshot = await firestore
          .collection('products')
          .orderBy('created_at', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) {
            final data = doc.data();
            data['id'] = doc.id;
            return ProductModel.fromJson(data);
          })
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(String category) async {
    try {
      final querySnapshot = await firestore
          .collection('products')
          .where('category', isEqualTo: category)
          .orderBy('created_at', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) {
            final data = doc.data();
            data['id'] = doc.id;
            return ProductModel.fromJson(data);
          })
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    try {
      final docSnapshot = await firestore
          .collection('products')
          .doc(id)
          .get();

      if (!docSnapshot.exists) {
        throw ServerException();
      }

      final data = docSnapshot.data()!;
      data['id'] = docSnapshot.id;

      return ProductModel.fromJson(data);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final querySnapshot = await firestore
          .collection('products')
          .where('is_featured', isEqualTo: true)
          .orderBy('created_at', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) {
            final data = doc.data();
            data['id'] = doc.id;
            return ProductModel.fromJson(data);
          })
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      final querySnapshot = await firestore
          .collection('products')
          .orderBy('name')
          .startAt([query])
          .endAt([query + '\uf8ff'])
          .get();

      return querySnapshot.docs
          .map((doc) {
            final data = doc.data();
            data['id'] = doc.id;
            return ProductModel.fromJson(data);
          })
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }
}
