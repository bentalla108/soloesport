// lib/data/models/product_model.dart
import '../../domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required String id,
    required String name,
    required String category,
    required int price,
    int? oldPrice,
    required String description,
    required String mainImage,
    List<String>? additionalImages,
    required double rating,
    required int reviews,
    required bool isNew,
    required bool isFeatured,
    List<Map<String, dynamic>>? variations,
    required int stockQuantity,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
         id: id,
         name: name,
         category: category,
         price: price,
         oldPrice: oldPrice,
         description: description,
         mainImage: mainImage,
         additionalImages: additionalImages,
         rating: rating,
         reviews: reviews,
         isNew: isNew,
         isFeatured: isFeatured,
         variations: variations,
         stockQuantity: stockQuantity,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      price: json['price'],
      oldPrice: json['old_price'],
      description: json['description'],
      mainImage: json['main_image'],
      additionalImages:
          json['additional_images'] != null
              ? List<String>.from(json['additional_images'])
              : null,
      rating: json['rating']?.toDouble() ?? 0.0,
      reviews: json['reviews'] ?? 0,
      isNew: json['is_new'] ?? false,
      isFeatured: json['is_featured'] ?? false,
      variations:
          json['variations'] != null
              ? List<Map<String, dynamic>>.from(json['variations'])
              : null,
      stockQuantity: json['stock_quantity'] ?? 0,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'price': price,
      'old_price': oldPrice,
      'description': description,
      'main_image': mainImage,
      'additional_images': additionalImages,
      'rating': rating,
      'reviews': reviews,
      'is_new': isNew,
      'is_featured': isFeatured,
      'variations': variations,
      'stock_quantity': stockQuantity,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
