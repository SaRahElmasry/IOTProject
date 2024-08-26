import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:iot_app/guest/guestbudget.dart';
// import '../firebase_options.dart';
import 'dart:math';

import 'package:iot_app/guest/guestdashboard.dart';
import 'package:iot_app/main.dart';

class GuestSpot extends StatefulWidget {
  const GuestSpot({super.key});

  @override
  _GuestSpotState createState() => _GuestSpotState();
}

class _GuestSpotState extends State<GuestSpot> {
  String generatedCode = ""; // State variable to store the generated code
  bool showCodeBox = false; // State variable to control visibility of the box

  // Function to generate a random numeric code
  int generateCode({int length = 6}) {
    Random random = Random();
    int min = pow(10, length - 1).toInt();
    int max = pow(10, length).toInt() - 1;
    return random.nextInt(max - min + 1) + min;
  }

  void _logout() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.directions_car, color: Colors.white),
            SizedBox(width: 10),
            Text('Reserve Your Spot', style: TextStyle(color: Colors.white)),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 167, 82, 182),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 167, 82, 182),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const GuestSpotsDashboard()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.car_rental),
              title: const Text('Reserve your Spot'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GuestSpot()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                _logout();
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                int code = generateCode();
                setState(() {
                  generatedCode = code.toString();
                  showCodeBox = true; // Show the code box
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 167, 82, 182),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text(
                'Generate Code',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Conditionally display the generated code box
            if (showCodeBox)
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  generatedCode.isEmpty
                      ? 'Generated Code will appear here'
                      : ' Code: $generatedCode',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            const SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      // obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Pass Code',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GuestBudgetPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 167, 82, 182),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text(
                'Go to Payment',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
