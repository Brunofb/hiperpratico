import 'package:flutter/material.dart';
import 'package:hiperpratico/src/config/custom_colors.dart';
import 'package:hiperpratico/src/models/item_model.dart';
import 'package:hiperpratico/src/services/utils.services.dart';

class ItemTile extends StatefulWidget {
  final ItemModel item;
  final void Function(GlobalKey) cartAnimationMethod;

  const ItemTile({
    Key? key,
    required this.item,
    required this.cartAnimationMethod,
  }) : super(key: key);

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  final GlobalKey imageGK = GlobalKey();

  UtilsServices utilsServices = UtilsServices();

  IconData tileIcon = Icons.add_shopping_cart_outlined;

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
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (_) => ProductScreen(
            //       item: widget.item,
            //     ),
            //   ),
            // );
          },
          child: Card(
            elevation: 1,
            shadowColor: Colors.grey.shade300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Hero(
                      tag: widget.item.imgUrl,
                      child: Image.network(
                        '',
                        key: imageGK,
                      ),
                    ),
                  ),
                  Text(
                    widget.item.itemName,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        utilsServices.priceToCurrency(widget.item.price),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.customSwatchColor,
                        ),
                      ),
                      Text(
                        '/${widget.item.unit}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade500,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 6,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              alignment: Alignment.center,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
            ),
            onPressed: () {},
            label: const Text(
              'Adicionar ao Carrinho',
              style: TextStyle(
                fontSize: 11,
                color: Colors.white,
              ),
            ),
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
              size: 15,
            ),
          ),
        )
        // Positioned(
        //   top: 4,
        //   right: 4,
        //   child: ClipRRect(
        //     borderRadius: const BorderRadius.only(
        //       bottomLeft: Radius.circular(15),
        //       topRight: Radius.circular(20),
        //     ),
        //     child: Material(
        //       child: InkWell(
        //         onTap: () {
        //           switchIcon();
        //           widget.cartAnimationMethod(imageGK);
        //         },
        //         child: Ink(
        //           height: 40,
        //           width: 35,
        //           decoration: BoxDecoration(
        //             color: CustomColors.customSwatchColor,
        //           ),
        //           child: Icon(
        //             tileIcon,
        //             color: Colors.white,
        //             size: 20,
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // )
      ],
    );
  }
}
