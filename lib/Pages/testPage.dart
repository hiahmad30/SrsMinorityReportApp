import 'package:flutter/material.dart';

Widget categoriesList() {
  return ListView(
    padding: const EdgeInsets.all(8),
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 50,
          color: Colors.amber[600],
          child: const Center(child: Text('Rasturent')),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 50,
          color: Colors.amber[500],
          child: const Center(
            child: Text('Police Officer'),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {},
          child: Container(
            height: 50,
            color: Colors.amber[100],
            child: const Center(
              child: Text(
                'Trading',
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
