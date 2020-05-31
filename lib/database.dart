import 'package:sqflite/sqflite.dart';


class DatabaseService{

  static DatabaseService _databaseService;
  static Database _database;
  
  
  DatabaseService._createInstance();

  factory DatabaseService(){
    if(_databaseService == null){

      _databaseService = DatabaseService._createInstance();
    }
    // print()
    return _databaseService;
  }


  Future<Database> get database async{
    if (_database == null){
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase()  async{
    String databasesPath = await getDatabasesPath();
    String dbPath = databasesPath + "my.dbt";


    var database = await openDatabase(dbPath, version: 1, onCreate: populateDb);
    return database;
  }


  void populateDb(Database db, int version) async {
    print("pip");
    await db.execute("CREATE TABLE UserListTable ("
      "id INTEGER PRIMARY KEY,"
      "listName TEXT,"
      "listItems TEXT"
      ")"
    );
  }


  Future<int> createUserList(UserList userList) async {
    Database database = await this.database;
    var result = await database.insert("UserListTable", userList.toJson());
    return result;
  }

  List<UserList> listFromMap(List<Map> snapshots){
    return snapshots.map((doc) {
      return UserList.fromJson(doc);
    }).toList();
  }



  Future<List<UserList>> getUserLists() async {
    Database database = await this.database;
    List<Map<String, dynamic>> result  = await database.query("UserListTable", columns: ["id", "listName", "listItems"]);
    
    return List.generate(result.length, (index){
      return UserList.fromJson(result[index]);
    });
}  
  

  Future<UserList> getUserList(int id) async {
    Database database = await this.database;
    List<Map> results = await database.query("UserListTable",
        columns: ["id", "listName", "listItems"],
        where: 'id = ?',
        whereArgs: [id]);

    if (results.length > 0) {
      return UserList.fromJson(results.first);
    }

    return null;
  }

  Future<int> updateUserList(UserList userList) async {
    Database database = await this.database;
    return await database.update("UserListTable", userList.toJson(), where: "id = ?", whereArgs: [userList.id]);
  }

  Future<int> deleteUserList(int id) async {
    Database database = await this.database;
    return await database.delete("UserListTable", where: 'id = ?', whereArgs: [id]);
  }

  deleteUserLists() async{
    Database database = await this.database;
    return await  database.delete("UserListTable");
  }

}









class UserList {
    int id;
    String listName;
    String listItems;

    UserList({
        this.id,
        this.listName,
        this.listItems
    });


    factory UserList.fromJson(Map<String, dynamic> data) => new UserList(
        id: data["id"],
        listName: data["listName"],
        listItems: data["listItems"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "listName": listName,
        "listItems": listItems,
    };

    
}