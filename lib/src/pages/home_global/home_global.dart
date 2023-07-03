import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:hiperpratico/src/config/custom_colors.dart';
import 'package:hiperpratico/src/pages/common_widgets/custom_shimmer.dart';
import 'package:hiperpratico/src/pages/home_global/components/more_widget.dart';
import 'package:hiperpratico/src/pages/home_global/components/ofer_list.dart';
import 'package:hiperpratico/src/pages/home_global/components/sales.dart';
import 'package:hiperpratico/src/pages/home_global/components/user_locale.dart';
import 'package:hiperpratico/src/pages/store/controller/store_controller.dart';
import 'package:hiperpratico/src/pages/store/view/components/category_store_tile.dart';
import 'package:hiperpratico/src/pages/store/view/components/store_tile.dart';

class HomePageGlobal extends StatefulWidget {
  const HomePageGlobal({Key? key}) : super(key: key);

  @override
  State<HomePageGlobal> createState() => _HomePageGlobalState();
}

class _HomePageGlobalState extends State<HomePageGlobal> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const UserLocale(),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    //Categorias
                    GetBuilder<StoreController>(builder: (controller) {
                      return Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 15, 10, 0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
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
                                imageUrl:
                                    controller.allCategories[index].imageUrl,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                    //Slides de promoçoes
                    const Sales(),
                    MoreWidget(
                      primaryTitle: 'Ofertas do dia',
                      secondaryTitle: 'Ver mais',
                    ),
                    const OfferList(),
                    MoreWidget(
                      primaryTitle: 'Útilmas lojas',
                      secondaryTitle: 'Ver mais',
                    ),
                    //Lista de lojas
                    GetBuilder<StoreController>(
                      builder: (controller) {
                        return !controller.isStoreLoading
                            ? Visibility(
                                visible:
                                    (controller.currentCategory?.stories ??
                                            [])
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
                                        'Não há comércios abertos para essa categoria!')
                                  ],
                                ),
                                child: GridView.builder(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                              );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
