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
       cordonFeet,
       backgroundSound;
ArrayList<Sample> sampleList = new ArrayList<Sample>();
ArrayList<Sample> playingSamples = new ArrayList<Sample>();

void setup() {
	client = new MQTTClient(this);
	client.connect("mqtt://audioReceiver:09a0ec8262659795@broker.shiftr.io", "processing");
	client.subscribe("/filteredString");

	//define loops
	storchHead = new Sample( new String[] {"White_Stork_1.wav", "White_Stork_2.wav", "White_Stork_3.wav"});
	waldkauzHead = new Sample( new String[] {"Waldkauz_Schnabelknappen.wav"});
	beckaHead = new Sample( new String[] {"Bekassine_1.wav", "Bekassine_2.wav", "Bekassine_3.wav"});
	beckaWings = new Sample( new String[] {"Bekassine_1.wav", "Bekassine_2.wav", "Bekassine_3.wav"});
	beckaTail = new Sample( new String[] {"Bekassine_1.wav", "Bekassine_2.wav", "Bekassine_3.wav"});
	beckaFeet = new Sample( new String[] {"Bekassine_1.wav", "Bekassine_2.wav", "Bekassine_3.wav"});
	palmHead = new Sample( new String[] {"Club-wingd_manakin_01.wav"});
	palmWings = new Sample( new String[] {"Club-wingd_manakin_01.wav"});
	palmFeet = new Sample( new String[] {"Club-wingd_manakin_01.wav"});
	palmTail = new Sample( new String[] {"Club-wingd_manakin_01.wav"});
	manakinWings = new Sample( new String[] {"Club-wingd_manakin_01.wav", "Club-wingd_manakin_02.wav", "Club-wingd_manakin_03.wav"});
	spechtHead = new Sample( new String[] {"Specht_01.wav", "Specht_02.wav", "Specht_03.wav"});
	cordonFeet = new Sample( new String[] {"Club-wingd_manakin_01.wav", "Club-wingd_manakin_02.wav", "Club-wingd_manakin_03.wav"});

	backgroundSound = new Sample( new String[] {"Cockatoo_song_1.wav", "Cockatoo_song_2.wav", "Cockatoo_song_3.wav"});

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

	backgroundSound.defineLoop(1, 1, 0.3, 1, 6);

	playingSamples.add(sampleList.get(0));
	playingSamples.add(sampleList.get(0));
	playingSamples.add(sampleList.get(0));
	playingSamples.add(sampleList.get(0));
	playingSamples.add(sampleList.get(0));

	backgroundSound.start("body");
}

void draw() {
	//loop through sampleList
	for (Sample singleSample : sampleList) {
		singleSample.update();
	}
}

void messageReceived(String topic, byte[] payload) {
	// println("new message: " + topic + " - " + new String(payload));
	println("new message: " + new String(payload));
	String[] arg = split(new String(payload), ",");
	eventHandler(arg);
}

void eventHandler(String[] arguments) {
	int id = int(arguments[3]);

	if (int(arguments[3]) < 1) {
		stopL(arguments);
	} else {
		if (id == 1 ||
		    id == 2 ||
		    id == 5 ||
		    id == 9 ||
		    id == 11 ||
		    id == 12 ||
		    id == 13) {
			startL(arguments);
		}
	}
}

void startL(String[] arguments) {
	int slot = getId(arguments[0]);
	int partId = int(arguments[3]) - 1;
	playingSamples.get(slot).stopLoop();

	println("arguments[3]: " + arguments[3]);
	println("partId: " + partId);
	playingSamples.set(slot, sampleList.get(partId));
	playingSamples.get(slot).start(arguments[0]);
}

void stopL(String[] arguments) {
	int slot = getId(arguments[0]);
	playingSamples.get(slot).stopLoop();
}

int getId(String part) {
	switch (part) {
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