// lib/data/models/order_item_model.dart
import '../../domain/entities/order_item.dart';

class OrderItemModel extends OrderItem {
  OrderItemModel({
    required String id,
    required String productId,
    required String productName,
    required int price,
    required int quantity,
    Map<String, String>? variations,
    String? productImage,
  }) : super(
         id: id,
         productId: productId,
         productName: productName,
         price: price,
         quantity: quantity,
         variations: variations,
         productImage: productImage,
       );

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'],
      productId: json['product_id'],
      productName: json['product_name'],
      price: json['price'],
      quantity: json['quantity'],
      variations:
          json['variations'] != null
              ? Map<String, String>.from(json['variations'])
              : null,
      productImage: json['product_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'product_name': productName,
      'price': price,
      'quantity': quantity,
      'variations': variations,
      'product_image': productImage,
    };
  }
}
