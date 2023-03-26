import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:tp_fruit/providers/user_provider.dart';
import 'package:tp_fruit/screen/log_in_screen.dart';

class User {
  String password;
  String email;

  User({required this.password, required this.email});

  Map<String, dynamic> toJson() {
    return {
      'password': password,
      'email': email,
    };
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  String errorMessage = '';

  Future<void> _submitForm(context) async {
    setState(() {
      errorMessage = "Inscription en cours de traitement...";
    });
    final user = User(
      password: _passwordController.text,
      email: _emailController.text,
    );
    final response = await http.post(
      Uri.parse('https://fruits.shrp.dev/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode == 204) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LogInScreen()),
      );
    } else {
      setState(() {
        _passwordController.text = '';
        errorMessage = "Un problème est survenu lors de l'inscription";
      });
      // Erreur lors de l'envoi des données
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("S'INSCRIRE")),
      body: Column(children: [
        Form(
            key: _formKey,
            child: Column(
              children: [
                Text(errorMessage),
                TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer une adresse e-mail';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Adresse e-mail',
                  ),
                ),
                TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un mot de passe';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Mot de passe',
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final BuildContext context = this.context;
                      _submitForm(context);
                    }
                  },
                  child: const Text("S'inscrire"),
                ),
              ],
            )),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LogInScreen()),
            );
          },
          child: const Text("Se connecter"),
        ),
        Consumer<UserProvider>(builder: (context, model, child) {
          return TextButton(
            onPressed: () async {
              setState(() {
                errorMessage = "Opération en cours de traitement...";
              });
              final body = {
                'refresh_token': model.refreshToken,
              };
              final response = await http.post(
                Uri.parse('https://fruits.shrp.dev/auth/logout'),
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                },
                body: jsonEncode(body),
              );
              if (response.statusCode == 204) {
                setState(() {
                  errorMessage = "Déconnexion réussie";
                });
              } else {
                setState(() {
                  errorMessage =
                      "Un problème est survenu lors de la déconnexion";
                });
                // Erreur lors de l'envoi des données
              }
            },
            child: const Text(
              "Se déconnecter",
            ),
          );
        }),
      ]),
    );
  }
}
