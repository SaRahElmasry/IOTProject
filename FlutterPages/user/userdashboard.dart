import 'package:flutter/material.dart';
// import 'package:mqtt_client/mqtt_client.dart';
// import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:iot_app/user/login.dart';
import 'package:iot_app/user/userbudget.dart';

class SpotsDashboard extends StatefulWidget {
  const SpotsDashboard({super.key});

  @override
  _SpotsDashboardState createState() => _SpotsDashboardState();
}

class _SpotsDashboardState extends State<SpotsDashboard> {
  // late MqttServerClient client;
  // int availableSpots = 0;
  // int occupiedSpots = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   setupMqttClient();
  //   connectClient();
  // }

  // @override
  // void dispose() {
  //   client.disconnect();
  //   super.dispose();
  // }

  // void setupMqttClient() {
  //   client = MqttServerClient(
  //       'baafaafa0d4a438aaaf00a6e346d10e4.s1.eu.hivemq.cloud', 'SarahElmasry');
  //   client.port = 8883;
  //   client.keepAlivePeriod = 20;
  //   client.onDisconnected = onDisconnected;
  //   client.logging(on: true);
  //   client.onConnected = onConnected;
  //   client.onSubscribed = onSubscribed;
  // }

  // void onConnected() {
  //   print('Connected');
  //   client.subscribe('parking/spots', MqttQos.atMostOnce);
  // }

  // void onDisconnected() {
  //   print('Disconnected');
  // }

  // void onSubscribed(String topic) {
  //   print('Subscribed to: $topic');
  // }

  // void connectClient() async {
  //   try {
  //     await client.connect();
  //   } catch (e) {
  //     print('Exception: $e');
  //     client.disconnect();
  //   }

  //   client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
  //     final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
  //     final payload =
  //         MqttPublishPayload.bytesToStringAsString(message.payload.message);

  //     print('Received message: $payload');
  //     updateSpotCounts(payload);
  //   });
  // }

  // void updateSpotCounts(String payload) {
  //   // Assuming payload is in format "available,occupied"
  //   List<String> counts = payload.split(',');
  //   if (counts.length == 2) {
  //     setState(() {
  //       availableSpots = int.parse(counts[0]);
  //       occupiedSpots = int.parse(counts[1]);
  //     });
  //   }
  // }

  void _logout() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Spots Dashboard'),
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
                  MaterialPageRoute(builder: (context) => const SpotsDashboard()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.attach_money),
              title: const Text('Budget'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserBudgetPage()),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              // 'Available Spots: $availableSpots',
              'Available Spots  1',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            const Text(
              // 'Occupied Spots: $occupiedSpots',
              'Occupied Spots  2',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 40),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      color: const Color.fromARGB(255, 83, 82, 82),
                      // value: availableSpots.toDouble(),
                      value: 1,
                      title: 'Available',
                      radius: 100,
                      titleStyle: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    PieChartSectionData(
                      color: const Color.fromARGB(255, 167, 82, 182),
                      // value: occupiedSpots.toDouble(),
                      value: 2,
                      title: 'Occupied',
                      radius: 100,
                      titleStyle: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
