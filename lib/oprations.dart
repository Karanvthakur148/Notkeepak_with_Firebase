import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Opration {
  void createDb({dynamic data}) {
    CollectionReference db = FirebaseFirestore.instance.collection('Database');
    db.add(data);
  }

  void updateDb({dynamic data, required docId}) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('Database');
    await collectionReference.doc(docId).update(data);
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
