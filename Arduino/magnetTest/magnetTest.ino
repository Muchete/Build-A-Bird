int wingPin = 1;    // select the input pin for the potentiometer
int ledPin = 13;      // select the pin for the LED
int sensorValue = 0;  // variable to store the value coming from the sensor

void setup() {

  Serial.begin(9600);

  // declare the ledPin as an OUTPUT:
  pinMode(ledPin, OUTPUT);

}

void loop() {
  // read the value from the sensor:
  sensorValue = analogRead(wingPin);

  Serial.print("SensorValue: ");
  Serial.println(sensorValue);
  delay(1000);
}


int valueList[] = {
	100,
	200,
	300
}

int getId(int val){

	int index = 0;
	int dif = valueList[0] - val;
	int curDif = abs(dif);
	int minDif = curDif;

	for (i = 1; i < valueList.length(); i++) {
		dif = valueList[i] - val;
		curDif = abs(dif);
		if (curDif < minDif) {
			index = i;
			minDif = curDif;
		}
	}

	return index;
}
