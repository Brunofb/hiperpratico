import 'package:hiperpratico/src/constants/endpoints.dart';
import 'package:hiperpratico/src/models/cart_item_model.dart';
import 'package:hiperpratico/src/pages/cart/result/cart_result.dart';
import 'package:hiperpratico/src/services/http_manager.dart';

import '../../../models/order_model.dart';

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

  Future<CartResult<OrderModel>> checkoutCart({
    required String token,
    required double total,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.checkout,
      method: HttpMethods.post,
      body: {
        'total': total,
      },
      headers: {
        'X-Parse-Session-Token': token,
      },
    );

    if (result['result'] != null) {
      print(result['result']);
      final order = OrderModel.fromJson(result['result']);
      return CartResult.success(order);
    } else {
      return CartResult.error('Não foi possível criar o pedido!');
    }
  }

  Future<bool> changeItemQuantity({
    required String token,
    required String cartItemId,
    required int quantity,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.changeItemQuantity,
      method: HttpMethods.post,
      body: {
        'cartItemId': cartItemId,
        'quantity': quantity,
      },
      headers: {'X-Parse-Session-Token': token},
    );

    return result.isEmpty;
  }

  Future<CartResult<String>> addCartItem({
    required String userId,
    required String token,
    required String productId,
    required int quantity,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.addItemToCart,
      method: HttpMethods.post,
      body: {
        'user': userId,
        'quantity': quantity,
        'productId': productId,
      },
      headers: {'X-Parse-Session-Token': token},
    );
    if (result['result'] != null) {
      return CartResult.success(result['result']['id']);
    } else {
      return CartResult.error('Não foi possível adicionar o item no carrinho!');
    }
  }
}
