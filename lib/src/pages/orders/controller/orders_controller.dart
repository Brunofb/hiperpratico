import 'package:get/get.dart';
import 'package:hiperpratico/src/models/order_model.dart';
import 'package:hiperpratico/src/pages/auth/controller/auth_controller.dart';
import 'package:hiperpratico/src/pages/orders/repository/orders_repository.dart';
import 'package:hiperpratico/src/pages/orders/result/orders_result.dart';
import 'package:hiperpratico/src/services/utils.services.dart';

class OrdersController extends GetxController {
  List<OrderModel> allOrders = [];
  final orderRepository = OrdersRepository();
  final authController = Get.find<AuthController>();
  final utilsServices = UtilsServices();

  @override
  void onInit() {
    super.onInit();
    getAllOrders();
  }

  Future<void> getAllOrders() async {
    OrdersResult<List<OrderModel>> result = await orderRepository.getAllOrders(
      userId: authController.user.id!,
      token: authController.user.token!,
    );

    result.when(
      success: (orders) {
        allOrders = orders;
        update();
      },
      error: (message) {
        utilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }
}
