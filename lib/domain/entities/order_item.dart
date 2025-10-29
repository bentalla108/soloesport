// lib/domain/entities/order_item.dart
class OrderItem {
  final String id;
  final String productId;
  final String productName;
  final int price;
  final int quantity;
  final Map<String, String>? variations;
  final String? productImage;

  OrderItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
    this.variations,
    this.productImage,
  });
}
