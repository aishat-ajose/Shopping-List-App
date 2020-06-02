import 'package:flutter/material.dart';
// import 'package:search_widget/search_widget.dart';

class TestSearch extends StatefulWidget {

  @override
  _TestSearchState createState() => _TestSearchState();
}

class _TestSearchState extends State<TestSearch> {
  TextEditingController _controller = TextEditingController();

  String words;
  List<String> lis = ["mango", 'rice', 'milk', "chicken"];
  List<String> filtered = [];

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Test Search"),
        backgroundColor: Colors.blue,
        elevation: 0.0,
      ),
      
      body:Column(children: [
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
                            print(text);
                            if(text.length <= 0){filtered = null;}
                            else{
                              filtered = lis.where((element) { 
                              print(element);
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
                          words =null;
                      });
                    
                    print("Sent");
                    _controller.clear();
                    }),
                  ],
                ),
              ),
          ),
          Stack(
            children: [
              Center(child: Text("body")),
              filtered != null && filtered.length > 0 ? Container(
                margin: EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: Card(
                  elevation: 20,
                  child: ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder:(context, index){return  Text(filtered[index]);}
                    )
                ),
              ): Container()
            ],

          )
            
            
        
        ],
        ),    
    );
  }
}















