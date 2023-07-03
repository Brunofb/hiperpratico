import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiperpratico/src/pages/home/controller/home_controller.dart';
import 'package:hiperpratico/src/pages/product/components/product_mini.dart';
import 'package:hiperpratico/src/routes/app_pages.dart';

class OfferList extends StatelessWidget {
  const OfferList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
      child: GetBuilder<HomeController>(
        builder: (controller) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: const BoxDecoration(),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                      controller.allProducts.length,
                      (index) => InkWell(
                        onTap: () {
                          Get.toNamed(
                            PagesRoutes.productRoute,
                            arguments: controller.allProducts[index],
                          );
                        },
                        child: ProductViewWidget(
                            productImage:
                                controller.allProducts[index].imgUrl,
                            productPrice: controller.allProducts[index].price,
                            productOldPrice:
                                controller.allProducts[index].price,
                            productName:
                                controller.allProducts[index].itemName,
                            productUnit: controller.allProducts[index].unit),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
