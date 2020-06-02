// class MyFloatingActionButton extends StatelessWidget  {
//   final UserList userList;
//   MyFloatingActionButton(this.userList);
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _controller = new TextEditingController();

//   @override
//   Widget build(BuildContext context) {  
//     String name;
//     return FloatingActionButton(
//       onPressed: () {
//         showBottomSheet(
//           backgroundColor: Colors.cyanAccent,
//           context: context,
//           builder: (context) => Container(
//             padding: EdgeInsets.all(20),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   TextFormField(
//                     controller: _controller,
//                     onChanged: (value) {
//                       name = value;
//                     },
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.check) ,
//                     onPressed: () async{  
//                       _controller.clear();
//                       UserList _userList = UserList(
//                         id: userList.id,
//                         listName: userList.listName,
//                         listItems: userList.listItems == null ? name : userList.listItems + ",$name",
//                         );
//                       await DatabaseService().updateUserList(_userList);
//                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> TestPage(_userList)));
//                     },
//                   )
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }





