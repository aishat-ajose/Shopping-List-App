import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shoppinglist/test2.dart';

import 'database.dart';

class Testing extends StatefulWidget {
  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            IconButton(
              icon: Icon(Icons.create), 
              onPressed: (){
                Random random = Random();
                List<String> items = ["Garri", "Tomato", "Rice", "Sugar", "potato", "Fish", "Test"];
                String otem = items.join(",");
                print(otem.split(","));
                UserList userList = UserList(
                  listItems: otem,
                  listName: "Tuu",
                  id: random.nextInt(1000)                 
                );
                DatabaseService().createUserList(userList);
                setState(() {});
              },
            ),
            
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: (){
                DatabaseService().deleteUserLists();
                setState(() {});
              },
            ),

            Container(
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.all(style: BorderStyle.solid)
              ),
              height: MediaQuery.of(context).size.height - 200,
              child: FutureBuilder(
                future: DatabaseService().getUserLists(),
                builder: (context, snapshot){
                  return snapshot.data == null ? Container(child: Text("No data"),): ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (cotext, index){
                      return _buildList(index, snapshot.data[index]);
                    }
                  );
                },
              ),
            )
          ],
        ),
        
      ),
    );
  }

  Widget _buildList(int index, UserList userlist){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: (){
              Navigator.push(context, 
              MaterialPageRoute(builder: (context) => TestPage(userlist))
              );
            },
            child: Row(
              children: [
                Text((index+1).toString() + "."),
                SizedBox(width: 15,),
                Text(userlist.id.toString(), style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),),
              ],
            ),
          ),

          SizedBox(height: 20,),
        ],
      );
  }
}