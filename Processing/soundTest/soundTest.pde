import ddf.minim.*;

Minim m = new Minim (this);;
Sample manakin;
ArrayList<Sample> sampleList = new ArrayList<Sample>();

void setup() {
	size(600, 600);

	manakin = new Sample("Club-wingd_manakin.mp3", 2748, 3555);
}

void draw() {
	//loop through sampleList
	for (Sample sample : sampleList) {
  		sample.update();
	}
}

void keyPressed () {

	manakin.createLoopSequence(1,5,1,5);

}