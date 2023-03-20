import 'package:get/get.dart';
import 'package:hiperpratico/src/pages/store/controller/store_controller.dart';

class StoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StoreController());
  }
}
