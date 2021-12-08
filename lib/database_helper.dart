import 'package:flutter/material.dart';

import 'oprations.dart';

final _formKey = GlobalKey<FormState>();

class FirebaseOperation extends StatefulWidget {
  const FirebaseOperation({Key? key}) : super(key: key);

  @override
  _FirebaseOperationState createState() => _FirebaseOperationState();
}

class _FirebaseOperationState extends State<FirebaseOperation> {
  Map? data;



  @override
  void initState() {
    // TODO: implement initState
    Opration().fetchDb();
    super.initState();
  }

  static final _priorities = ["High", "Low"];
  //DatabaseHelper helper = DatabaseHelper();
  // String appBarTitle;
  // Note note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  ListView(shrinkWrap: true,
        children:  [
          ListTile(
            title: DropdownButton(
              items: _priorities.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Text(dropDownStringItem),
                );
              }).toList(),
              // style: textStyle,
              // value: getPriorityAsString(note.priority),
              onChanged: (valueSelectedByUser) {
                setState(() {
                  debugPrint("User selected $valueSelectedByUser");
                  // updatePriorityAsInt(valueSelectedByUser);
                });
              },
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: TextFormField(
              //   validator:(String value) {
              //   if (value.isEmpty){
              //     return "please enter title";
              //   }
              // },
              controller: titleController,
              // style: textStyle,
              onChanged: (value) {
                debugPrint("Something changed in titleTextile");
                // updateTitle();
                //createDb();

              },
              decoration: InputDecoration(
                  labelText: "Title",
                  // labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: TextFormField(
              //   validator: (String value) {
              //   if (value.isEmpty){
              //     return "Please enter description";
              //   }
              // },
              controller: descriptionController,
              // style: textStyle,
              onChanged: (value) {
                debugPrint("Something changed in DescriptionTextile");
                // updateDescription.toString();
                //createDb();

              },
              decoration: InputDecoration(
                  labelText: "Description".toString(),
                  // labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          //debugPrint("Save button");
                          //if(_formKey.currentState!.validate())

                          // _save();

                          Opration().createDb();
                          //Opration().fetchDb();
                          Navigator.pop(context,true);



                        });
                      },
                      child: Text(
                        "Save",
                        textScaleFactor: 1.5,
                        style: TextStyle(
                          color: Theme.of(context).primaryColorLight,
                        ),
                      )),
                ),
                const SizedBox(width: 5.0,),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          debugPrint("update button");
                          // if(_formKey.currentState!.validate())
                              {
                            // _delete();
                            //deleteDb(docId: snapshot.data!.docs[0].id);
                            Opration().updateDb();
                            Navigator.pop(context,true);


                          }
                        });
                      },
                      child: Text(
                        "Update",
                        textScaleFactor: 1.5,
                        style: TextStyle(
                          color: Theme.of(context).primaryColorLight,
                        ),
                      )),
                )

              ],
            ),
          ),




          // Center(
          //   child: TextButton(
          //     onPressed: () {
          //       createDb();
          //     },
          //     child: const Text('Create'),
          //   ),
          // ),
          // Center(
          //   child: TextButton(
          //     onPressed: () {
          //       fetchDb();
          //     },
          //     child: const Text('fetch'),
          //   ),
          // ),
          // Center(
          //   child: TextButton(
          //     onPressed: () {
          //       updateDb();
          //     },
          //     child: const Text('update'),
          //   ),
          // ),
          // Center(
          //   child: TextButton(
          //     onPressed: () {
          //       deleteDb(docId:snapshot.data!.docs[0].id );
          //     },
          //     child: const Text('delete'),
          //   ),
          // ),
          // Container(
          //   height: 500,
          //   child: ListView.builder(
          //       itemCount: snapshot.data!.size,
          //       itemBuilder: (BuildContext context, int index) {
          //         return Row(
          //           children: [
          //             Text('${snapshot.data!.docs[index]['Name']}'),
          //             IconButton(
          //                 icon: const Icon(Icons.delete),
          //                 onPressed: () {
          //                   deleteDb(
          //                       docId:
          //                       snapshot.data!.docs[index].id);
          //                 })
          //           ],
          //         );
          //       }),
          // )
        ],
      )
    );
  }


  moveToLastScreen(){
    Navigator.pop(context,true);
  }

  void updatePriorityAsInt(String value){
    switch (value){
      case "High":
      // note.priority = 1;
        break;
      case "Low":
      // note.priority =2;
        break;
    }
  }

  void _showAlertDialog(String title, String message){
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
        context:context,
        builder:(_)=>alertDialog
    );
  }

}











// import 'dart:io';
//
// class DatabaseHelper {
//   static DatabaseHelper _databaseHelper;
//   static Database _database;
//
//   String noteTable = "note_table";
//   String colId = "id";
//   String colTitle = "title";
//   String colDescription = "description";
//   String colPriority = "priority";
//   String colDate = "date";
//
//   DatabaseHelper._createInstance();
//   factory DatabaseHelper(){
//     _databaseHelper ??= DatabaseHelper._createInstance();
//     return _databaseHelper;
//
//   }
//
//   Future<Database>  database() async{
//     _database ??= await initializeDatabase();
//     return _database;
//   }
//   Future<Database>initializeDatabase()async{
//     Directory directory = await getApplicationDocumentsDirectory();
//     String path = directory.path + "notes.db";
//     var notesDatabase = await openDatabase(path,version: 1,onCreate: _createDb);
//     return notesDatabase;
//   }
//   Future _createDb(Database db, int newVersion)async{
//     await db.execute("CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT,$colDescription TEXT, $colPriority INTEGER, $colDate TEXT)");
//   }
//
//   Future<List<Map<String,dynamic>>> getNoteMapList()async{
//     Database db = await database();
//     var result = await db.query(noteTable,orderBy: "$colPriority ASC");
//     return result;
//   }
//
//   Future<int>insertNote(Note note)async{
//     Database db = await database();
//     var result = await db.insert(noteTable, note.toMap());
//     return result;
//   }
//
//   Future<int> updateNote( Note,note) async{
//     Database db = await database();
//     var result = await db.update(noteTable, note.toMap(),where: "$colId = ?",whereArgs: [note.id]);
//     return result;
//   }
//
//   Future<int> deleteNote(int id)async{
//     var db= await database();
//     int result = await db.rawDelete("DELETE FROM $noteTable WHERE $colId = $id");
//     return result;
//   }
//
//   Future<int> getCount()async{
//     Database db = await database();
//     List<Map<String, dynamic>> x = await db.rawQuery("SELECT COUNT (*) from $noteTable");
//     int result = Sqflite.firstIntValue(x);
//     return result;
//   }
//
//
//   Future<List<Note>> getNoteList()async{
//     var noteMapList = await getNoteMapList();
//     int count = noteMapList.length;
//     List<Note> noteList = List<Note>();
//     for (int i = 0;i<count;i++){
//       noteList.add(Note.fromMapObject(noteMapList[i]));
//     }
//     return noteList;
//   }
//
//
// }