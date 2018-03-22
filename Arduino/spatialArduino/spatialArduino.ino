// This example uses an Arduino/Genuino Zero together with
// a WiFi101 Shield or a MKR1000 to connect to shiftr.io.
//
// IMPORTANT: This example uses the new WiFi101 library.
//
// You can check on your device after a successful
// connection here: https://shiftr.io/try.
//
// by Gilberto Conti
// https://github.com/256dpi/arduino-mqtt

#include <string.h>
#include <WiFi101.h>
#include <MQTT.h>

const char ssid[] = "BRIDGE";
const char pass[] = "internet";

WiFiClient net;
MQTTClient client;

unsigned long lastMillis = 0;

const int sensorCount = 5;
int sensorValue[sensorCount],
    lastId[sensorCount];

const int partCount = 14;
int valueList[partCount] = {1023, 734, 650, 606, 511, 459, 365, 313, 240, 206, 146, 109, 62, 34 };
char* birdName[partCount]={"none","storch", "waldkauz", "bekassine","bekassine", "bekassine","bekassine","palmkakadu","palmkakadu","palmkakadu","palmkakadu","schnurrvogel","helmspecht","blaukopfschmetterling"};
char* partName[partCount]={"none","kopf", "kopf", "kopf","fluegel", "schwanz","beine","kopf","fluegel","beine","schwanz","fluegel","kopf","beine"};
char* connectorName[sensorCount]={"head", "wings", "wings","tail", "feet"};

void connect() {
  Serial.print("checking wifi...");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(1000);  
  }

  Serial.print("\nconnecting...");
  while (!client.connect("arduino-cockatoo", "arduino-cockatoo", "3fc88956d689eb72")) {
    Serial.print(".");
    delay(1000);
  }

  Serial.println("\nconnected!");

  // client.subscribe("/hello");
  // client.unsubscribe("/hello");
}

// void messageReceived(String &topic, String &payload) {
//   Serial.println("incoming: " + topic + " - " + payload);
// }

int getId(int val){

  int index = 0;
  int dif = valueList[0] - val;
  int curDif = abs(dif);
  int minDif = curDif;

  for (int k = 1; k < partCount; k++) {
    dif = valueList[k] - val;
    curDif = abs(dif);
    if (curDif < minDif) {
      index = k;
      minDif = curDif;
    }
  }

  return index;
}

// void readSignals(){
//    for (int i=0; i < sensorCount; i++){
//       sensorValue[i] = analogRead(i);
//    }
// }

void checkDifferences(){
   for (int i=0; i < sensorCount; i++){
      sensorValue[i] = analogRead(i);
      if (i == 4){
        sensorValue[i] = sensorValue[i] + 20; //weird offset
      }
      if (getId(sensorValue[i]) != lastId[i]){
          lastId[i] = getId(sensorValue[i]);
          newPart(i, lastId[i]);
      }
   }
}

void newPart(int input, int partId){
    Serial.print("Input: ");
    Serial.print(input);
    Serial.print(" Part ID: ");
    Serial.println(partId);
    //client.publish("connector", connectorName[input]);
    //client.publish("bird", birdName[partId]);
    //client.publish("part", partName[partId]);

    char combined[32] = {0};

    char part[32];
    sprintf(part,"%d",partId);
    
    strcat(combined, connectorName[input]);
    strcat(combined, ",");
    strcat(combined, birdName[partId]);
    strcat(combined, ",");
    strcat(combined, partName[partId]);
    strcat(combined, ",");
    strcat(combined, part);

    client.publish("eventString", combined);
}

void update(){
  // readSignals();
  checkDifferences();
}

void resetScreen(){
   for (int i=0; i < sensorCount; i++){
      delay(100);
      newPart(i, 0);
   }
};

void setup() {
  Serial.begin(115200);
  WiFi.begin(ssid,pass);

  // Note: Local domain names (e.g. "Computer.local" on OSX) are not supported by Arduino.
  // You need to set the IP address directly.
  client.begin("broker.shiftr.io", net);
  //client.onMessage(messageReceived);

  connect();

  resetScreen();
}

void loop() {
  client.loop();

  if (!client.connected()) {
    connect();
  }

  delay(10);
  update();

  // publish a message roughly every second.
//  if (millis() - lastMillis > 10) {
//    lastMillis = millis();
//  }
}
