import 'package:flutter/material.dart';
import 'package:micmory/search.dart';

class ListPaper extends StatefulWidget {
  ListPaper(this.callbackTrans, {super.key});
  Map callbackTrans;

  @override
  State<ListPaper> createState() => _ListPaperState();
}

class _ListPaperState extends State<ListPaper> {
  late bool turn;

  void turnOnOff(bool _turn) {
    if (turn == _turn) return;
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
    return WillPopScope(
      onWillPop: () async {
        if (turn) {
          setState(() {
            turn = false;
          });
          return false;
        } else {
          return true;
        }
      },
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 150),
        padding: turn
            ? const EdgeInsets.symmetric(horizontal: 30, vertical: 80)
            : EdgeInsets.only(top: MediaQuery.of(context).size.height),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7),
            boxShadow: const [
              BoxShadow(
                color: Colors.blueGrey,
                blurRadius: 5,
              )
            ],
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Search(height: 30, width: double.infinity),
              const Flexible(child: Contents()),
            ],
          ),
        ),
      ),
    );
  }
}

class Contents extends StatefulWidget {
  const Contents({super.key});

  @override
  State<Contents> createState() => _ContentsState();
}

class _ContentsState extends State<Contents> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            DateTile(
              date: DateTime(2024, 9, 7),
            ),
            DateTile(
              date: DateTime(2024, 9, 6),
            ),
            DateTile(
              date: DateTime(2024, 9, 5),
            ),
            DateTile(
              date: DateTime(2024, 9, 4),
            ),
            DateTile(
              date: DateTime(2024, 9, 3),
            ),
            DateTile(
              date: DateTime(2024, 9, 2),
            ),
          ],
        ),
      ),
    );
  }
}

class DateTile extends StatelessWidget {
  DateTile({super.key, required this.date});
  DateTime date;

  String strDate() {
    return date.toString().split(" ")[0];
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey,
            spreadRadius: 1,
            blurRadius: 3,
          ),
        ],
      ),
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20, top: 10),
      child: Column(
        children: [
          Align(alignment: Alignment.centerLeft, child: Text(strDate())),
          const SizedBox(height: 5),
          Container(
            color: Colors.blueGrey.withOpacity(0.4),
            height: 100,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(5),
                splashColor: Colors.blueGrey.withOpacity(0.3),
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
