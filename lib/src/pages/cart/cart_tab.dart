import 'package:flutter/material.dart';
import 'package:hiperpratico/src/config/custom_colors.dart';
import 'package:hiperpratico/src/models/cart_item_model.dart';
import 'package:hiperpratico/src/pages/common_widgets/payment_dialog.dart';
import 'package:hiperpratico/src/services/utils.services.dart';
import 'package:hiperpratico/src/config/app_data.dart' as app_data;

import 'components/cart_tile.dart';

class CartTab extends StatefulWidget {
  const CartTab({Key? key}) : super(key: key);

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  UtilsServices utilsServices = UtilsServices();

  void removeCartItem(CartItemModel cartItemModel) {
    setState(() {
      app_data.cartItems.remove(cartItemModel);
      utilsServices.showToast(
          message: '${cartItemModel.item.itemName} removido do carrinho!');
    });
  }

  double cartTotalPrice() {
    double total = 0;
    for (var item in app_data.cartItems) {
      total += item.totalPrice();
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Carrinho',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: app_data.cartItems.length,
              itemBuilder: (_, index) {
                return CartTile(
                  cartItemModel: app_data.cartItems[index],
                  remove: removeCartItem,
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 3,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Total geral',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                Text(
                  utilsServices.priceToCurrency(cartTotalPrice()),
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: CustomColors.customSwatchColor,
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.customSwatchColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () async {
                      bool? result = await shorOrderConfirmation();

                      if (result ?? false) {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return PaymentDialog(
                                  order: app_data.orders.first);
                            });
                      } else {
                        utilsServices.showToast(
                          message: 'Pedido não confirmado!',
                          isError: true,
                        );
                      }
                    },
                    child: const Text(
                      'Concluir pedido',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> shorOrderConfirmation() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Confirmação'),
          content: const Text('Deseja confirma o pedido?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Não'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Sim'),
            ),
          ],
        );
      },
    );
  }
}
