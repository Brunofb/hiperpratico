
import 'package:flutter/material.dart';

import '../../config/custom_colors.dart';

class AppNameWidget extends StatelessWidget {

  final Color? orangeTitleColor;
  final double textSize;

  const AppNameWidget({
    Key? key,
    this.orangeTitleColor,
    this.textSize = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: TextStyle(
          fontSize: textSize,
        ),
        children: [
          TextSpan(
            text: 'Hiper',
            style: TextStyle(
              color: orangeTitleColor ?? CustomColors.customSwatchColor,
            ),
          ),
          TextSpan(
            text: 'Prático',
            style: TextStyle(
              color: CustomColors.customContrastColor,
            ),
          ),
        ],
      ),
    );
  }
}
