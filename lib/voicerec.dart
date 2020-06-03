import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_recognition/speech_recognition.dart';


class VoiceRec extends StatelessWidget {
  final GlobalKey _scaffoldState=GlobalKey();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Scaffold(
        key: _scaffoldState,
        appBar: AppBar(title: Text("Voice Recognizer"),),
        body: Container(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RaisedButton(onPressed: (){
                  Navigator.push(_scaffoldState.currentContext, MaterialPageRoute(builder: (context) {
                    return SpeachRecognize();
                  }));

                },child: Text("Simple Speech",style: TextStyle(color: Colors.white,fontSize: 20),),color: Colors.pink,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SpeachRecognize extends StatefulWidget {

  @override
  _SpeachRecognizeState createState() => _SpeachRecognizeState();
}

class _SpeachRecognizeState extends State{
  SpeechRecognition _speech;
  bool _speechRecognitionAvailable = false;
  bool _isListening = false;

  String transcription = '';


  @override
  void initState() {
    super.initState();
    activateSpeechRecognizer();
    print("list - $_isListening");
    print("avali  - $_speechRecognitionAvailable");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.pink
      ),
      home: Scaffold(
          appBar: AppBar(
          title: Text('Speach To Text'),
      centerTitle: true,
      actions: [
          _buildVoiceInput(
          onPressed: _speechRecognitionAvailable && !_isListening
          ? () => start()
              : () => stop(),
          label: _isListening ? 'Listening...' : '',
          ),

      ],
      ),
        body: Center(
          child: Text((transcription.isEmpty)?"Speak to Record":"Your text is \n\n$transcription",textAlign: TextAlign.center,style: TextStyle(color: Colors.pink,fontSize: 20),),
        ),

      ),
    );

  }

  Widget _buildVoiceInput({String label, VoidCallback onPressed}){
   return  Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              child: Text(
                label,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            IconButton(
              icon: Icon(Icons.mic),
              onPressed: onPressed,
            ),
          ],
        ));
  }


  void activateSpeechRecognizer() {
    requestPermission();

    _speech = new SpeechRecognition();
    _speech.setAvailabilityHandler((result){
      setState(() {
        _speechRecognitionAvailable = result;
      });
    });
    _speech.setCurrentLocaleHandler(onCurrentLocale);
    _speech.setRecognitionStartedHandler(onRecognitionStarted);
    _speech.setRecognitionResultHandler(onRecognitionResult);
    _speech.setRecognitionCompleteHandler(onRecognitionComplete);
    _speech
        .activate()
        .then((res) => setState(() => _speechRecognitionAvailable = res));
  }

  void start(){
    _speech
        .listen(locale: 'en_US')
        .then((result) {
          print('Started listening => result $result');
      }
      );

  }

  void cancel() {
    _speech.cancel().then((result) {
      setState(() {
        _isListening = result;
      }
      );
    });
  }


  void stop() {
    _speech.stop().then((result) {
      setState(() {
        _isListening = result;
      });
    });
  }

  void onSpeechAvailability(bool result) =>
      setState(() => _speechRecognitionAvailable = result);

  void onCurrentLocale(String locale) =>
      setState(() => print("current locale: $locale"));

  void onRecognitionStarted() => setState(() => _isListening = true);

  void onRecognitionResult(String text) {
    setState(() {
      transcription = text;

      //stop(); //stop listening now
    });
  }

  void onRecognitionComplete() => setState(() => _isListening = false);

  void requestPermission() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.microphone);

    if (permission != PermissionStatus.granted) {
      await PermissionHandler()
          .requestPermissions([PermissionGroup.microphone]);
    }
  }
}



