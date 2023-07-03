import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiperpratico/src/config/custom_colors.dart';
import 'package:hiperpratico/src/pages/base/controller/navigation_controller.dart';
import 'package:hiperpratico/src/pages/common_widgets/custom_shimmer.dart';
import 'package:hiperpratico/src/pages/home_global/components/app_bar.dart';
import 'package:hiperpratico/src/pages/home_global/components/best_sellers.dart';
import 'package:hiperpratico/src/pages/store/controller/store_controller.dart';
import 'package:hiperpratico/src/pages/store/view/components/category_store_tile.dart';
import 'package:hiperpratico/src/pages/store/view/components/store_tile.dart';

class HomePageGlobalOld extends StatefulWidget {
  const HomePageGlobalOld({super.key});

  @override
  State<HomePageGlobalOld> createState() => _HomePageGlobalOldState();
}

class _HomePageGlobalOldState extends State<HomePageGlobalOld> {
  GlobalKey<CartIconKey> globalKeyCartItems = GlobalKey<CartIconKey>();

  final searchTitleController = TextEditingController();
  final navigatorController = Get.find<NavigationController>();

  late Function(GlobalKey) runAddToCardAnimation;

  void itemSelectedCartAnimation(GlobalKey gkImage) {
    runAddToCardAnimation(gkImage);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Componente de pesquisa
            GetBuilder<StoreController>(
              builder: (controller) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: TextFormField(
                    controller: searchTitleController,
                    onChanged: (value) {
                      controller.searchTitle.value = value;
                    },
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
                      suffix: controller.searchTitle.value.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                searchTitleController.clear();
                                controller.searchTitle.value = '';
                                FocusScope.of(context).unfocus();
                              },
                              icon: Icon(
                                Icons.close,
                                color: CustomColors.customContrastColor,
                              ),
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            //Categorias dos estabelecimentos
            GetBuilder<StoreController>(builder: (controller) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    controller.allCategories.length,
                    (index) => CategoryStoreTile(
                      category: controller.allCategories[index].name,
                      isSelected: controller.allCategories[index] ==
                          controller.currentCategory,
                      onPressed: () {
                        controller.selectCategory(
                          controller.allCategories[index],
                        );
                      },
                      imageUrl: controller.allCategories[index].imageUrl,
                    ),
                  ),
                ),
              );
            }),
            //TODO:Sugestão de ofertas de acordo com perfil
            //TODO:Ofertas devem desaparecer quando o filtro de categoria for acionado
            BestSellers(),
            //BannerSale(),
            //Lista de estabelecimentos por rankeamento
            GetBuilder<StoreController>(
              builder: (controller) {
                return Expanded(
                  child: !controller.isStoreLoading
                      ? Visibility(
                          visible: (controller.currentCategory?.stories ?? [])
                              .isNotEmpty,
                          replacement: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.store,
                                size: 40,
                                color: CustomColors.customSwatchColor,
                              ),
                              const Text(
                                  'Não há comércios abertos nessa categoria!')
                            ],
                          ),
                          child: GridView.builder(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisSpacing: 2,
                              crossAxisSpacing: 2,
                              childAspectRatio: 5 / 2,
                            ),
                            shrinkWrap: true,
                            itemCount: controller.allStories.length,
                            itemBuilder: (_, index) {
                              if (((index + 1) ==
                                      controller.allStories.length) &&
                                  !controller.isLastPage) {
                                controller.loadMoreStories();
                              }
                              return StoreTile(
                                store: controller.allStories[index],
                              );
                            },
                          ),
                        )
                      : GridView.count(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          physics: const BouncingScrollPhysics(),
                          crossAxisCount: 1,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 5,
                          childAspectRatio: 5 / 2,
                          shrinkWrap: true,
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
