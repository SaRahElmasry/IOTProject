#include <Arduino.h>
#include <ESP32Servo.h>
#include <driver/adc.h>
#include <SPI.h>
#include <MFRC522.h>
#include <Keypad.h>


int irpin =35; //IR sen
Servo servpin1 ;
Servo gateServo ;

//buzzer pin
const  int buzzpin = 33;
//const  int ledpin1 = ;//smoke warning

//ultrasonic-1
const int trigPin1 = 26;
const int echoPin1 = 25;
//ultrasonic-2
const int trigPin2 = 14;
const int echoPin2 =27 ;
//ultrasonic-3
const int trigPin3 = 5;
const int echoPin3 = 4;

//  smoke detector
const int smokepin = 26; 

#define SS_PIN    21 //SDA
#define RST_PIN   22
MFRC522 rfid(SS_PIN, RST_PIN); 
byte authorizedUID[4] = {0xCD, 0x25, 0x21, 0x21};

bool isAuthorizedUID(byte *uid) {
  for (byte i = 0; i < 4; i++) {
    if (uid[i] != authorizedUID[i]) {
      return false;
    }
  }
  return true;
}

void openGate() {
  gateServo.write(130); // Move servo to open gate (adjust angle as needed)
  Serial.println("Gate opened");
}

void closeGate() {
  gateServo.write(30); // Move servo to close gate
  Serial.println("Gate closed");
}
void setup() {
 Serial.begin(115200);
   Serial.flush();  // Clear serial buffer

//for the RFID reader
  SPI.begin();                  // Init SPI bus
  rfid.PCD_Init();            // Initialize the RFID reader
  gateServo.attach(13);     // Attach the servo to the pin
  gateServo.write(30);             // Set initial servo position to 30 degrees
  Serial.println("Place your RFID card on the reader");


  //this code for the EXIT gate  
  pinMode(irpin,INPUT);
  servpin1.attach(32);
//ultrasonic sensor for measure distance
  //the trig pins as output
  pinMode(trigPin1, OUTPUT);
  pinMode(trigPin2, OUTPUT);
  pinMode(trigPin3, OUTPUT);

  //  the echo pins as inputs
  pinMode(echoPin1, INPUT);
  pinMode(echoPin2, INPUT);
  pinMode(echoPin3, INPUT);

  pinMode(smokepin, INPUT);
  pinMode(buzzpin,OUTPUT);
}

void loop() {
   // Look for new RFID cards
  if (!rfid.PICC_IsNewCardPresent() || !rfid.PICC_ReadCardSerial()) {
    return;
  }
  // Compare the read UID with the authorized UID
  if (isAuthorizedUID(rfid.uid.uidByte)) {
    Serial.println("Authorized access!");
    openGate();  // Open the gate
    delay(5000); // Keep the gate open for 5 seconds
    closeGate(); // Close the gate
  } else {
    Serial.println("Unauthorized access!");
  }

  // Halt PICC and stop encryption on PCD
  rfid.PICC_HaltA();
  rfid.PCD_StopCrypto1();

 //this code for the EXIT gate 
int perenseVal =digitalRead(irpin);//0,4095
if(perenseVal==HIGH){ 
  Serial.println("there is not object");
  servpin1.write(130);
  Serial.println("Position 130");
}else{
  Serial.println("there is an object"); 
    servpin1.write(30);
    Serial.println("Position 30");
}

// Measure distance for the first sensor
  digitalWrite(trigPin1, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin1, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin1, LOW);
  long duration1 = pulseIn(echoPin1, HIGH);
  int distance1 = duration1 / 58;

  // Measure distance for the second sensorqw
  digitalWrite(trigPin2, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin2, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin2, LOW);
  long duration2 = pulseIn(echoPin2, HIGH);
  int distance2 = duration2 / 58;
  //Measure distance for the third
  digitalWrite(trigPin3, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin3, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin3, LOW);
  long duration3 = pulseIn(echoPin3, HIGH);
  int distance3 = duration3 / 58;

  //warning for cars
  if(distance2<6||distance1<6||distance3<6){
  digitalWrite(buzzpin,HIGH);
  Serial.print("Distance 1: ");
  Serial.print(distance1);
  Serial.print(" cm, Distance 2: ");
  Serial.print(distance2);
  Serial.println(" cm");

  }else{
//    digitalWrite(buzzpin,LOW);
  Serial.print("Distance 1: ");
  Serial.print(distance1);
  Serial.print(" cm, Distance 2: ");
  Serial.print(distance2);
  Serial.println(" cm");
  }
  //smoke detector
  int sensorValue = digitalRead(smokepin); 
  if (sensorValue==HIGH) {//if there is smoke turn on buzzer
    digitalWrite(buzzpin,HIGH);
    //digitalWrite(ledpin1,HIGH);
  } else {//if there is not smoke turn off buzzer
    digitalWrite(buzzpin,LOW);
    //digitalWrite(ledpin1,LOW);
  }
  delay(6000);  // Short delay to avoid rapid toggling
}
