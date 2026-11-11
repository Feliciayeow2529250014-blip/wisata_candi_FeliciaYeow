import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Implementasikan logika sign-in di sini
          },
          child: const Text('Sign In'),
        ),
      ),
    );
  }
}
