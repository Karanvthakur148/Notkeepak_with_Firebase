import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notekeeper/oprations.dart';

import 'database_helper.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  // DatabaseHelper databaseHelper = DatabaseHelper();
  // List<Note>noteList;
  // int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection('Database').snapshots(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data!.size,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: Colors.white,
                        elevation: 2.0,
                        child: ListTile(
                          leading: const CircleAvatar(
                              // backgroundColor: getpriorityColor(this.noteList[index].priority),
                              //  child: getPriorityIcon(this.noteList[index].priority),
                              ),
                          title: Text("${snapshot.data!.docs[index]["title"]}"),
                          // this.noteList[index].title,),
                          subtitle: Text(
                              "${snapshot.data!.docs[index]["description"]}"
                              // this.noteList[index].date
                              ),
                          trailing: GestureDetector(
                              onTap: () {
                                // _delete(context, noteList[index]);
                                Opration()
                                    .deleteDb(docId: snapshot.data!.docs[0].id);
                              },
                              child: const Icon(
                                Icons.delete,
                                color: Colors.grey,
                              )),
                          onTap: () {
                            Opration().updateDb();

                            debugPrint("Tapped");
                            //navigateToDetail(this.noteList[index],"Edit Note");
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return const FirebaseOperation();
                            },));
                          },
                        ),
                      );
                    })
                : const Center(child: CircularProgressIndicator());
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("FAB clicked");
          //navigateToDetail(Note('', 2, ""), 'Add Note');
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const FirebaseOperation();
            },
          ));
        },
        tooltip: "Add Note",
        child: const Icon(Icons.add),
      ),
    );
  }

  Color getpriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;
      default:
        return Colors.yellow;
    }
  }

  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;
      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }
}
