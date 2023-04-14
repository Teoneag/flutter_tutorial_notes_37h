import 'package:flutter/material.dart';
import 'package:notes_t_37h_2/constants/routes.dart';
import 'package:notes_t_37h_2/services/auth/auth_service.dart';

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
          const Text(
              "We've send you an email verification. Please open it in order to verify ur account."),
          const Text(
              "If u haven't received a verification email yet, press the botton bellow."),
          TextButton(
            onPressed: () async {
              await AuthService.firebase().sendEmailVerification();
              // FirebaseAuthException ([firebase_auth/too-many-requests] We have blocked all requests from this device due to unusual activity. Try again later.)
            },
            child: const Text('Send email verification'),
          ),
          TextButton(
            onPressed: () async {
              await AuthService.firebase().logOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            },
            child: const Text('Restart'),
          ),
        ],
      ),
    );
  }
}
