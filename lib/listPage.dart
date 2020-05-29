import 'package:flutter/material.dart';
import 'package:shoppinglist/models/foodItems.dart';
import 'package:shoppinglist/models/userList.dart';

class ListPage extends StatefulWidget {
  final UserList userList;

  ListPage(this.userList);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = new TextEditingController();


  Map db = {
    "Poultry": ["Fish", "Meat","Chicken"],
    "Grains": ["Rice", "Garri", "Beans"]
  };

  @override
  Widget build(BuildContext context) {

    String name;
    FoodItem foodItem;
    Map categories = {}; 

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

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userList.title ?? "No title"),
      ),

      body: Container(
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
                  foodItem = FoodItem(name: name, category: cat); 
                  addItem(foodItem);
                  Navigator.pop(context);
              
                },
              )
            ],
          ),
        ),
      ),

      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: (){

      //     Navigator.push(context,
      //         MaterialPageRoute(builder: 
      //         (context) =>  addItem()));
      //     setState((){});
      //   },
      // ),
    );     
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
  
}

  
  

// class  ListForm extends StatefulWidget 
// {
//   @override
//   _ListFormState createState() => _ListFormState();
// }

// class _ListFormState extends State<ListForm> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _controller = new TextEditingController();


//   Map db = {
//     "Poultry": ["Fish", "Meat","Chicken"],
//     "Grains": ["Rice", "Garri", "Beans"]
//   };

  
  

  

//   @override
//   Widget build(BuildContext context) {
//     String name;
//     FoodItem foodItem;
//     Map categories = {}; 
//     addItem(FoodItem item){
//     if (categories.containsKey(item.category)){
//       List<String> po = categories[item.category];
//       po.add(item.name);
//       categories.update(item.category, (value) => po);
//     }
//     else{
//       List<String> no = [item.name];
//       categories[item.category] = no;
//     }
//     print(categories);
//     setState(() {
      
//     });
//   }


//     return Scaffold(
//       body: Container(
//         padding: EdgeInsets.all(20),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextFormField(
//                 controller: _controller,
//                 onChanged: (value) {
//                   name = value;
//                 },

//               ),
//               IconButton(
//                 icon: Icon(Icons.check) ,
//                 onPressed: (){
//                   _controller.clear();
//                   String cat = containItem(db, name);
//                   foodItem = FoodItem(name: name, category: cat); 
//                   addItem(foodItem);
//                   Navigator.pop(context);
              
//                 },
//               )
//             ],
//           ),
//         ),
//       ),
//     );
    
//   }

  

//   containItem(Map db, String food){
//     String result = "Uncategorized";
    
    
//     db.forEach((k, v) {
//       List<String> value = v;
//       if (value.contains(food)){
//         result = k; 
//       }
        
//     });
    
//     return result;   
//   }
// }