import 'package:flutter/material.dart';
import 'package:iot_app/user/userhome.dart';
import 'package:iot_app/guest/guestdashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Welcome To SmartParking'),
        backgroundColor: const Color.fromARGB(255, 167, 82, 182),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.garage_rounded, size: 200),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const GuestSpotsDashboard()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 83, 82, 82),
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                textStyle: const TextStyle(fontSize: 20),
              ),
              child: const Text(
                ' Guest ',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserHomePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 167, 82, 182),
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                textStyle: const TextStyle(fontSize: 20),
              ),
              child: const Text(
                '  User  ',
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
