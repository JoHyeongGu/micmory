import 'dart:async';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:micmory/memory_save/list_paper.dart';
import 'package:micmory/backvoid.dart';
import 'package:micmory/search.dart';
import 'package:micmory/logo.dart';

void main() {
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
  Map callbackTrans = {};
  SpeechToText speechToText = SpeechToText();
  bool speechEnabled = false;
  String savedTalk = "";

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
    await checkMicPermission();
    speechEnabled = await speechToText.initialize();
    if (speechEnabled) {
      startSpeechToTxt();
    }
  }

  void startSpeechToTxt() async {
    // turn on the listening when it's finished.
    while (true) {
      if (speechToText.isNotListening) {
        await speechToText.listen(onResult: onSpeechResult, localeId: "ko_KR");
      }
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      if (result.finalResult) {
        savedTalk += "${result.recognizedWords}\n";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackVoid(callbackTrans),
          Contents(savedTalk: savedTalk),
          ListPaper(callbackTrans),
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
          Container(
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
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SingleChildScrollView(
                      reverse: true,
                      child: Text(
                        widget.savedTalk.trim(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
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
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(15)),
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
          ),
        ],
      ),
    );
  }
}
