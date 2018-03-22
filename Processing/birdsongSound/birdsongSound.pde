import mqtt.*;
import ddf.minim.*;

MQTTClient client;

Minim m = new Minim (this);;
Sample storchHead,
	waldkauzHead,
	beckaHead,
	beckaWings,
	beckaTail,
	beckaFeet,
	palmHead,
	palmWings,
	palmFeet,
	palmTail,
	manakinWings,
	spechtHead,
	cordonFeet;
ArrayList<Sample> sampleList = new ArrayList<Sample>();
ArrayList<Sample> playingSamples = new ArrayList<Sample>();

void setup() {
  client = new MQTTClient(this);
  client.connect("mqtt://audioReceiver:09a0ec8262659795@broker.shiftr.io", "processing");
  client.subscribe("/filteredString");

  //define loops
	storchHead = new Sample( new String[]{"Club-wingd_manakin_01.wav","Club-wingd_manakin_02.wav","Club-wingd_manakin_03.wav"});
	waldkauzHead = new Sample( new String[]{"Club-wingd_manakin_01.wav","Club-wingd_manakin_02.wav","Club-wingd_manakin_03.wav"});
	beckaHead = new Sample( new String[]{"Club-wingd_manakin_01.wav","Club-wingd_manakin_02.wav","Club-wingd_manakin_03.wav"});
	beckaWings = new Sample( new String[]{"Club-wingd_manakin_01.wav","Club-wingd_manakin_02.wav","Club-wingd_manakin_03.wav"});
	beckaTail = new Sample( new String[]{"Club-wingd_manakin_01.wav","Club-wingd_manakin_02.wav","Club-wingd_manakin_03.wav"});
	beckaFeet = new Sample( new String[]{"Club-wingd_manakin_01.wav","Club-wingd_manakin_02.wav","Club-wingd_manakin_03.wav"});
	palmHead = new Sample( new String[]{"Club-wingd_manakin_01.wav","Club-wingd_manakin_02.wav","Club-wingd_manakin_03.wav"});
	palmWings = new Sample( new String[]{"Club-wingd_manakin_01.wav","Club-wingd_manakin_02.wav","Club-wingd_manakin_03.wav"});
	palmFeet = new Sample( new String[]{"Club-wingd_manakin_01.wav","Club-wingd_manakin_02.wav","Club-wingd_manakin_03.wav"});
	palmTail = new Sample( new String[]{"Club-wingd_manakin_01.wav","Club-wingd_manakin_02.wav","Club-wingd_manakin_03.wav"});
	manakinWings = new Sample( new String[]{"Club-wingd_manakin_01.wav","Club-wingd_manakin_02.wav","Club-wingd_manakin_03.wav"});
	spechtHead = new Sample( new String[]{"Club-wingd_manakin_01.wav","Club-wingd_manakin_02.wav","Club-wingd_manakin_03.wav"});
	cordonFeet = new Sample( new String[]{"Club-wingd_manakin_01.wav","Club-wingd_manakin_02.wav","Club-wingd_manakin_03.wav"});

	storchHead.defineLoop(1, 1, 0.3, 1, 5);
	waldkauzHead.defineLoop(1, 1, 0.3, 1, 5);
	beckaHead.defineLoop(1, 1, 0.3, 1, 5);
	beckaWings.defineLoop(1, 1, 0.3, 1, 5);
	beckaTail.defineLoop(1, 1, 0.3, 1, 5);
	beckaFeet.defineLoop(1, 1, 0.3, 1, 5);
	palmHead.defineLoop(1, 1, 0.3, 1, 5);
	palmWings.defineLoop(1, 1, 0.3, 1, 5);
	palmFeet.defineLoop(1, 1, 0.3, 1, 5);
	palmTail.defineLoop(1, 1, 0.3, 1, 5);
	manakinWings.defineLoop(1, 1, 0.3, 1, 5);
	spechtHead.defineLoop(1, 1, 0.3, 1, 5);
	cordonFeet.defineLoop(1, 1, 0.3, 1, 5);

	playingSamples.add(sampleList.get(0));
	playingSamples.add(sampleList.get(0));
	playingSamples.add(sampleList.get(0));
	playingSamples.add(sampleList.get(0));
	playingSamples.add(sampleList.get(0));
}

void draw() {
	//loop through sampleList
	for (Sample singleSample : sampleList) {
		singleSample.update();
	}
}

void keyPressed() {
  // client.publish("/hello", "world");
  sampleList.get(0).toggle();
}

void messageReceived(String topic, byte[] payload) {
  // println("new message: " + topic + " - " + new String(payload));
  println("new message: " + new String(payload));
	String[] arg = split(new String(payload), ",");
	eventHandler(arg);
}

void eventHandler(String[] arguments){
	if (int(arguments[3]) < 1){
		stopL(arguments);
	} else {
		startL(arguments);
	}
}

void startL(String[] arguments){
	int slot = getId(arguments[0]);
	int partId = int(arguments[3]) - 1;
	playingSamples.get(slot).stopLoop();

	println("arguments[3]: "+arguments[3]);
	println("partId: "+partId);
	playingSamples.set(slot, sampleList.get(partId));
	playingSamples.get(slot).start();
}

void stopL(String[] arguments){
	int slot = getId(arguments[0]);
	playingSamples.get(slot).stopLoop();
}

int getId(String part){
		switch(part) {
	  case "head": 
	    return 0;
	  case "wings": 
	  	return 1;
	  case "tail": 
	  	return 2;
	  case "feet": 
	  	return 3;
	  default :
	  	return 100;
	}
}