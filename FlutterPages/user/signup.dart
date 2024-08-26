import 'package:flutter/material.dart';
import 'package:iot_app/user/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
  }

  bool verifypassword() {
    return _passwordController.text.trim() ==
        _confirmpasswordController.text.trim();
  }

  void login() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  Future<void> signup() async {
    if (verifypassword()) {
      try {
        final userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        await userCredential.user?.sendEmailVerification();

        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userCredential.user?.uid)
            .set({
          'email': _emailController.text.trim(),
          'password': _passwordController.text.trim(),
          'firstName': _firstNameController.text.trim(),
          'lastName': _lastNameController.text.trim(),
          'phone': _phoneController.text.trim(),
        });

        showToast(
          'Please Check your Email To Verify',
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
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } catch (e) {
        showToast(
          'Sign Up Faild',
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
        print("Sign Up Error: $e");
      }
    } else {
      showToast(
        'Password Does not Match, please retype it!',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.garage_rounded, size: 32.0),
        title: const Text('Sign Up'),
        backgroundColor: const Color.fromARGB(255, 167, 82, 182),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                hintText: 'First Name',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                hintText: 'Last Name',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: 'Phone',
                prefixIcon: Icon(Icons.phone),
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
            const SizedBox(height: 16.0),
            TextField(
              controller: _confirmpasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Confirm Password',
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: signup,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 167, 82, 182),
              ),
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            TextButton(
              onPressed: login,
              child: const Text(
                "Already have an account ?",
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
