import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiperpratico/src/models/icon_model.dart';
import 'package:hiperpratico/src/pages/home_global/components/constants.dart';
import 'package:hiperpratico/src/pages/store/controller/store_controller.dart';

final List<IconModel> headerImages = IconModel.icons;

Widget buildCategoryList() =>
    GetBuilder<StoreController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.only(bottom: Constants.kPadding),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              controller.allCategories.length,
              (index) => SizedBox(
                width: 90,
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        controller.allCategories[index].imageUrl,
                      ),
                    ),
                    Text(
                      controller.allCategories[index].name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
