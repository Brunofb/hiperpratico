import 'package:flutter/material.dart';
import 'package:hiperpratico/src/config/custom_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

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
