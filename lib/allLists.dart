import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppinglist/listPage.dart';
import 'package:shoppinglist/models/user.dart';
import 'package:shoppinglist/models/userList.dart';

class AllList extends StatefulWidget {
  @override
  _AllListState createState() => _AllListState();
}

class _AllListState extends State<AllList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<User>(
      builder: (context, lists, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("All Lists"),
            backgroundColor: Colors.lightBlue,
          ),

          body: lists.totalItems > 0 ? ListView.builder(
            itemCount: lists.totalItems,
            itemBuilder: (BuildContext context, int index){
              return ListTile(lists.userList[index]); 
            }
          ): Container(child: Text("Add List"),),

          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
              MaterialPageRoute(builder: 
              (context) =>  ListForm()));
              
            },
          ),
        );

      },
    );  
  }

}


class  ListForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    String name;
    return Consumer<User>(
      builder: (context, lists, child) {
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
                    UserList userList = UserList(name ?? "No Name");
                    lists.add(userList);
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
class ListTile extends StatelessWidget {
  final UserList userList;

  ListTile(this.userList);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ListPage(userList)),
      ),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(userList.title), SizedBox(width: 10,),
          ],
        ),
      ),
    );
  }
}

