// lib/domain/entities/product.dart
class Product {
  final String id;
  final String name;
  final String category;
  final int price;
  final int? oldPrice;
  final String description;
  final String mainImage;
  final List<String>? additionalImages;
  final double rating;
  final int reviews;
  final bool isNew;
  final bool isFeatured;
  final List<Map<String, dynamic>>? variations;
  final int stockQuantity;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    this.oldPrice,
    required this.description,
    required this.mainImage,
    this.additionalImages,
    required this.rating,
    required this.reviews,
    required this.isNew,
    required this.isFeatured,
    this.variations,
    required this.stockQuantity,
    required this.createdAt,
    required this.updatedAt,
  });
}
