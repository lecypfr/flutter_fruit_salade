import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:tp_fruit/providers/user_provider.dart';
import 'package:tp_fruit/screen/sign_up_screen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  String errorMessage = '';

  Future<void> _submitForm(context) async {
    setState(() {
      errorMessage = "Connection en cours de traitement...";
    });
    final user = {
      'password': _passwordController.text,
      'email': _emailController.text,
    };
    final response = await http.post(
      Uri.parse('https://fruits.shrp.dev/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user),
    );
    if (response.statusCode == 200) {
      Provider.of<UserProvider>(context, listen: false).init(response.body);
      setState(() {
        errorMessage = "Connexion réussie";
      });
    } else {
      setState(() {
        _passwordController.text = '';
        errorMessage = "Un problème est survenu lors de la connexion";
      });
      // Erreur lors de l'envoi des données
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Se connecter")),
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
                      return 'Veuillez entrer votre adresse e-mail';
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
                      return 'Veuillez entrer votre mot de passe';
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
                  child: const Text("Se connecter"),
                ),
              ],
            )),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignUpScreen()),
            );
          },
          child: const Text("S'inscrire"),
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
