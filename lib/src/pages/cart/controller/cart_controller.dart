import 'package:get/get.dart';
import 'package:hiperpratico/src/models/cart_item_model.dart';
import 'package:hiperpratico/src/pages/auth/controller/auth_controller.dart';
import 'package:hiperpratico/src/pages/cart/repository/cart_repository.dart';
import 'package:hiperpratico/src/pages/cart/result/cart_result.dart';
import 'package:hiperpratico/src/services/utils.services.dart';

class CartController extends GetxController {
  final cartRepository = CartRepository();
  final authController = Get.find<AuthController>();
  final utilServices = UtilsServices();

  List<CartItemModel> cartItems = [];

  @override
  void onInit() {
    super.onInit();
    getCartItems();
  }

  Future<void> getCartItems() async {
    final CartResult<List<CartItemModel>> result =
        await cartRepository.getCartItems(
      token: authController.user.token!,
      userId: authController.user.id!,
    );
    result.when(success: (data) {
      cartItems = data;
      update();
      print(data);
    }, error: (message) {
      utilServices.showToast(
        message: message,
        isError: true,
      );
    });
  }
}
