import 'package:hiperpratico/src/constants/endpoints.dart';
import 'package:hiperpratico/src/models/cart_item_model.dart';
import 'package:hiperpratico/src/pages/cart/result/cart_result.dart';
import 'package:hiperpratico/src/services/http_manager.dart';

class CartRepository {
  final _httpManager = HttpManager();

  Future<CartResult<List<CartItemModel>>> getCartItems(
      {required String token, required String userId}) async {
    final result = await _httpManager.restRequest(
        url: Endpoints.getCarItems,
        method: HttpMethods.post,
        headers: {
          'X-Parse-Session-Token': token,
        },
        body: {
          'user': userId,
        });
    if (result['result'] != null) {
      List<CartItemModel> data =
          List<Map<String, dynamic>>.from(result['result'])
              .map((item) => CartItemModel.fromJson(item))
              .toList();
      return CartResult<List<CartItemModel>>.success(data);
    } else {
      return CartResult.error('Não foi possível recuperar o carrinho!');
    }
  }
}
