import ddf.minim.*;

Minim m = new Minim (this);;
Sample manakin;
ArrayList<Sample> sampleList = new ArrayList<Sample>();

void setup() {
	size(600, 600);

	manakin = new Sample("manakinSample.wav");
	manakin.defineLoop(1,5,0.3,1,5);
}

void draw() {
	//loop through sampleList
	for (Sample singleSample : sampleList) {
  		singleSample.update();
	}

}

void keyPressed () {
	// if (manakin.running){ 
	// 	manakin.stopLoop();
	// } else  {
	// 	manakin.startLoop(1,5,0.3,1,5);
	// }

	manakin.toggle();
}