import 'package:flutter/material.dart';
import 'package:iot_app/user/login.dart';
import 'package:iot_app/user/signup.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.garage_rounded, size: 32.0),
        title: const Text('User'),
        backgroundColor: const Color.fromARGB(255, 167, 82, 182),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 83, 82, 82),
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                textStyle: const TextStyle(fontSize: 20),
              ),
              child: const Text(
                '  Login  ',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignupScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 167, 82, 182),
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                textStyle: const TextStyle(fontSize: 20),
              ),
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
