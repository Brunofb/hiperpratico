import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiperpratico/src/config/custom_colors.dart';
import 'package:hiperpratico/src/routes/app_pages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), (){
      Get.offNamed(PagesRoutes.signInRoute);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              CustomColors.customSwatchColor,
              CustomColors.customSwatchColor.shade700,
            ])),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // const AppNameWidget(
            //   textSize: 40,
            //   orangeTitleColor: Colors.white,
            // ),
            Padding(
              padding: const EdgeInsets.all(40),
              child: Image.asset(
                'assets/app_images/logo_branca.png',
                width: 150,
                height: 150,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
