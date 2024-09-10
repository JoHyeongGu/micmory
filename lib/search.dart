import 'dart:math';
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
                color: Color.fromRGBO(135, 135, 135, 1.0),
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: InputBar(),
            ),
          ),
        ],
      ),
    );
  }
}

class InputBar extends StatefulWidget {
  InputBar({super.key});

  @override
  State<InputBar> createState() => _InputBarState();
}

class _InputBarState extends State<InputBar> {
  TextEditingController controller = TextEditingController();
  List<String> hintList = [
    "What is the talk you're finding?",
    "Find your talk with the topic.",
    "What did you say?",
    "What was your opinion about it?",
  ];
  String selectedHint = "";

  @override
  void initState() {
    super.initState();
    selectedHint = hintList[Random().nextInt(hintList.length)];
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorHeight: 20,
      style: const TextStyle(
        fontWeight: FontWeight.normal,
      ),
      decoration: InputDecoration(
        hintText: selectedHint,
        hintStyle: const TextStyle(
          fontSize: 15,
          color: Color.fromRGBO(181, 181, 181, 1.0),
        ),
        border: InputBorder.none,
      ),
    );
  }
}
