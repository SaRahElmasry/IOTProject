import 'dart:io';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MQTTClientWrapper {
  late MqttServerClient client;
  Function(String)? onMessageReceived;

  MqttCurrentConnectionState connectionState = MqttCurrentConnectionState.IDLE;
  MqttSubscriptionState subscriptionState = MqttSubscriptionState.IDLE;

  void prepareMqttClient() async {
    _setupMqttClient();
    await _connectClient();
  }

  Future<void> _connectClient() async {
    try {
      print('client connecting....');
      connectionState = MqttCurrentConnectionState.CONNECTING;
      await client.connect('SarahElmasry', 'SarahElmasry@I0T');
    } on Exception catch (e) {
      print('client exception - $e');
      connectionState = MqttCurrentConnectionState.ERROR_WHEN_CONNECTING;
      client.disconnect();
    }

    if (client.connectionStatus?.state == MqttConnectionState.connected) {
      connectionState = MqttCurrentConnectionState.CONNECTED;
      print('client connected');
    } else {
      print(
          'ERROR client connection failed - disconnecting, status is ${client.connectionStatus}');
      connectionState = MqttCurrentConnectionState.ERROR_WHEN_CONNECTING;
      client.disconnect();
    }
  }

  void _setupMqttClient() {
    client = MqttServerClient.withPort(
        'baafaafa0d4a438aaaf00a6e346d10e4.s1.eu.hivemq.cloud',
        'SarahElmasry',
        8883);
    client.secure = true;
    client.securityContext = SecurityContext.defaultContext;
    client.keepAlivePeriod = 20;
    client.onDisconnected = _onDisconnected;
    client.onConnected = _onConnected;
    client.onSubscribed = _onSubscribed;
  }

  void subscribeToTopic(String topicName) {
    print('Subscribing to the $topicName topic');
    client.subscribe(topicName, MqttQos.atMostOnce);
    client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
      var message =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      print('YOU GOT A NEW MESSAGE:');
      print(message);

      if (onMessageReceived != null) {
        onMessageReceived!(message);
      }
    });
  }

  void publishMessage(String topic, String message) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message);

    print('Publishing message "$message" to topic $topic');
    client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!);
  }

  void _onSubscribed(String topic) {
    print('Subscription confirmed for topic $topic');
    subscriptionState = MqttSubscriptionState.SUBSCRIBED;
  }

  void _onDisconnected() {
    print('OnDisconnected client callback - Client disconnection');
    connectionState = MqttCurrentConnectionState.DISCONNECTED;
  }

  void _onConnected() {
    connectionState = MqttCurrentConnectionState.CONNECTED;
    print('OnConnected client callback - Client connection was successful');
  }
}

enum MqttCurrentConnectionState {
  IDLE,
  CONNECTING,
  CONNECTED,
  DISCONNECTED,
  ERROR_WHEN_CONNECTING
}

enum MqttSubscriptionState { IDLE, SUBSCRIBED }
