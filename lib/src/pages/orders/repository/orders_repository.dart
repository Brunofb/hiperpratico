import 'package:hiperpratico/src/constants/endpoints.dart';
import 'package:hiperpratico/src/models/cart_item_model.dart';
import 'package:hiperpratico/src/models/order_model.dart';
import 'package:hiperpratico/src/pages/orders/result/orders_result.dart';
import 'package:hiperpratico/src/services/http_manager.dart';

class OrdersRepository {
  final httpManager = HttpManager();

  Future<OrdersResult<List<CartItemModel>>> getOrderItems({
    required String orderId,
    required String token,
  }) async {
    final result = await httpManager.restRequest(
      url: Endpoints.getOrderItems,
      method: HttpMethods.post,
      body: {
        'orderId': orderId,
      },
      headers: {
        'X-Parse-Session-Token': token,
      },
    );

    if (result['result'] != null) {
      List<CartItemModel> items =
          List<Map<String, dynamic>>.from(result['result'])
              .map(CartItemModel.fromJson)
              .toList();
      return OrdersResult<List<CartItemModel>>.success(items);
    } else {
      return OrdersResult.error('Não foi possível buscar os items do pedido!');
    }
  }

  Future<OrdersResult<List<OrderModel>>> getAllOrders(
      {required String userId, required String token}) async {
    final result = await httpManager.restRequest(
      url: Endpoints.getAllOrders,
      method: HttpMethods.post,
      body: {
        'user': userId,
      },
      headers: {
        'X-Parse-Session-Token': token,
      },
    );
    if (result['result'] != null) {
      List<OrderModel> orders =
          List<Map<String, dynamic>>.from(result['result'])
              .map(OrderModel.fromJson)
              .toList();
      return OrdersResult<List<OrderModel>>.success(orders);
    } else {
      return OrdersResult.error('Não foi possível buscar os pedidos!');
    }
  }
}
