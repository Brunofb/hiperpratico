import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiperpratico/src/models/store_model.dart';
import 'package:hiperpratico/src/pages/home/controller/home_controller.dart';
import 'package:hiperpratico/src/routes/app_pages.dart';
import 'package:hiperpratico/src/services/utils.services.dart';


class StoreTile extends StatefulWidget {
  final StoreModel store;

  const StoreTile({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  State<StoreTile> createState() => _StoreTileState();
}

class _StoreTileState extends State<StoreTile> {
  final UtilsServices utilsServices = UtilsServices();
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            homeController.setStoreId(widget.store.id);
            Get.toNamed(PagesRoutes.homeStore);
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
                    tag: widget.store.imageUrl,
                    child: Image.network(
                      widget.store.imageUrl,
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
                          child: Text(widget.store.name),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'De ${utilsServices.formatHours(
                            widget.store.startService,
                          )} às ${utilsServices.formatHours(
                            widget.store.endService,
                          )}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: widget.store.open
                            ? const Text(
                                'Aberto',
                                style: TextStyle(
                                  color: Colors.green,
                                ),
                              )
                            : const Text(
                                'Fechado',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 10),
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
                            homeController.setStoreId(widget.store.id);
                            Get.toNamed(
                              PagesRoutes.homeStore,
                            );
                          },
                          label: const Text(
                            'Entrar',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          icon: const Icon(
                            Icons.storefront_outlined,
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
        ),
      ],
    );
  }
}
