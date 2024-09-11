import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:micmory/memory_save/list_paper.dart';
import 'package:micmory/backvoid.dart';
import 'package:micmory/search.dart';
import 'package:micmory/logo.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MICMORY',
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Map metaData = {
    "speechToText": SpeechToText(),
    "storage": GetStorage(),
    "strDate": (DateTime date, {bool time = false}) =>
        date.toString().split(" ")[time ? 1 : 0].split(".")[0],
  };

  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  Future checkMicPermission() async {
    PermissionStatus permission = await Permission.microphone.request();
    while (true) {
      if (permission == PermissionStatus.granted) return;
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  void initSpeech() async {
    String key = metaData["strDate"](DateTime.now());
    if (metaData["storage"].read(key) == null) {
      metaData["storage"].write(key, "");
    }
    for (String key in metaData["storage"].getKeys()) {
      print(key);
    }
    await checkMicPermission();
    if (await metaData["speechToText"].initialize()) {
      startSpeechToTxt();
    }
  }

  void startSpeechToTxt() async {
    // turn on the listening when it's finished.
    while (true) {
      if (metaData["speechToText"].isNotListening) {
        await metaData["speechToText"]
            .listen(onResult: onSpeechResult, localeId: "ko_KR");
      }
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      if (result.finalResult) {
        String key = metaData["strDate"](DateTime.now());
        print("today's key : $key");
        String todayTalk = metaData["storage"].read(key) +
            "${metaData["strDate"](DateTime.now(), time: true)} - ${result.recognizedWords}\n";
        metaData["storage"].write(key, todayTalk);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackVoid(metaData),
          Contents(
              savedTalk: metaData["storage"]
                  .read(metaData["strDate"](DateTime.now()))),
          ListPaper(metaData),
        ],
      ),
    );
  }
}

class Contents extends StatefulWidget {
  Contents({super.key, required this.savedTalk});
  String savedTalk;

  @override
  State<Contents> createState() => _ContentsState();
}

class _ContentsState extends State<Contents> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Logo(size: 120, bottom: 25),
          Search(
            height: 30,
            width: 270,
          ),
          NowRecord(widget.savedTalk),
        ],
      ),
    );
  }
}

class NowRecord extends StatefulWidget {
  NowRecord(this.savedTalk, {super.key});
  String savedTalk;

  @override
  State<NowRecord> createState() => _NowRecordState();
}

class _NowRecordState extends State<NowRecord> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 270,
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                reverse: true,
                child: Text(
                  widget.savedTalk.trim(),
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Opacity(
            opacity: 0.5,
            child: Container(
              height: 27,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              ),
              child: const Center(
                child: Icon(
                  Icons.mic,
                  size: 25,
                  color: Colors.blueGrey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
