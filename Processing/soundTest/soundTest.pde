import ddf.minim.*;

Minim m = new Minim (this);;
Sample manakin;
ArrayList<Sample> sampleList = new ArrayList<Sample>();

void setup() {
	size(600, 600);

	manakin = new Sample("manakinSample.wav");
}

void draw() {
	//loop through sampleList
	for (Sample singleSample : sampleList) {
  		singleSample.update();
	}
}

void keyPressed () {

	manakin.doLoop(1,5,0.3,1,5);

}