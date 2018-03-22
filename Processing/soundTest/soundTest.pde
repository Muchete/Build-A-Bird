import ddf.minim.*;

Minim m = new Minim (this);;
Sample manakin;
ArrayList<Sample> sampleList = new ArrayList<Sample>();

int[] partValues = {
	200,
	500,
	830,
	900
};

void setup() {
	size(600, 600);

	manakin = new Sample("manakinSample.aiff");
	manakin.defineLoop(1, 5, 0.3, 1, 5);
}

void draw() {
	//loop through sampleList
	for (Sample singleSample : sampleList) {
		singleSample.update();
	}

}

void keyPressed () {

	manakin.toggle();

}