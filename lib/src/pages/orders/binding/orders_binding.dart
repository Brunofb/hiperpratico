import 'package:get/get.dart';
import 'package:hiperpratico/src/pages/orders/controller/orders_controller.dart';

class OrdersBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(OrdersController());
  }

}