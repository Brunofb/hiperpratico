import 'package:get/get.dart';
import 'package:hiperpratico/src/models/category_product_model.dart';
import 'package:hiperpratico/src/models/item_model.dart';
import 'package:hiperpratico/src/pages/home/repository/home_repository.dart';
import 'package:hiperpratico/src/pages/home/result/home_result.dart';
import 'package:hiperpratico/src/services/utils.services.dart';

const int itemsPerPage = 6;

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    debounce(
      searchTitle,
      (callback) => filterByTitle(),
      time: const Duration(milliseconds: 600),
    );
    getAllCategoriesController();
  }

  final homeRepository = HomeRepository();
  final utilServices = UtilsServices();

  bool isCategoryLoading = false;
  bool isProductLoading = true;
  List<CategoryProductModel> allCategories = [];
  CategoryProductModel? currentCategory;

  List<ItemModel> get allProducts => currentCategory?.items ?? [];
  RxString searchTitle = "".obs;

  bool get isLastPage {
    if (currentCategory!.items.length < itemsPerPage) {
      return true;
    }
    return currentCategory!.pagination * itemsPerPage > allProducts.length;
  }

  void setLoading(bool value, {bool isProduct = false}) {
    if (!isProduct) {
      isCategoryLoading = value;
    } else {
      isProductLoading = value;
    }
    update();
  }

  void selectCategory(CategoryProductModel category) {
    currentCategory = category;
    update();
    if (currentCategory!.items.isNotEmpty) return;
    getAllProductsController();
  }

  Future<void> getAllCategoriesController() async {
    setLoading(true);
    HomeResult<CategoryProductModel> homeResult =
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

  void filterByTitle() {
    for (var category in allCategories) {
      category.items.clear();
      category.pagination = 0;
    }

    if (searchTitle.value.isEmpty) {
      allCategories.removeAt(0);
    } else {
      CategoryProductModel? c =
          allCategories.firstWhereOrNull((category) => category.id == '');
      if (c == null) {
        final allProductsCategory = CategoryProductModel(
          name: 'Todos',
          id: '',
          items: [],
          pagination: 0,
        );
        allCategories.insert(0, allProductsCategory);
      } else {
        c.items.clear();
        c.pagination = 0;
      }
    }
    currentCategory = allCategories.first;
    update();
    getAllProductsController();
  }

  void loadMoreProducts() {
    currentCategory!.pagination++;
    getAllProductsController(canLoad: false);
  }

  Future<void> getAllProductsController({bool canLoad = true}) async {
    if (canLoad) {
      setLoading(true, isProduct: true);
    }

    Map<String, dynamic> body = {
      'page': currentCategory!.pagination,
      'categoryId': currentCategory!.id,
      'itemsPerPage': itemsPerPage,
    };

    if (searchTitle.value.isNotEmpty) {
      body['title'] = searchTitle.value;
      if (currentCategory!.id == '') {
        body.remove('categoryId');
      }
    }

    HomeResult<ItemModel> result = await homeRepository.getAllProducts(body);

    setLoading(false, isProduct: true);

    result.when(success: (data) {
      currentCategory!.items.addAll(data);
    }, error: (message) {
      utilServices.showToast(
        message: message,
        isError: true,
      );
    });

    setLoading(false);
  }
}
