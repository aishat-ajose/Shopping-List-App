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
          children: [
            SizedBox(height: 50),
            IconButton(
              icon: Icon(Icons.create), 
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ListForm()));
              //   Random random = Random();
              //   UserList userList = UserList(
              //     listName: "Tuu",
              //     id: random.nextInt(1000)                 
              //   );
              //   DatabaseService().createUserList(userList);
              //   setState(() {});
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
                Text(userlist.listName, style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),),
                SizedBox(width: 50,),
                Text(userlist.listItems== null ? "0": userlist.listItems.split(",").length.toString(), style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),),
                SizedBox(width: 50,),
                IconButton(icon: Icon(Icons.delete), onPressed: () {
                  setState(() {
                    DatabaseService().deleteUserList(userlist.id);
                  });
                } )
              ],
            ),
          ),

          SizedBox(height: 20,),
        ],
      );
  }
}

class  ListForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    String name;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _controller,
              onChanged: (value) {
                name = value;
              },
            ),
            IconButton(
              icon: Icon(Icons.check) ,
              onPressed: (){
                _controller.clear();
                Random random = Random();
                UserList userList = UserList(
                  listName: name,
                  id: random.nextInt(1000)                 
                );
                DatabaseService().createUserList(userList);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Testing()));
              },
            )
          ],
        ),
      ),
    );
  }
}