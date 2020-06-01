import 'package:flutter/material.dart';
import 'package:shoppinglist/database.dart';
import 'package:shoppinglist/models/foodItems.dart';


class TestPage extends StatefulWidget {
  final UserList userList;
  TestPage(this.userList);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {

  Map db = {
    "Poultry": ["Fish", "Meat","Chicken"],
    "Grains": ["Rice", "Garri", "Beans"]
  };

  List<String> items;
  Map categories = {};

  
  void getItems () async{
    UserList user= await DatabaseService().getUserList(widget.userList.id);
    
    setState(() {
      user == null ? items = null : user.listItems == null ? items=null: items = user.listItems.split(",");
      if (user.listItems != null && items.length > 0){
        items.forEach((element) {
        String cat = containItem(db, element);
        FoodItem foodItem = FoodItem(name: element, category: cat); 
        addItem(foodItem);
        });
      }
      
    });
  }

  void addItem(FoodItem item){
    if (categories.containsKey(item.category)){
      List<String> po = categories[item.category];
      po.add(item.name);
      categories.update(item.category, (value) => po);
    }
    else{
      List<String> no = [item.name];
      categories[item.category] = no;
    }
  }

  String containItem(Map db, String food){
    String result = "Uncategorized";   
    db.forEach((k, v) {
      List<String> value = v;
      if (value.contains(food)){
        result = k; 
      }
        
    });  
    return result;   
  }

  @override
  void initState() {
    getItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userList.listName),
      ),
      body:  Container(
        margin: EdgeInsets.symmetric(horizontal:25),
        child: items == null ? Container(child: Text("No data")) : categories == null ? Container(child: Text("No data"),) : ListView.builder(                
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: categories.length,
          itemBuilder: (context, index){
            String key = categories.keys.elementAt(index);
            return  _buildCategory(key, categories[key], widget.userList);
          }
        ),
      ),
      floatingActionButton: MyFloatingActionButton(widget.userList),
    );
  }

  Widget _buildCategory(String cat, List<String> items, UserList userList){
    return Container(
      child: Column(
        children: [
          Container(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(cat),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index){
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(items[index]),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async{ 
                            List<String> itemList = userList.listItems.split(",");
                            print(itemList);
                            itemList.remove(items[index]);
                            print("Deleted ${items[index]}");
                            print(itemList);
                            String ite = itemList.length > 0 ? itemList.join(","): null;
                            await DatabaseService().updateUserList(
                              UserList(
                              id: userList.id,
                              listName: userList.listName,
                              listItems: ite
                              )
                            );

                            UserList _userlist = await DatabaseService().getUserList(userList.id);
                            print(_userlist.listItems);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> TestPage(_userlist)));
                          },
                        )
                      ],
                    );
                  }
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}




class MyFloatingActionButton extends StatelessWidget  {
  final UserList userList;
  MyFloatingActionButton(this.userList);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {  
    String name;
    return FloatingActionButton(
      onPressed: () {
        showBottomSheet(
          backgroundColor: Colors.cyanAccent,
          context: context,
          builder: (context) => Container(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _controller,
                    onChanged: (value) {
                      name = value;
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.check) ,
                    onPressed: () async{  
                      _controller.clear();
                      UserList _userList = UserList(
                        id: userList.id,
                        listName: userList.listName,
                        listItems: userList.listItems == null ? name : userList.listItems + ",$name",
                        );
                      await DatabaseService().updateUserList(_userList);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> TestPage(_userList)));
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}





