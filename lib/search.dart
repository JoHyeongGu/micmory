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
          SizedBox(
            width: 30,
            child: IconButton(
              highlightColor: Colors.transparent,
              padding: const EdgeInsets.only(top: 1, left: 5),
              onPressed: callback,
              icon: Icon(
                Icons.search,
                size: height - 7,
              ),
            ),
          ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: TextFormField(
                cursorHeight: 22,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
