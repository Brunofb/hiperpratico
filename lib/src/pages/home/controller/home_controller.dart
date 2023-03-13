import 'package:get/get.dart';
import 'package:hiperpratico/src/models/category_model.dart';
import 'package:hiperpratico/src/models/item_model.dart';
import 'package:hiperpratico/src/pages/home/repository/home_repository.dart';
import 'package:hiperpratico/src/pages/home/result/home_result.dart';
import 'package:hiperpratico/src/services/utils.services.dart';

const int itemsPerPage = 6;

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getAllCategoriesController();
  }

  final homeRepository = HomeRepository();
  final utilServices = UtilsServices();

  bool isLoading = false;
  List<CategoryModel> allCategories = [];
  CategoryModel? currentCategory;

  List<ItemModel> get allProducts => currentCategory?.items ?? [];

  void setLoading(bool value) {
    isLoading = value;
    update();
  }

  void selectCategory(CategoryModel category) {
    currentCategory = category;
    update();
    getAllProductsController();
  }

  Future<void> getAllCategoriesController() async {
    setLoading(true);
    HomeResult<CategoryModel> homeResult =
        await homeRepository.getAllCategories();
    setLoading(false);

    homeResult.when(success: (data) {
      allCategories.assignAll(data);
      if (allCategories.isEmpty) return;
      selectCategory(allCategories.first);
    }, error: (message) {
      utilServices.showToast(
        message: message,
        isError: true,
      );
    });
  }

  Future<void> getAllProductsController() async {
    setLoading(true);

    Map<String, dynamic> body = {
      'page': currentCategory!.pagination,
      'categoryId': currentCategory!.id,
      'itemsPerPage': itemsPerPage,
    };

    HomeResult<ItemModel> result = await homeRepository.getAllProducts(body);

    result.when(success: (data) {
      currentCategory!.items = data;
      print(currentCategory!.items.first);
    }, error: (message) {
      utilServices.showToast(
        message: message,
        isError: true,
      );
    });

    setLoading(false);
  }
}
