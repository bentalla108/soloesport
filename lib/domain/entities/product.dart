import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String category;
  final double price;
  final String description;
  final String mainImage;
  final int stockQuantity;
  final bool isFeatured;
  final bool isNew;
  final double rating;
  final int reviews;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.mainImage,
    required this.stockQuantity,
    this.isFeatured = false,
    this.isNew = false,
    this.rating = 0.0,
    this.reviews = 0,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    category,
    price,
    description,
    mainImage,
    stockQuantity,
    isFeatured,
    isNew,
    rating,
    reviews,
  ];
}
