import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hiperpratico/src/models/cart_item_model.dart';
import 'package:hiperpratico/src/models/order_model.dart';
import 'package:hiperpratico/src/pages/common_widgets/payment_dialog.dart';
import 'package:hiperpratico/src/pages/orders/components/order_status_widget.dart';
import 'package:hiperpratico/src/pages/orders/controller/order_controller.dart';
import 'package:hiperpratico/src/services/utils.services.dart';

class OrderTile extends StatelessWidget {
  final OrderModel order;

  OrderTile({
    Key? key,
    required this.order,
  }) : super(key: key);

  final utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: GetBuilder<OrderController>(
            init: OrderController(order),
            global: false,
            builder: (controller) {
              return ExpansionTile(
                onExpansionChanged: (value) {
                  if (value && order.items.isEmpty) {
                    controller.getOrderItems();
                  }
                },
                initiallyExpanded: order.status == 'preparing_purchase',
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pedido ${order.id}'),
                    Text(
                      utilsServices.formatDateTime(order.createdDateTime!),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                children: controller.isLoading
                    ? [
                        Container(
                          height: 80,
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(),
                        )
                      ]
                    : [
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: SizedBox(
                                    height: 150,
                                    child: ListView(
                                      children: controller.order.items
                                          .map((orderItem) {
                                        return _OrderItemWidget(
                                          utilsServices: utilsServices,
                                          orderItem: orderItem,
                                        );
                                      }).toList(),
                                    ),
                                  )),
                              VerticalDivider(
                                color: Colors.grey.shade300,
                                thickness: 2,
                                width: 8,
                              ),
                              Expanded(
                                child: OrderStatusWidget(
                                  status: order.status,
                                  isOverdue: order.overdueDateTime
                                      .isBefore(DateTime.now()),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            style: const TextStyle(fontSize: 20),
                            children: [
                              const TextSpan(
                                text: 'Total: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text:
                                    utilsServices.priceToCurrency(order.total),
                              )
                            ],
                          ),
                        ),
                        Visibility(
                          visible: order.status == 'pending_payment' &&
                              !order.isOverDue,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (_) {
                                    return PaymentDialog(order: order);
                                  });
                            },
                            icon: Image.asset(
                              'assets/app_images/pix.png',
                              height: 18,
                            ),
                            label: const Text(
                              'Ver QR Code Pix',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
              );
            }),
      ),
    );
  }
}

class _OrderItemWidget extends StatelessWidget {
  const _OrderItemWidget({
    Key? key,
    required this.utilsServices,
    required this.orderItem,
  }) : super(key: key);

  final UtilsServices utilsServices;
  final CartItemModel orderItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            '${orderItem.quantity} ${orderItem.item.unit} ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(orderItem.item.itemName),
          ),
          Text(
            utilsServices.priceToCurrency(
              orderItem.totalPrice(),
            ),
          )
        ],
      ),
    );
  }
}
