import 'package:flutter/material.dart';

import 'order_item_card.dart';
import 'orders_manager.dart';

import '../shared/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersManager = OrdersManager();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      body: ListView.builder(
        itemCount: ordersManager.orderCount,
        itemBuilder: (cxt, i) => OrderItemCard(ordersManager.orders[i]),
      ),
      drawer: const AppDrawer(),
    );
  }
}