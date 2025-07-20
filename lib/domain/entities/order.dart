// lib/domain/entities/order.dart
import 'package:soloesport/domain/entities/order_item.dart';

class Order {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final int subtotal;
  final int shipping;
  final int tax;
  final int total;
  final String paymentMethod;
  final String status; // 'pending', 'paid', 'shipped', 'delivered', 'cancelled'
  final String? shippingAddress;
  final DateTime createdAt;
  final DateTime? paidAt;
  final DateTime? shippedAt;
  final DateTime? deliveredAt;
  final DateTime? cancelledAt;

  Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.subtotal,
    required this.shipping,
    required this.tax,
    required this.total,
    required this.paymentMethod,
    required this.status,
    this.shippingAddress,
    required this.createdAt,
    this.paidAt,
    this.shippedAt,
    this.deliveredAt,
    this.cancelledAt,
  });
}
