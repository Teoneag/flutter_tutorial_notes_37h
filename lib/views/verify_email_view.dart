import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify email!'),
      ),
      body: Column(
        children: [
          const Text('Please verify your email adress'),
          TextButton(
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              await user?.sendEmailVerification();
              // FirebaseAuthException ([firebase_auth/too-many-requests] We have blocked all requests from this device due to unusual activity. Try again later.)
            },
            child: const Text('Send email verification'),
          )
        ],
      ),
    );
  }
}
