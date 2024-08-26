import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WritingPage(),
    );
  }
}

class WritingPage extends StatefulWidget {
  @override
  _WritingPageState createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage> {
  late MqttServerClient client;

  @override
  void initState() {
    super.initState();
    _setupMqttClient();
  }

  Future<void> _setupMqttClient() async {
    client = MqttServerClient('broker.hivemq.com', '');
    client.logging(on: true);
    client.setProtocolV311();
    client.port = 1883; // Default MQTT port
    client.keepAlivePeriod = 60;

    final connMessage = MqttConnectMessage()
        .withClientIdentifier('flutter_client')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMessage;

    try {
      await client.connect();
      print('Connected to MQTT broker');
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }

    client.updates?.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final MqttPublishMessage message = c![0].payload as MqttPublishMessage;
      final String payload =
          MqttPublishPayload.bytesToStringAsString(message.payload.message);

      print('Received message: $payload from topic: ${c[0].topic}>');
    });
  }

  void _publishMessage(String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);

    client.publishMessage('iot/gate/response', MqttQos.atLeastOnce, builder.payload!);
  }

  void _handleYesResponse() {
    print('User confirmed the attempt: Yes, I am');
    _publishMessage('yes');
  }

  void _handleNoResponse() {
    print('User denied the attempt: No, not me');
    _publishMessage('no');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.message, color: Colors.white),
            SizedBox(width: 10),
            Text('Confirmation Message', style: TextStyle(color: Colors.white)),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 167, 82, 182),
      ),
      body: Container(
        color:  Color.fromARGB(255, 167, 82, 182),
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  'There is an attempt to open the gate using your card. Was it you who tried to do this?',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _handleYesResponse,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40), 
                  minimumSize: Size(200, 60), 
                ),
                child: Text(
                  'Yes, I am',
                  style: TextStyle(
                    color: Color.fromARGB(255, 167, 82, 182),
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _handleNoResponse,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40), 
                  minimumSize: Size(200, 60), 
                ),
                child: Text(
                  'No, not me',
                  style: TextStyle(
                    color:  Color.fromARGB(255, 167, 82, 182),
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
