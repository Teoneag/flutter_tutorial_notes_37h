import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:notes_t_37h_2/constants/routes.dart';
import 'package:notes_t_37h_2/utilities/show_error.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration:
                const InputDecoration(hintText: 'Enter your email here'),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration:
                const InputDecoration(hintText: 'Enter your password here'),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();
                Navigator.of(context).pushNamed(verifyEmailRoute);
              } on FirebaseAuthException catch (e) {
                switch (e.code) {
                  case 'weak-password':
                    await showErrorDialog(
                      context,
                      'Weak password, please make ur password go to the jim!',
                    );
                    break;
                  case 'email-already-in-use':
                    await showErrorDialog(
                      context,
                      'Email already in use, go to log in or use another email to register!',
                    );
                    break;
                  case 'invalid-email':
                    await showErrorDialog(
                      context,
                      'Invalid email, please check the spelling and don\'t forget to add @gmail.com for example!',
                    );
                    break;
                  default:
                    await showErrorDialog(
                      context,
                      'Error: ${e.code}',
                    );
                }
              } catch (e) {
                await showErrorDialog(
                  context,
                  '$e',
                );
              }
            },
            child: const Text('Register'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                loginRoute,
                (route) => false,
              );
            },
            child: const Text('Already registered? Login here!'),
          ),
        ],
      ),
    );
  }
}
