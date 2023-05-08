import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // sign user in method
  void signUserUp() async {
    //show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
      } else {
        showErrorMessage("Error here");
      }
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //TODO show error message
      showErrorMessage(e.code);
      Navigator.pop(context);
    }
  }

  // wrong email message popup
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // logo
          const Icon(
            Icons.lock,
            size: 100,
          ),

          const SizedBox(height: 40),
          // welcome back, you've been missed!
          Text(
            'Please Enter Registration Details Here!',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 25),
          TextField(
            controller: emailController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(labelText: "Enter Username"),
          ),
          const SizedBox(height: 4),
          TextField(
            controller: passwordController,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(labelText: "Enter Password"),
            obscureText: true,
          ),
          const SizedBox(height: 4),
          TextField(
            controller: confirmPasswordController,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(labelText: "Confirm Password"),
            obscureText: true,
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50)),
              icon: const Icon(Icons.lock_open, size: 32),
              label: const Text(
                'Sign In',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: signUserUp),
        ]),
      )),
    );
  }
}
