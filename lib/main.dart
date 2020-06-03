import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppinglist/models/user.dart';
import 'package:shoppinglist/allLists.dart';
import 'package:shoppinglist/testdatabase.dart';
import 'package:shoppinglist/textSearch.dart';
import 'package:shoppinglist/voicerec.dart';

void main() {
  runApp(
    MyApp(),
    // MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(create: (context) => User()),
    //   ],
      
    // )    
    );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: 
      // VoiceRec()
      // TestSearch()
      Testing()
      // AllList(),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:speech_recognition/speech_recognition.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: VoiceHome(),
//     );
//   }
// }

// class VoiceHome extends StatefulWidget {
//   @override
//   _VoiceHomeState createState() => _VoiceHomeState();
// }

// class _VoiceHomeState extends State<VoiceHome> {
//   SpeechRecognition _speechRecognition;
//   bool _isAvailable = false;
//   bool _isListening = false;

//   String resultText = "";

//   @override
//   void initState() {
//     super.initState();
//     initSpeechRecognizer();
//     print('available - $_isAvailable');
//     print("listening - $_isListening");
//   }

//   void initSpeechRecognizer() {
//     _speechRecognition = SpeechRecognition();

//     _speechRecognition.setAvailabilityHandler(
//       (bool result) => setState(() => _isAvailable = result),
//     );

//     _speechRecognition.setRecognitionStartedHandler(
//       () => setState(() => _isListening = true),
//     );

//     _speechRecognition.setRecognitionResultHandler(
//       (String speech) => setState(() => resultText = speech),
//     );

//     _speechRecognition.setRecognitionCompleteHandler(
//       () => setState(() => _isListening = false),
//     );

//     _speechRecognition.activate().then(
//           (result) => setState(() => _isAvailable = result),
//         );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 FloatingActionButton(
//                   child: Icon(Icons.cancel),
//                   mini: true,
//                   backgroundColor: Colors.deepOrange,
//                   onPressed: () {
//                     print(_isListening);
//                     print("cancel");
//                     if (_isListening)
//                       _speechRecognition.cancel().then(
//                             (result) => setState(() {
//                                     print("cancel $_isListening");
//                                   _isListening = result;
//                                   resultText = "";
//                                 }),
//                           );
//                   },
//                 ),
//                 FloatingActionButton(
//                   child: Icon(Icons.mic),
//                   onPressed: () {
//                     print(_isAvailable);
//                     print(_isListening);
//                     if (_isAvailable && !_isListening)
//                       _speechRecognition
//                           .listen(locale: "en_US")
//                           .then((result) => print('$result'));
//                   },
//                   backgroundColor: Colors.pink,
//                 ),
//                 FloatingActionButton(
//                   child: Icon(Icons.stop),
//                   mini: true,
//                   backgroundColor: Colors.deepPurple,
//                   onPressed: () {
//                     print(_isListening);
//                     print("Stop");
//                     if (_isListening)
//                       _speechRecognition.stop().then(
//                             (result) => setState(() => _isListening = result),
//                           );
//                   },
//                 ),
//               ],
//             ),
//             Container(
//               width: MediaQuery.of(context).size.width * 0.8,
//               decoration: BoxDecoration(
//                 color: Colors.cyanAccent[100],
//                 borderRadius: BorderRadius.circular(6.0),
//               ),
//               padding: EdgeInsets.symmetric(
//                 vertical: 8.0,
//                 horizontal: 12.0,
//               ),
//               child: Text(
//                 resultText,
//                 style: TextStyle(fontSize: 24.0),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
