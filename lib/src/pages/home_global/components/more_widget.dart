import 'package:flutter/material.dart';

class MoreWidget extends StatelessWidget {
  MoreWidget({
    required this.primaryTitle,
    required this.secondaryTitle,
    super.key,
  });

  String primaryTitle;
  String secondaryTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 5, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            primaryTitle,
            style: const TextStyle(
              fontFamily: 'Outfit',
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            secondaryTitle,
            style: const TextStyle(
              fontFamily: 'Readex Pro',
              color: Color(0xFFFF0000),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}