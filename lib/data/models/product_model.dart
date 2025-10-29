import '../../domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required String id,
    required String name,
    required String category,
    required double price,
    required String description,
    required String mainImage,
    required int stockQuantity,
    bool isFeatured = false,
    bool isNew = false,
    double rating = 0.0,
    int reviews = 0,
  }) : super(
    id: id,
    name: name,
    category: category,
    price: price,
    description: description,
    mainImage: mainImage,
    stockQuantity: stockQuantity,
    isFeatured: isFeatured,
    isNew: isNew,
    rating: rating,
    reviews: reviews,
  );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      mainImage: json['mainImage'],
      stockQuantity: json['stockQuantity'],
      isFeatured: json['isFeatured'] ?? false,
      isNew: json['isNew'] ?? false,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviews: json['reviews'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'price': price,
      'description': description,
      'mainImage': mainImage,
      'stockQuantity': stockQuantity,
      'isFeatured': isFeatured,
      'isNew': isNew,
      'rating': rating,
      'reviews': reviews,
    };
  }
}
