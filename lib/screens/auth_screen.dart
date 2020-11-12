import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/auth_data.dart';
import '../widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _auth = FirebaseAuth.instance;

  Future<void> _handleSubmit(AuthData authData) async {
    try {
      if (authData.isLogin) {
        await _auth.signInWithEmailAndPassword(
          email: authData.email.trim(),
          password: authData.password,
        );
      } else {
        await _auth.createUserWithEmailAndPassword(
          email: authData.email.trim(),
          password: authData.password,
        );
      }
    } on PlatformException catch (err) {
      final msg = err.message ?? 'Ocorreu um erro! Verifique suas Credenciais!';
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(msg),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_handleSubmit),
    );
  }
}
