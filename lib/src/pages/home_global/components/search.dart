import 'package:flutter/material.dart';
import 'package:hiperpratico/src/pages/home_global/components/constants.dart';

Widget buildSearchBar() => Padding(
  padding: const EdgeInsets.all(2 * Constants.kPadding),
  child: TextField(
    decoration: InputDecoration(
      hintText: "Buscar produto",
      fillColor: Colors.black.withOpacity(0.1),
      filled: true,
      prefixIcon: const Icon(Icons.search),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 0.0,
        horizontal: Constants.kPadding,
      ),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide.none
      ),
    ),
  ),
);
