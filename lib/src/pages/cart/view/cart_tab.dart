import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiperpratico/src/config/custom_colors.dart';
import 'package:hiperpratico/src/pages/cart/controller/cart_controller.dart';
import 'package:hiperpratico/src/pages/cart/view/components/cart_tile.dart';
import 'package:hiperpratico/src/services/utils.services.dart';

class CartTab extends StatefulWidget {
  const CartTab({Key? key}) : super(key: key);

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  UtilsServices utilsServices = UtilsServices();
  final cartController = Get.find<CartController>();

  double cartTotalPrice() {
    double total = 0;
    for (var item in cartController.cartItems) {
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
            child: GetBuilder<CartController>(
              builder: (controller) {
                if (controller.cartItems.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.remove_shopping_cart,
                        size: 60,
                        color: CustomColors.customSwatchColor,
                      ),
                      const Text(
                        'Não há itens no carrinho.',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  );
                }
                return ListView.builder(
                  itemCount: controller.cartItems.length,
                  itemBuilder: (_, index) {
                    return CartTile(
                      cartItemModel: controller.cartItems[index],
                    );
                  },
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
                GetBuilder<CartController>(builder: (controller) {
                  return Text(
                    utilsServices.priceToCurrency(controller.cartTotalPrice()),
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: CustomColors.customSwatchColor,
                    ),
                  );
                }),
                SizedBox(
                  height: 40,
                  child: GetBuilder<CartController>(builder: (controller) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.customSwatchColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      onPressed: (controller.isCheckoutLoading || controller.cartItems.isEmpty)
                          ? null
                          : () async {
                              bool? result = await shorOrderConfirmation();

                              if (result ?? false) {
                                cartController.checkoutCartController();
                              } else {
                                utilsServices.showToast(
                                    message: 'Pedido não confirmado!');
                              }
                            },
                      child: controller.isCheckoutLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                              'Concluir pedido',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                    );
                  }),
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
