import 'package:flutter/material.dart';
import 'package:hiperpratico/src/models/item_model.dart';
import 'package:hiperpratico/src/pages/product/products_screen.dart';
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

  UtilsServices utilsServices = UtilsServices();

  IconData tileIcon = Icons.add_shopping_cart_outlined;

  Future<void> switchIcon() async {
    setState(() => tileIcon = Icons.check);
    await Future.delayed(const Duration(milliseconds: 1500));
    setState(() => tileIcon = Icons.add_shopping_cart_outlined);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ProductScreen(item: widget.item),
          ),
        );
      },
      child: Card(
        elevation: 1,
        shadowColor: Colors.grey.shade300,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
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
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.item.itemName),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      utilsServices.priceToCurrency(widget.item.price),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text('/${widget.item.unit}'),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        alignment: Alignment.center,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                      ),
                      onPressed: () {
                        switchIcon();
                        setState(() {
                        });
                        widget.cartAnimationMethod(imageGK);
                      },
                      label: const Text(
                        'Adicionar ao Carrinho',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      icon: Icon(
                        tileIcon,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
