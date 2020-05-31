import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppinglist/models/user.dart';
import 'package:shoppinglist/allLists.dart';
import 'package:shoppinglist/testdatabase.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => User()),
      ],
      child: MyApp(),
    )
    
    );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Testing()
      // AllList(),
    );
  }
}