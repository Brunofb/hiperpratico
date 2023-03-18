import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiperpratico/src/pages/orders/components/order_tile.dart';
import 'package:hiperpratico/src/pages/orders/controller/orders_controller.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pedidos',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: GetBuilder<OrdersController>(
        builder: (controller) {
          return RefreshIndicator(
            onRefresh: () => controller.getAllOrders(),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              physics: const AlwaysScrollableScrollPhysics(),
              separatorBuilder: (_, index) => const SizedBox(height: 10),
              itemCount: controller.allOrders.length,
              itemBuilder: (_, index) =>
                  OrderTile(order: controller.allOrders[index]),
            ),
          );
        },
      ),
    );
  }
}
