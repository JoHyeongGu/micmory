import 'package:flutter/material.dart';

class ListPaper extends StatefulWidget {
  ListPaper(this.callbackTrans, {super.key});
  Map<String, void Function(bool)> callbackTrans;

  @override
  State<ListPaper> createState() => _ListPaperState();
}

class _ListPaperState extends State<ListPaper> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Contents(widget.callbackTrans),
      ],
    );
  }
}

class Contents extends StatefulWidget {
  Contents(this.callbackTrans, {super.key});
  Map<String, void Function(bool)> callbackTrans;

  @override
  State<Contents> createState() => _ContentsState();
}

class _ContentsState extends State<Contents> {
  late bool turn;

  void turnOnOff(bool _turn) {
    if (turn == _turn) return;
    print(_turn);
    setState(() {
      turn = _turn;
    });
  }

  @override
  void initState() {
    super.initState();
    turn = false;
    widget.callbackTrans["turnOnOff"] = turnOnOff;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 200),
      padding: turn
          ? const EdgeInsets.symmetric(horizontal: 30, vertical: 80)
          : EdgeInsets.only(top: MediaQuery.of(context).size.height),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 7,
            )
          ],
        ),
      ),
    );
  }
}
