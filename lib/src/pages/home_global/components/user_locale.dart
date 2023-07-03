import 'package:flutter/material.dart';

class UserLocale extends StatelessWidget {
  const UserLocale({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  'Rua Francisca Madalena 365',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xFFFF0000),
                  size: 24,
                ),
              ],
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              width: 100,
              child: Stack(
                children: [
                  const Align(
                    alignment: AlignmentDirectional(0.84, 0),
                    child: Icon(
                      Icons.notifications,
                      color: Colors.redAccent,
                      size: 24,
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0.92, 0),
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF0000),
                        shape: BoxShape.circle,
                      ),
                      child: const Text(
                        '4',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Readex Pro',
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
