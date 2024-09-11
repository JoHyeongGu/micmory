import 'package:flutter/material.dart';

class BackVoid extends StatelessWidget {
  BackVoid(this.metaData, {super.key});
  Map metaData;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Image.asset(
            "assets/image/gptWallpaper.png",
            fit: BoxFit.cover,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black.withOpacity(0.7),
                Colors.blueGrey.withOpacity(0.5),
                Colors.white.withOpacity(0.4),
              ],
            ),
          ),
        ),
        TouchPad(metaData),
      ],
    );
  }
}

class TouchPad extends StatelessWidget {
  TouchPad(this.metaData, {super.key});
  Map metaData;

  void turnOnOff(DragUpdateDetails details) {
    if (details.delta.dy > 5) {
      metaData["turnOnOff"]!(false);
    } else if (details.delta.dy < -5) {
      metaData["turnOnOff"]!(true);
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
