import 'package:get/get.dart';
import 'package:hiperpratico/src/models/category_store_model.dart';
import 'package:hiperpratico/src/models/store_model.dart';
import 'package:hiperpratico/src/pages/store/repository/store_repository.dart';
import 'package:hiperpratico/src/pages/store/result/store_result.dart';
import 'package:hiperpratico/src/services/utils.services.dart';

const int itemsPerPage = 10;

class StoreController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    debounce(
      searchTitle,
      (callback) => filterByTitle(),
      time: const Duration(milliseconds: 600),
    );
    getCategoriesStories();
  }

  final storeRepository = StoreRepository();
  final utilsServices = UtilsServices();

  bool isCategoryLoading = false;
  bool isStoreLoading = false;
  List<CategoryStoreModel> allCategories = [];
  CategoryStoreModel? currentCategory;
  RxString searchTitle = ''.obs;

  List<StoreModel> get allStories => currentCategory?.stories ?? [];

  bool get isLastPage {
    if (currentCategory!.stories.length < itemsPerPage) {
      return true;
    }
    return currentCategory!.pagination * itemsPerPage > allStories.length;
  }

  void setLoading(bool value, {bool isStore = false}) {
    if (!isStore) {
      isCategoryLoading = value;
    } else {
      isStoreLoading = value;
    }
    update();
  }

  void selectCategory(CategoryStoreModel category) {
    currentCategory = category;
    update();
    if (currentCategory!.stories.isNotEmpty) return;
    getAllStories();
  }

  void loadMoreStories() async {
    currentCategory!.pagination++;
    getAllStories(canLoad: false);
  }

  Future<void> getCategoriesStories() async {
    setLoading(true);
    StoreResult<CategoryStoreModel> result =
        await storeRepository.getAllCategoriesStories();
    setLoading(false);

    result.when(success: (data) {
      allCategories.assignAll(data);
      if (allCategories.isEmpty) return;
      selectCategory(allCategories.first);
    }, error: (message) {
      utilsServices.showToast(
        message: message,
        isError: true,
      );
    });
  }

  void filterByTitle() {
    for (var category in allCategories) {
      category.stories.clear();
      category.pagination = 0;
    }
    if (searchTitle.value.isEmpty) {
      allStories.removeAt(0);
    } else {
      CategoryStoreModel? category =
          allCategories.firstWhereOrNull((category) => category.id == '');
      if (category == null) {
        final allStoriesCategory = CategoryStoreModel(
          id: '',
          name: '',
          stories: [],
          imageUrl: '',
          pagination: 0,
        );
        allCategories.insert(0, allStoriesCategory);
      } else {
        category.stories.clear();
        category.pagination = 0;
      }
    }
    currentCategory = allCategories.first;
    update();
    getAllStories(canLoad: false);
  }

  Future<void> getAllStories({bool canLoad = true}) async {
    if (canLoad) {
      setLoading(true, isStore: true);
    }

    Map<String, dynamic> body = {
      'page': currentCategory!.pagination,
      'categoryStoreId': currentCategory!.id,
      'itemsPerPage': itemsPerPage,
    };

    if (searchTitle.value.isNotEmpty) {
      body['title'] = searchTitle.value;
      if (currentCategory!.id == '') {
        body.remove('categoryStoreId');
      }
    }

    StoreResult<StoreModel> result = await storeRepository.getAllStories(body);

    setLoading(false, isStore: true);

    result.when(success: (data) {
      currentCategory!.stories.addAll(data);
    }, error: (message) {
      utilsServices.showToast(
        message: message,
        isError: true,
      );
    });

    setLoading(false);
  }
}
