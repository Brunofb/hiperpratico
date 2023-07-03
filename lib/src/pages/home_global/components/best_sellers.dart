import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiperpratico/src/pages/home/controller/home_controller.dart';
import 'package:hiperpratico/src/pages/home_global/components/constants.dart';
import 'package:hiperpratico/src/routes/app_pages.dart';
import 'package:hiperpratico/src/services/utils.services.dart';

class BestSellers extends StatelessWidget {
  final utilsServices = UtilsServices();

  BestSellers({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.black.withOpacity(0.1),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Constants.kPadding,
              horizontal: Constants.kPadding * 2,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Ofertas do dia",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 2.0,
                      horizontal: Constants.kPadding,
                    ),
                    backgroundColor: Colors.deepOrange,
                    minimumSize: const Size(5, 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text("Mais"),
                )
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: GetBuilder<HomeController>(builder: (controller) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  controller.allProducts.length,
                  (index) => Padding(
                    padding: EdgeInsets.only(
                      bottom: Constants.kPadding * 2,
                      right: Constants.kPadding,
                      left: index == 0 ? Constants.kPadding : 0,
                    ),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(
                          PagesRoutes.productRoute,
                          arguments: controller.allProducts[index],
                        );
                      },
                      child: Column(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 4,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                controller.allProducts[index].imgUrl,
                                height: 180,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 120,
                            child: Text(
                              controller.allProducts[index].itemName,
                            ),
                          ),
                          SizedBox(
                            width: 120,
                            child: Text(
                              utilsServices.priceToCurrency(
                                controller.allProducts[index].price,
                              ),
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.blueGrey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
