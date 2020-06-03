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
  TextEditingController _controller = TextEditingController();
  GlobalKey _scaffoldState=GlobalKey();

  String words;
  List<String> lis = ["Mango", "Fish", "Meat","Chicken","Rice", "Garri", "Beans"];
  List<String> filtered = [];

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
      key: _scaffoldState,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: Text(widget.userList.listName),
      ),
      body:  Column(
        children: [
          Container(
              color: Colors.blue,
              padding: EdgeInsets.all(10),
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.circular(15.0),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0
                  ),
                ),
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Flexible(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          fillColor: Colors.white,                    
                          filled: true,  
                          hintText: 'Search',
                          border: InputBorder.none
                        ),
                        onChanged: (String text){
                          
                          setState((){
                            if(text.length <= 0){filtered = null;}
                            else{
                              filtered = lis.where((element) { 
                              return element.toLowerCase().contains(text.toLowerCase());
                            }).toList();
                            }
                            
                          });
                          
                        }
                      ),
                    ),
                    IconButton(icon: Icon(Icons.keyboard_voice, color: Colors.black87,), onPressed: (){

                    }),
                    IconButton(icon: Icon(Icons.clear, color: Colors.black87,), onPressed: () =>_controller.clear()),
                    IconButton(icon: Icon(Icons.check, color: Colors.black87,), onPressed: (){
                      setState((){
                          filtered=null;
                          String name = _controller.text;
                          UserList _userList = UserList(
                            id: widget.userList.id,
                            listName: widget.userList.listName,
                            listItems: widget.userList.listItems == null ? name : widget.userList.listItems + ",$name",
                            );
                          DatabaseService().updateUserList(_userList);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> TestPage(_userList)));
                      });
                      _controller.clear();
                    }),
                  ],
                ),
              ),
          ),
          Stack(
            children: [
              Container(
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
              filtered != null && filtered.length > 0 ? Container(
                margin: EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width,
                height: 150,
                child: Card(
                  elevation: 20,
                  child: ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder:(context, index){
                      return  GestureDetector(
                        onTap: (){
                          UserList _userList = UserList(
                            id: widget.userList.id,
                            listName: widget.userList.listName,
                            listItems: widget.userList.listItems == null ? filtered[index] : widget.userList.listItems + ",${filtered[index]}",
                            );
                            filtered=null;
                          DatabaseService().updateUserList(_userList);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> TestPage(_userList)));
                        },
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(filtered[index])),
                      );
                    }
                  )
                ),
              ): Container()
            ],
            
          ),
        ],
      ),
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




