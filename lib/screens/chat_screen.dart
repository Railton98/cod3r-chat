import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cod3r Chat'),
        actions: <Widget>[
          DropdownButtonHideUnderline(
            child: DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                  value: 'logout',
                  child: Container(
                    child: Row(
                      children: [
                        Icon(Icons.exit_to_app),
                        const SizedBox(height: 8),
                        Text('Sair'),
                      ],
                    ),
                  ),
                ),
              ],
              onChanged: (item) {
                if (item == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              },
            ),
          ),
        ],
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection('chat').snapshots(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            final documents = snapshot.data.documents;
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (ctx, i) => Container(
                padding: const EdgeInsets.all(10),
                child: Text(documents[i]['text']),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Firestore.instance.collection('chat').add({
            'text': 'Adicionado pelo app!',
            'flutter': true,
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
