import 'package:flutter/material.dart';

AppBar buildAppBar() => AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Seu endereço: ',
            style: TextStyle(
              fontSize: 14,
              color: Colors.orange,
            ),
          ),
          //Icon(Icons.location_on, size: 15, color: Colors.orange),
          Text(
            'Rua Francisca Madalena -',
            style: TextStyle(
              fontSize: 12,
              color: Colors.orange,
            ),
          ),
          Text(
            ' Alterar',
            style: TextStyle(
              fontSize: 12,
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
