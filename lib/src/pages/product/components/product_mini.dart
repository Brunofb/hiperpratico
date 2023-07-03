import 'package:hiperpratico/src/services/utils.services.dart';
import 'package:flutter/material.dart';

class ProductViewWidget extends StatefulWidget {
  const ProductViewWidget({
    Key? key,
    required this.productImage,
    required this.productPrice,
    required this.productOldPrice,
    required this.productName,
    required this.productUnit,
  }) : super(key: key);

  final String productImage;
  final double productPrice;
  final double productOldPrice;
  final String productName;
  final String productUnit;

  @override
  _ProductViewWidgetState createState() => _ProductViewWidgetState();
}

class _ProductViewWidgetState extends State<ProductViewWidget> {
  final UtilsServices utilsServices = UtilsServices();


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
      child: Container(
        width: 100,
        height: 100,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    widget.productImage,
                    width: 300,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                  child: Text(
                    utilsServices.priceToCurrency(widget.productPrice),
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontFamily: 'Readex Pro',
                      color: Color(0xFF368915),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                      child: Text(
                        //TODO: Verificar quando não houver valor anterior para o produto
                        utilsServices.priceToCurrency(widget.productOldPrice),
                        style: const TextStyle(
                          fontFamily: 'Readex Pro',
                          fontSize: 11,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  widget.productName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Readex Pro',
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  widget.productUnit,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Readex Pro',
                    fontSize: 10,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
