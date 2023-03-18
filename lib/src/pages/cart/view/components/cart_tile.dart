import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiperpratico/src/config/custom_colors.dart';
import 'package:hiperpratico/src/models/cart_item_model.dart';
import 'package:hiperpratico/src/pages/cart/controller/cart_controller.dart';
import 'package:hiperpratico/src/pages/common_widgets/quantity_widget.dart';
import 'package:hiperpratico/src/services/utils.services.dart';

class CartTile extends StatefulWidget {
  final CartItemModel cartItemModel;

  const CartTile({
    Key? key,
    required this.cartItemModel,
  }) : super(key: key);

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  final UtilsServices utilsServices = UtilsServices();
  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Image.network(
          widget.cartItemModel.item.imgUrl,
          height: 60,
          width: 60,
        ),
        title: Text(
          widget.cartItemModel.item.itemName,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          utilsServices.priceToCurrency(widget.cartItemModel.totalPrice()),
          style: TextStyle(
              color: CustomColors.customSwatchColor,
              fontWeight: FontWeight.bold),
        ),
        trailing: QuantityWidget(
          suffixText: widget.cartItemModel.item.unit,
          value: widget.cartItemModel.quantity,
          result: (quantity) {
            cartController.changeItemQuantity(
              item: widget.cartItemModel,
              quantity: quantity,
            );
          },
          isRemovable: true,
        ),
      ),
    );
  }
}
