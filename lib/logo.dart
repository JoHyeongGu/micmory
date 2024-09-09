import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  Logo({
    super.key,
    this.size = 30,
    this.top = 0,
    this.bottom = 0,
    this.left = 0,
    this.right = 0,
  });
  double size;
  double top, bottom, left, right;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: top,
        bottom: bottom,
        left: left,
        right: right,
      ),
      child: Column(
        children: [
          Icon(
            Icons.edit_note,
            size: size,
            color: Colors.white,
          ),
          const Text(
            "MICMORY",
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
              letterSpacing: 10,
            ),
          ),
        ],
      ),
    );
  }
}
