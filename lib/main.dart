import 'dart:async';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
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
  SpeechToText speechToText = SpeechToText();
  bool speechEnabled = false;
  String lastWords = '';

  Map<String, void Function(bool)> callbackTrans = {};

  @override
  void initState() {
    super.initState();
    initSpeech();
    callbackTrans["turnListening"] = turnListening;
    print(callbackTrans);
  }

  void initSpeech() async {
    try {
      late var permission;
      while (true) {
        permission = await Permission.microphone.request();
        if (permission == PermissionStatus.granted) break;
        await Future.delayed(Duration(seconds: 1));
      }
      if (permission == PermissionStatus.granted) {
        speechEnabled = await speechToText.initialize();
        if (speechEnabled) {
          await speechToText.listen(
            onResult: onSpeechResult,
            localeId: "ko_KR",
            pauseFor: Duration(minutes: 30),
          );
        }
      } else {
        print('Error: microphone permission denied');
      }
    } catch (e) {
      print('Error: $e');
    }
    print("Complete init speech");
    print("$speechToText / $speechEnabled / $lastWords");
  }

  void turnListening(bool _turn) async {
    if (_turn) {
      print(speechToText);
      await speechToText.listen(
          onResult: onSpeechResult, listenMode: ListenMode.dictation);
      print("Start Listening");
    } else {
      await speechToText.stop();
      print("Stop Listening");
    }
    print("$speechToText / $speechEnabled / $lastWords");
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
    print("SpeechResult!!");
    print(
        "$speechToText / $speechEnabled / $lastWords / ${speechToText.isListening}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackVoid(callbackTrans),
          Contents(callbackTrans),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 280,
                left: 30,
                right: 30,
              ),
              child: Text(
                '"' + lastWords + '"',
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          ListPaper(callbackTrans),
        ],
      ),
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
  void test() {
    if (widget.callbackTrans["turnListening"] != null) {
      widget.callbackTrans["turnListening"]!(true);
    } else {
      print("cant find turnListening");
    }
  }

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
            callback: test,
          ),
        ],
      ),
    );
  }
}
