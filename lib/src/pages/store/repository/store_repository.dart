import 'package:hiperpratico/src/constants/endpoints.dart';
import 'package:hiperpratico/src/models/category_store_model.dart';
import 'package:hiperpratico/src/models/store_model.dart';
import 'package:hiperpratico/src/pages/store/result/store_result.dart';
import 'package:hiperpratico/src/services/http_manager.dart';

class StoreRepository {
  final HttpManager _httpManager = HttpManager();

  Future<StoreResult<CategoryStoreModel>> getAllCategoriesStories() async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getCategoriesStories,
      method: HttpMethods.post,
    );

    if (result['result'] != null) {
      List<CategoryStoreModel> data =
          (List<Map<String, dynamic>>.from(result['result']))
              .map(CategoryStoreModel.fromJson)
              .toList();
      return StoreResult<CategoryStoreModel>.success(data);
    } else {
      return StoreResult.error('Ocorreu um erro ao recuperar as categorias!');
    }
  }

  Future<StoreResult<StoreModel>> getAllStories(
    Map<String, dynamic> body,
  ) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getAllStories,
      method: HttpMethods.post,
      body: body,
    );
    if (result['result'] != null) {
      List<StoreModel> data = List<Map<String, dynamic>>.from(result['result'])
          .map(StoreModel.fromJson)
          .toList();
      return StoreResult.success(data);
    } else {
      return StoreResult.error(
          'Não foi possível recuperar os estabelecimentos');
    }
  }
}
