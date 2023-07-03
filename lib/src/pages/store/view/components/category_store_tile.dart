import 'package:flutter/material.dart';

class CategoryStoreTile extends StatelessWidget {
  const CategoryStoreTile({
    Key? key,
    required this.category,
    required this.isSelected,
    required this.onPressed,
    required this.imageUrl,
  }) : super(key: key);

  final String category;
  final bool isSelected;
  final VoidCallback onPressed;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        width: 90,
        child: Column(
          children: [
            // CircleAvatar(
            //   backgroundImage: NetworkImage(imageUrl),
            // ),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              category,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
