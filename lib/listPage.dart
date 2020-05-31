import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shoppinglist/models/foodItems.dart';
import 'package:shoppinglist/models/userList.dart';


Map categories = {};

class ListPage extends StatefulWidget {
  final UserList userList;

  ListPage(this.userList);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userList.title ?? "No title"),
      ),

      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return Text(categories.length.toString());
            //  _buildCategory(categories[index]);
          }
        )
      ),

      floatingActionButton: MyFloatingActionButton()
    );  
  }

  Widget _buildCategory(Map category){
    return Container(
      child: Column(
        children: [
          Container(child: Text(category[0],))
        ],
      ),
    );
  }
}

class MyFloatingActionButton extends StatefulWidget {
  
  @override
  _MyFloatingActionButtonState createState() => _MyFloatingActionButtonState();
}

class _MyFloatingActionButtonState extends State<MyFloatingActionButton> {
    Map db = {
    "Poultry": ["Fish", "Meat","Chicken"],
    "Grains": ["Rice", "Garri", "Beans"]
  };
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _controller = new TextEditingController();

  

  addItem(FoodItem item){
    if (categories.containsKey(item.category)){
      List<String> po = categories[item.category];
      po.add(item.name);
      categories.update(item.category, (value) => po);
    }
    else{
      List<String> no = [item.name];
      categories[item.category] = no;
    }
    print(categories);
    setState(() {
      
    });
  }

    containItem(Map db, String food){
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
  Widget build(BuildContext context) {
    
    String name;
    return FloatingActionButton(
      onPressed: () {
        showBottomSheet(
            context: context,
            builder: (context) => 
            Container(
            padding: EdgeInsets.all(20),
            child: Form(
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
                      String cat = containItem(db, name);
                       FoodItem foodItem = FoodItem(name: name, category: cat); 
                      addItem(foodItem);
                      Navigator.pop(context);
                  
                    },
                  )
                ],
              ),
            ),
          ),
        );
        setState(() {
        
        });
      },
    );
  }
}

  
  
