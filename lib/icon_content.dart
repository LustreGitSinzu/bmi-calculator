import 'package:flutter/material.dart';

class IconContent extends StatelessWidget {
  IconContent({this.iconB, this.iconName});

  IconData? iconB;
  String? iconName;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          iconB,
          size: 80.0,
          color: Colors.white70,
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          iconName.toString(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        )
      ],
    );
  }
}
