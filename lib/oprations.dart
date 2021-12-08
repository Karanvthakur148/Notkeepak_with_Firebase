import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';


TextEditingController titleController = TextEditingController();
TextEditingController descriptionController = TextEditingController();
class Opration {

  void createDb() {
    CollectionReference db = FirebaseFirestore.instance.collection('Database');
    db.add({'title': titleController.text, 'description': descriptionController.text});
  }

  void fetchDb() async {
    var collection = FirebaseFirestore.instance.collection('Database');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      var name = data['title'];
      var mobile = data['description'];
    }
  }

  void updateDb() async {
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection('Database');
    QuerySnapshot querySnapshot = await collectionReference.get();
    querySnapshot.docs[0].reference
        .update({"title": titleController.text, "description": descriptionController.text});
  }

  void deleteDb({required String docId}) async {
    final collection = FirebaseFirestore.instance.collection('Database');
    collection
        .doc(docId) // <-- Doc ID to be deleted.
        .delete() // <-- Delete
        .then((_) => print('Deleted'))
        .catchError((error) => print('Delete failed: $error'));
  }



}