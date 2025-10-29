// lib/data/models/order_model.dart
import 'order_item_model.dart';

import '../../domain/entities/order.dart';
import '../../domain/entities/order_item.dart';

class OrderModel extends Order {
  OrderModel({
    required String id,
    required String userId,
    required List<OrderItem> items,
    required int subtotal,
    required int shipping,
    required int tax,
    required int total,
    required String paymentMethod,
    required String status,
    String? shippingAddress,
    required DateTime createdAt,
    DateTime? paidAt,
    DateTime? shippedAt,
    DateTime? deliveredAt,
    DateTime? cancelledAt,
  }) : super(
         id: id,
         userId: userId,
         items: items,
         subtotal: subtotal,
         shipping: shipping,
         tax: tax,
         total: total,
         paymentMethod: paymentMethod,
         status: status,
         shippingAddress: shippingAddress,
         createdAt: createdAt,
         paidAt: paidAt,
         shippedAt: shippedAt,
         deliveredAt: deliveredAt,
         cancelledAt: cancelledAt,
       );

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      userId: json['user_id'],
      items:
          (json['items'] as List)
              .map((item) => OrderItemModel.fromJson(item))
              .toList(),
      subtotal: json['subtotal'],
      shipping: json['shipping'],
      tax: json['tax'],
      total: json['total'],
      paymentMethod: json['payment_method'],
      status: json['status'],
      shippingAddress: json['shipping_address'],
      createdAt: DateTime.parse(json['created_at']),
      paidAt: json['paid_at'] != null ? DateTime.parse(json['paid_at']) : null,
      shippedAt:
          json['shipped_at'] != null
              ? DateTime.parse(json['shipped_at'])
              : null,
      deliveredAt:
          json['delivered_at'] != null
              ? DateTime.parse(json['delivered_at'])
              : null,
      cancelledAt:
          json['cancelled_at'] != null
              ? DateTime.parse(json['cancelled_at'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'items': items.map((item) => (item as OrderItemModel).toJson()).toList(),
      'subtotal': subtotal,
      'shipping': shipping,
      'tax': tax,
      'total': total,
      'payment_method': paymentMethod,
      'status': status,
      'shipping_address': shippingAddress,
      'created_at': createdAt.toIso8601String(),
      'paid_at': paidAt?.toIso8601String(),
      'shipped_at': shippedAt?.toIso8601String(),
      'delivered_at': deliveredAt?.toIso8601String(),
      'cancelled_at': cancelledAt?.toIso8601String(),
    };
  }
}
