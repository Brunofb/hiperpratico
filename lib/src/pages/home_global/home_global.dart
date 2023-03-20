import 'package:flutter/material.dart';
import 'package:hiperpratico/src/pages/home_global/components/app_bar.dart';
import 'package:hiperpratico/src/pages/home_global/components/best_sellers.dart';
import 'package:hiperpratico/src/pages/store/view/store_category_list.dart';
import 'package:hiperpratico/src/pages/home_global/components/sales.dart';
import 'package:hiperpratico/src/pages/home_global/components/search.dart';

class HomePageGlobal extends StatelessWidget {
  const HomePageGlobal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration:  const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white,
                        Colors.white,
                      ])),
              child: Column(
                children: [
                  //...buildHeader(),
                  buildSearchBar(),
                  buildCategoryList(),
                ],
              ),
            ),
            const BuildBookList(),
            BuildNewBook(),
          ],
        ),
      ),
      extendBody: true,
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //floatingActionButton: BuildFAB(),
      //bottomNavigationBar: buildNavigationBar(),
    );
  }
}
