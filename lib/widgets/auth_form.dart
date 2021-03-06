import 'dart:io';

import 'package:flutter/material.dart';

import '../models/auth_data.dart';
import '../widgets/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthData authData) onSubmit;

  AuthForm(this.onSubmit);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final AuthData _authData = AuthData();

  void _submit() {
    bool isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_authData.image == null && _authData.isSignup) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Precisamos da sua foto!'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }

    if (isValid) {
      widget.onSubmit(_authData);
    }
  }

  void _handlePickedImage(File image) {
    _authData.image = image;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _authData.isSignup
                      ? UserImagePicker(_handlePickedImage)
                      : const SizedBox.shrink(),
                  _authData.isSignup
                      ? TextFormField(
                          key: ValueKey('name'),
                          decoration: InputDecoration(
                            labelText: 'Nome',
                          ),
                          initialValue: _authData.name,
                          onChanged: (value) => _authData.name = value,
                          validator: (value) {
                            if (value == null || value.trim().length < 4) {
                              return 'Nome deve ter no minímo 4 caracteres.';
                            }
                            return null;
                          },
                        )
                      : const SizedBox.shrink(),
                  TextFormField(
                    key: ValueKey('email'),
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                    ),
                    initialValue: _authData.email,
                    onChanged: (value) => _authData.email = value,
                    validator: (value) {
                      if (value == null || !value.contains('@')) {
                        return 'Forneça um E-mail válido.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    key: ValueKey('password'),
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                    ),
                    initialValue: _authData.password,
                    onChanged: (value) => _authData.password = value,
                    validator: (value) {
                      if (value == null || value.trim().length < 7) {
                        return 'Senha deve ter no minímo 7 caracteres.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  RaisedButton(
                    child: Text(_authData.isLogin ? 'Entrar' : 'Cadastrar'),
                    onPressed: _submit,
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      setState(() {
                        _authData.toogleMode();
                      });
                    },
                    child: Text(
                      _authData.isLogin
                          ? 'Criar uma nova conta?'
                          : 'Já possuí uma conta?',
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
