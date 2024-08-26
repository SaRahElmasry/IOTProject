import 'package:flutter/material.dart';

class GuestBudgetPage extends StatefulWidget {
  const GuestBudgetPage({super.key});

  @override
  _BudgetPageState createState() => _BudgetPageState();
}

class _BudgetPageState extends State<GuestBudgetPage> {
  final TextEditingController _hoursController = TextEditingController();
  double totalCost = 0.0;
  double ratePerHour = 5.0;

  double calculateCost(double hours) {
    return hours * ratePerHour;
  }

  void _updateTotalCost() {
    double? hours = double.tryParse(_hoursController.text);
    if (hours != null) {
      setState(() {
        totalCost = calculateCost(hours);
      });
    } else {
      setState(() {
        totalCost = 0.0;
      });
    }
  }

  void _showBookingSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Booking Success'),
          content: const Text('Booked Successfully!'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showInvalidInputDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text('Please enter a valid number of hours.'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _hoursController.addListener(_updateTotalCost);
  }

  @override
  void dispose() {
    _hoursController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.attach_money, color: Colors.white),
            SizedBox(width: 5),
            Text('Budget', style: TextStyle(color: Colors.white)),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 167, 82, 182),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _hoursController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Enter the number of hours',
                    prefixIcon: Icon(Icons.timer),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Amount to be paid: \$${totalCost.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 26, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  double? hours = double.tryParse(_hoursController.text);
                  if (hours != null) {
                    _showBookingSuccessDialog();
                  } else {
                    _showInvalidInputDialog();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 167, 82, 182),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  'Pay Now',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              const SizedBox(height: 40),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
