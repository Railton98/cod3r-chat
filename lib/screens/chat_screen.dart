import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/messages.dart';

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
                        const SizedBox(width: 8),
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
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(child: Messages()),
          ],
        ),
      ),
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
