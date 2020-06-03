// class ListSearch extends StatefulWidget{
//   @override
//   State createState() {
//     // TODO: implement createState
//     return ListSearchState();
//   }

// }

// class ListSearchState extends State{
//   List _listWidgets=List();
//   List _listSearchWidgets=List();
//   SpeechRecognition _speech;
//   bool _speechRecognitionAvailable = false;
//   bool _isListening = false;
//   bool _isSearch = false;

//   String transcription = '';

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _listWidgets.add("Text");
//     _listWidgets.add("RaisedButton");
//     _listWidgets.add("FlatButton");
//     _listWidgets.add("Container");
//     _listWidgets.add("Center");
//     _listWidgets.add("Padding");
//     _listWidgets.add("AppBar");
//     _listWidgets.add("Scaffold");
//     _listWidgets.add("MaterialApp");

//     _listSearchWidgets.addAll(_listWidgets);
//     activateSpeechRecognizer();
//   }
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return MaterialApp(
//       theme: ThemeData(
//           primaryColor: Colors.pink
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Search By Voice'),
//           centerTitle: true,
//           actions: [
//             _buildVoiceInput(
//               onPressed: _speechRecognitionAvailable && !_isListening
//                   ? () => start()
//                   : () => stop(),
//               label: _isListening ? 'Listening...' : '',
//             ),


//           ],
//         ),
//         body: ListView.builder(
//             itemCount: _listSearchWidgets.length,
//             itemBuilder: (ctx,pos){
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Card(
//               child: ListTile(
//                 leading: Icon(Icons.description,color: Colors.pink,),
//                 title: Text("${_listSearchWidgets[pos]}"),
//               ),
//             ),
//           );
//         }),

//       ),
//     );
//   }
//   Widget _buildVoiceInput({String label, VoidCallback onPressed}){
//     return  Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Row(
//           children: [
//             FlatButton(
//               child: Text(
//                 label,
//                 style: const TextStyle(color: Colors.white),
//               ),
//             ),
//             IconButton(
//               icon: Icon(Icons.mic),
//               onPressed: onPressed,
//             ),
//             (_isSearch)?IconButton(
//               icon: Icon(Icons.clear),
//               onPressed: (){
//                 setState(() {
//                   _isSearch=false;
//                   _listSearchWidgets.clear();
//                   _listSearchWidgets.addAll(_listWidgets);
//                 });

//               },
//             ):Text(""),
//           ],
//         ));
//   }


//   void activateSpeechRecognizer() {
//     requestPermission();

//     _speech = new SpeechRecognition();
//     _speech.setAvailabilityHandler((result){
//       setState(() {
//         _speechRecognitionAvailable = result;
//       });
//     });
//     _speech.setCurrentLocaleHandler(onCurrentLocale);
//     _speech.setRecognitionStartedHandler(onRecognitionStarted);
//     _speech.setRecognitionResultHandler(onRecognitionResult);
//     _speech.setRecognitionCompleteHandler(onRecognitionComplete);
//     _speech
//         .activate()
//         .then((res) => setState(() => _speechRecognitionAvailable = res));
//   }

//   void start(){
//     _isSearch=true;
//     _speech
//         .listen(locale: 'en_US')
//         .then((result) {
//       print('Started listening => result $result');
//     }
//     );

//   }

//   void cancel() {
//     _speech.cancel().then((result) {
//       setState(() {
//         _isListening = result;
//       }
//       );
//     });
//   }


//   void stop() {
//     _speech.stop().then((result) {
//       setState(() {
//         _isListening = result;
//       });
//     });
//   }

//   void onSpeechAvailability(bool result) =>
//       setState(() => _speechRecognitionAvailable = result);

//   void onCurrentLocale(String locale) =>
//       setState(() => print("current locale: $locale"));

//   void onRecognitionStarted() => setState(() => _isListening = true);

//   void onRecognitionResult(String text) {
//     setState(() {
//       transcription = text;
//       _listSearchWidgets.clear();
//       for(String k in _listWidgets)
//         {
//           if(k.toUpperCase().contains(text.toUpperCase()))
//             _listSearchWidgets.add(k);
//         }
//       //stop(); //stop listening now
//     });
//   }

//   void onRecognitionComplete() => setState(() => _isListening = false);

//   void requestPermission() async {
//     PermissionStatus permission = await PermissionHandler()
//         .checkPermissionStatus(PermissionGroup.microphone);

//     if (permission != PermissionStatus.granted) {
//       await PermissionHandler()
//           .requestPermissions([PermissionGroup.microphone]);
//     }
//   }
//   // void requestPermission() async {
//   //   if (await Permission.microphone.request().isGranted) {
      
//   //   }
// }

// class MyFloatingActionButton extends StatelessWidget  {
//   final UserList userList;
//   MyFloatingActionButton(this.userList);
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _controller = new TextEditingController();

//   @override
//   Widget build(BuildContext context) {  
//     String name;
//     return FloatingActionButton(
//       onPressed: () {
//         showBottomSheet(
//           backgroundColor: Colors.cyanAccent,
//           context: context,
//           builder: (context) => Container(
//             padding: EdgeInsets.all(20),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   TextFormField(
//                     controller: _controller,
//                     onChanged: (value) {
//                       name = value;
//                     },
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.check) ,
//                     onPressed: () async{  
//                       _controller.clear();
//                       UserList _userList = UserList(
//                         id: userList.id,
//                         listName: userList.listName,
//                         listItems: userList.listItems == null ? name : userList.listItems + ",$name",
//                         );
//                       await DatabaseService().updateUserList(_userList);
//                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> TestPage(_userList)));
//                     },
//                   )
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }





