import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (ctx, i) => Container(
          padding: const EdgeInsets.all(10),
          child: Text('Funcionou!'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Firestore.instance
              .collection('chat')
              .snapshots()
              .listen((querySnapshot) {
            querySnapshot.documents.forEach((element) {
              print(element['text']);
            });
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
