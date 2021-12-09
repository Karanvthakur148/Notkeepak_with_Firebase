import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notekeeper/oprations.dart';

import 'notes_details.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
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
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return FirebaseOperation(
                                updateId: snapshot.data!.docs[index].id,
                                data: {
                                  'title': snapshot.data!.docs[index]['title'],
                                  'description': snapshot.data!.docs[index]
                                      ['description']
                                },
                              );
                            },
                          ));
                        },
                        child: Card(
                          color: Colors.white,
                          elevation: 2.0,
                          child: ListTile(
                            leading: const CircleAvatar(
                                // backgroundColor: getpriorityColor(this.noteList[index].priority),
                                //  child: getPriorityIcon(this.noteList[index].priority),
                                ),
                            title:
                                Text("${snapshot.data!.docs[index]["title"]}"),
                            // this.noteList[index].title,),
                            subtitle: Text(
                                "${snapshot.data!.docs[index]["description"]}"
                                // this.noteList[index].date
                                ),
                            trailing: GestureDetector(
                                onTap: () {
                                  // _delete(context, noteList[index]);
                                  Opration().deleteDb(
                                      docId: snapshot.data!.docs[0].id);
                                },
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.grey,
                                )),
                          ),
                        ),
                      );
                    })
                : const Center(child: CircularProgressIndicator());
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("FAB clicked");
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const FirebaseOperation(updateId: '', data: '');
            },
          ));
        },
        tooltip: "Add Note",
        child: const Icon(Icons.add),
      ),
    );
  }
}
