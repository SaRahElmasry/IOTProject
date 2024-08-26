// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:iot_app/user/userdashboard.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import 'package:iot_app/user/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  void signup() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignupScreen()),
    );
  }

  Future<void> login() async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (userCredential.user != null) {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('Users')
            .doc(userCredential.user!.uid)
            .get();

        if (userSnapshot.exists) {
          Map<String, dynamic> userData =
              userSnapshot.data() as Map<String, dynamic>;
          if (userCredential.user!.emailVerified) {
            String firstName = userData['firstName'];
            String lastName = userData['lastName'];
            showToast(
              'Welcome To SmartParking $firstName $lastName',
              context: context,
              animation: StyledToastAnimation.scale,
              reverseAnimation: StyledToastAnimation.fade,
              position: StyledToastPosition.bottom,
              animDuration: const Duration(seconds: 1),
              duration: const Duration(seconds: 6),
              curve: Curves.elasticOut,
              reverseCurve: Curves.linear,
              backgroundColor: const Color.fromARGB(255, 167, 82, 182),
              textStyle: const TextStyle(color: Colors.white),
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SpotsDashboard()),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text("Please Verify Your Email To Proceed"),
                action: SnackBarAction(
                  backgroundColor: const Color.fromARGB(255, 167, 82, 182),
                  label: 'Resend Verification Message',
                  onPressed: () {
                    userCredential.user!.sendEmailVerification();
                  },
                ),
              ),
            );
          }
        } else {
          showToast(
            'User data not found.',
            context: context,
            animation: StyledToastAnimation.scale,
            reverseAnimation: StyledToastAnimation.fade,
            position: StyledToastPosition.bottom,
            animDuration: const Duration(seconds: 1),
            duration: const Duration(seconds: 6),
            curve: Curves.elasticOut,
            reverseCurve: Curves.linear,
            backgroundColor: const Color.fromARGB(255, 167, 82, 182),
            textStyle: const TextStyle(color: Colors.white),
          );
        }
      }
    } catch (error) {
      if (error is FirebaseAuthException) {
        String errorMessage;
        switch (error.code) {
          case 'user-not-found':
            errorMessage = 'No user found for that email.';
            break;
          case 'wrong-password':
            errorMessage = 'Wrong password provided for that user.';
            break;
          case 'invalid-email':
            errorMessage = 'The email address is badly formatted.';
            break;
          default:
            errorMessage = 'Login Failed. Please try again.';
        }
        showToast(
          errorMessage,
          context: context,
          animation: StyledToastAnimation.scale,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.bottom,
          animDuration: const Duration(seconds: 1),
          duration: const Duration(seconds: 6),
          curve: Curves.elasticOut,
          reverseCurve: Curves.linear,
          backgroundColor: const Color.fromARGB(255, 167, 82, 182),
          textStyle: const TextStyle(color: Colors.white),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.garage_rounded, size: 32.0),
        title: const Text('Login'),
        backgroundColor: const Color.fromARGB(255, 167, 82, 182),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: login,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 167, 82, 182),
              ),
              child: const Text(
                'Login',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            TextButton(
              onPressed: signup,
              child: const Text(
                "Not Registered Yet ?",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
