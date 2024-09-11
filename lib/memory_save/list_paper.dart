import 'package:flutter/material.dart';
import 'package:micmory/search.dart';

class ListPaper extends StatefulWidget {
  ListPaper(this.metaData, {super.key});
  Map metaData;

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
    widget.metaData["turnOnOff"] = turnOnOff;
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
              Flexible(child: Contents(widget.metaData)),
            ],
          ),
        ),
      ),
    );
  }
}

class Contents extends StatefulWidget {
  Contents(this.metaData, {super.key});
  Map metaData;

  @override
  State<Contents> createState() => _ContentsState();
}

class _ContentsState extends State<Contents> {
  late List dataList;

  @override
  void initState() {
    super.initState();
    dataList = widget.metaData["storage"].getKeys().toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SingleChildScrollView(
        child: Column(
          children: dataList
              .map(
                (key) => DateTile(
                  widget.metaData,
                  date: key,
                  text: widget.metaData["storage"].read(key),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class DateTile extends StatelessWidget {
  DateTile(this.metaData, {super.key, required this.date, required this.text});
  Map metaData;
  String date;
  String text;

  String previewText () {
    List<String> lines = text.split('\n');
    List<String> previewLine = lines.length > 5
        ? lines.sublist(lines.length - 5)
        : lines;
    return previewLine.join('\n');
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
          Align(
            alignment: Alignment.centerLeft,
            child: Text(date),
          ),
          const SizedBox(height: 5),
          Container(
            color: Colors.blueGrey.withOpacity(0.4),
            height: 100,
            width: double.infinity,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(5),
                splashColor: Colors.blueGrey.withOpacity(0.3),
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(previewText()),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
