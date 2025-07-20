// lib/data/datasources/local/product_local_data_source.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soloesport/core/errors/failures.dart';
import 'package:soloesport/data/models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getCachedProducts();
  Future<List<ProductModel>> getCachedProductsByCategory(String category);
  Future<ProductModel> getProductById(String id);
  Future<List<ProductModel>> getCachedFeaturedProducts();
  Future<void> cacheProducts(List<ProductModel> products);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProductLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<ProductModel>> getCachedProducts() {
    final jsonString = sharedPreferences.getString('CACHED_PRODUCTS');
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return Future.value(
        jsonList.map((json) => ProductModel.fromJson(json)).toList(),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<List<ProductModel>> getCachedProductsByCategory(
    String category,
  ) async {
    try {
      final allProducts = await getCachedProducts();
      return allProducts
          .where((product) => product.category == category)
          .toList();
    } on CacheException {
      throw CacheException();
    }
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    try {
      final allProducts = await getCachedProducts();
      final product = allProducts.firstWhere((p) => p.id == id);
      return product;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<ProductModel>> getCachedFeaturedProducts() async {
    try {
      final allProducts = await getCachedProducts();
      return allProducts.where((product) => product.isFeatured).toList();
    } on CacheException {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheProducts(List<ProductModel> products) {
    return sharedPreferences.setString(
      'CACHED_PRODUCTS',
      json.encode(products.map((product) => product.toJson()).toList()),
    );
  }
}
