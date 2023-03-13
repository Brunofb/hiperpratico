import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiperpratico/src/config/app_data.dart' as app_data;
import 'package:hiperpratico/src/config/custom_colors.dart';
import 'package:hiperpratico/src/pages/common_widgets/app_name_widget.dart';
import 'package:hiperpratico/src/pages/common_widgets/custom_shimmer.dart';
import 'package:hiperpratico/src/pages/home/components/item_tile_vertical.dart';
import 'package:hiperpratico/src/pages/home/controller/home_controller.dart';

import '../components/category_tile.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int cartItems = 5;

  GlobalKey<CartIconKey> globalKeyCartItems = GlobalKey<CartIconKey>();

  late Function(GlobalKey) runAddToCardAnimation;

  void itemSelectedCartAnimation(GlobalKey gkImage) {
    runAddToCardAnimation(gkImage);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const AppNameWidget(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              top: 15,
              right: 15,
            ),
            child: GestureDetector(
              onTap: () {},
              child: Badge(
                badgeColor: CustomColors.customContrastColor,
                badgeContent: Text(
                  '$cartItems',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                child: AddToCartIcon(
                  key: globalKeyCartItems,
                  icon: Icon(
                    color: CustomColors.customSwatchColor,
                    Icons.shopping_cart,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: AddToCartAnimation(
        gkCart: globalKeyCartItems,
        previewDuration: const Duration(milliseconds: 100),
        previewCurve: Curves.ease,
        receiveCreateAddToCardAnimationMethod: (addToCardAnimationMethod) {
          runAddToCardAnimation = addToCardAnimationMethod;
        },
        child: Column(
          children: [
            //Campo de pesquisa
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  isDense: true,
                  hintText: 'Pesquise aqui...',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: CustomColors.customContrastColor,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(60),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
              ),
            ),
            GetBuilder<HomeController>(builder: (controller) {
              return Container(
                padding: const EdgeInsets.only(left: 25),
                height: 40,
                child: !controller.isLoading
                    ? ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) => CategoryTile(
                          onPressed: () {
                            controller.selectCategory(
                              controller.allCategories[index],
                            );
                          },
                          category: controller.allCategories[index].name,
                          isSelected: controller.allCategories[index] ==
                              controller.currentCategory,
                        ),
                        separatorBuilder: (_, index) =>
                            const SizedBox(width: 10),
                        itemCount: controller.allCategories.length,
                      )
                    : ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(
                          8,
                          (index) => Container(
                            margin: const EdgeInsets.only(right: 10),
                            alignment: Alignment.center,
                            child: CustomShimmer(
                              height: 20,
                              width: 80,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
              );
            }), // Categorias
            GetBuilder<HomeController>(builder: (controller) {
              return Expanded(
                child: !controller.isLoading
                    ? GridView.builder(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 2,
                          childAspectRatio: 5 / 2,
                        ),
                        itemCount: controller.allProducts.length,
                        itemBuilder: (_, index) {
                          return ItemTileVertical(
                              qtdCart: () {
                                setState(() {
                                  cartItems += 1;
                                });
                              },
                              item: controller.allProducts[index],
                              cartAnimationMethod: itemSelectedCartAnimation);
                        },
                      )
                    : GridView.count(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        physics: const BouncingScrollPhysics(),
                        crossAxisCount: 1,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 5,
                        childAspectRatio: 5 / 2,
                        children: List.generate(
                          6,
                          (index) => CustomShimmer(
                            height: double.infinity,
                            width: double.infinity,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
              );
            })
          ],
        ),
      ),
    );
  }
}
