import 'package:flutter/material.dart';

class BackVoid extends StatelessWidget {
  BackVoid(this.callbackTrans, {super.key});
  Map<String, void Function(bool)> callbackTrans;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Image.asset(
            "assets/image/water_texture.gif",
            fit: BoxFit.cover,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black.withOpacity(0.8),
                Colors.blueGrey.withOpacity(0.5),
                Colors.white.withOpacity(0.4),
              ],
            ),
          ),
        ),
        TouchPad(callbackTrans),
      ],
    );
  }
}

class TouchPad extends StatelessWidget {
  TouchPad(this.callbackTrans, {super.key});
  Map<String, void Function(bool)> callbackTrans;

  void turnOnOff(DragUpdateDetails details) {
    if (details.delta.dy > 5) {
      callbackTrans["turnOnOff"]!(false);
    } else if (details.delta.dy < -5) {
      callbackTrans["turnOnOff"]!(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (DragUpdateDetails details) {
        turnOnOff(details);
      },
    );
  }
}
