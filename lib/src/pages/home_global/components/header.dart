import 'package:flutter/material.dart';
import 'package:hiperpratico/src/pages/home_global/components/constants.dart';

List<Widget> buildHeader() => [
  const Padding(
    padding: EdgeInsets.only(
      left: 2 * Constants.kPadding,
      top: Constants.kPadding,
    ),
    child: Text(
      "As melhores ofertas",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
    ),
  ),
  const Padding(
    padding: EdgeInsets.symmetric(
      horizontal: 2 * Constants.kPadding,
      vertical: Constants.kPadding,
    ),
    child: Text(
      "Tudo em um só lugar!",
      style: TextStyle(
        color: Colors.black54,
      ),
    ),
  ),
];
