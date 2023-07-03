import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiperpratico/src/models/item_model.dart';
import 'package:hiperpratico/src/pages/cart/controller/cart_controller.dart';
import 'package:hiperpratico/src/routes/app_pages.dart';
import 'package:hiperpratico/src/services/utils.services.dart';

class ItemTileVertical extends StatefulWidget {
  final ItemModel item;
  final void Function(GlobalKey) cartAnimationMethod;

  const ItemTileVertical({
    Key? key,
    required this.item,
    required this.cartAnimationMethod,
  }) : super(key: key);

  @override
  State<ItemTileVertical> createState() => _ItemTileVerticalState();
}

class _ItemTileVerticalState extends State<ItemTileVertical> {
  final GlobalKey imageGK = GlobalKey();

  final UtilsServices utilsServices = UtilsServices();
  final cartController = Get.find<CartController>();

  IconData tileIcon = Icons.add_shopping_cart_outlined;
  int cartItemQuantity = 1;

  Future<void> switchIcon() async {
    setState(() => tileIcon = Icons.check);
    await Future.delayed(const Duration(milliseconds: 1500));
    setState(() => tileIcon = Icons.add_shopping_cart_outlined);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(PagesRoutes.productRoute, arguments: widget.item);
          },
          child: Card(
            elevation: 1,
            color: const Color(0xFFF2F7FA),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 2,
                  child: Hero(
                    tag: widget.item.imgUrl,
                    child: Image.network(
                      key: imageGK,
                      widget.item.imgUrl,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(widget.item.itemName),
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          style: const TextStyle(fontSize: 16),
                          children: [
                            TextSpan(
                              text: utilsServices
                                  .priceToCurrency(widget.item.price),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: '/${widget.item.unit}',
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            switchIcon();
                            if (cartController.cartItems.isNotEmpty) {
                              if (widget.item.store.id !=
                                  cartController.cartItems[0].item.store.id) {
                                bool? result = await showAddItemConfirmation();

                                if (result ?? false) {
                                  cartController.cartItems.clear();
                                  utilsServices.showToast(
                                      message: 'Carrinho limpo!');

                                  cartController.addItemToCart(
                                    item: widget.item,
                                    quantity: cartItemQuantity,
                                  );
                                  utilsServices.showToast(
                                      message: 'Produto adicionado!');
                                } else {
                                  utilsServices.showToast(
                                      message: 'Carrinho preservado!');
                                }
                              } else {
                                cartController.addItemToCart(
                                  item: widget.item,
                                  quantity: cartItemQuantity,
                                );
                                utilsServices.showToast(
                                    message: 'Produto adicionado!');
                              }
                            } else {
                              cartController.addItemToCart(
                                item: widget.item,
                                quantity: cartItemQuantity,
                              );
                              utilsServices.showToast(
                                  message: 'Produto adicionado!');
                            }
                            widget.cartAnimationMethod(imageGK);
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          icon: Icon(
                            Icons.add_shopping_cart,
                            size: 20,
                          ),
                          label: Text('Comprar'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<bool?> showAddItemConfirmation() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
              'Você já tem itens de outro estabelecimento no seu carrinho!'),
          content: const Text('Deseja limpar seu carrinho?'),
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
