import 'package:flutter/material.dart';

class CategoryComponentWidget extends StatefulWidget {
  const CategoryComponentWidget({
    Key? key,
    required this.categoryName,
    required this.categoryImage,
  }) : super(key: key);

  final String? categoryName;
  final String? categoryImage;

  @override
  _CategoryComponentWidgetState createState() =>
      _CategoryComponentWidgetState();
}

class _CategoryComponentWidgetState extends State<CategoryComponentWidget> {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            widget.categoryImage!,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        Text(
          widget.categoryName!,
          style: const TextStyle(
            fontFamily: 'Readex Pro',
            fontSize: 12,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}
