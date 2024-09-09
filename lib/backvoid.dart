import 'package:flutter/material.dart';

class BackVoid extends StatelessWidget {
  BackVoid(this.callbackTrans, {super.key});
  Map<String, void Function(bool)> callbackTrans;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: TouchPad(callbackTrans),
    );
  }
}

class TouchPad extends StatelessWidget {
  TouchPad(this.callbackTrans, {super.key});
  Map<String, void Function(bool)> callbackTrans;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (DragUpdateDetails details) {
        if (details.delta.dy > 0) {
          callbackTrans["turnOnOff"]!(false);
        } else if (details.delta.dy < 0) {
          callbackTrans["turnOnOff"]!(true);
        }
      },
    );
  }
}