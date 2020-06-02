import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppinglist/models/user.dart';
import 'package:shoppinglist/allLists.dart';
import 'package:shoppinglist/testdatabase.dart';
import 'package:shoppinglist/textSearch.dart';

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
      // TestSearch()
      Testing()
      // AllList(),
    );
  }
}