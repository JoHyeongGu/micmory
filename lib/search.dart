import 'dart:ui';

import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  VoidCallback callback;
  double height, width;
  double top, bottom, left, right;

  Search({
    super.key,
    required this.height,
    required this.width,
    this.top = 0,
    this.bottom = 0,
    this.left = 0,
    this.right = 0,
    this.callback = defaultCallback,
  });

  static void defaultCallback() {
    print("Search execute");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: top,
        bottom: bottom,
        left: left,
        right: right,
      ),
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            highlightColor: Colors.transparent,
            padding: EdgeInsets.only(top: 1, right: 3),
            onPressed: callback,
            icon: Icon(
              Icons.search,
              size: height - 7,
            ),
          )
        ],
      ),
    );
  }
}
