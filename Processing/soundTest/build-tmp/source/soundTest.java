import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class soundTest extends PApplet {



Minim m = new Minim (this);;
Sample manakin;
ArrayList<Sample> sampleList = new ArrayList<Sample>();

public void setup() {
	

	manakin = new Sample("Club-wingd_manakin.mp3", 2748, 3555);
}

public void draw() {
	//loop through sampleList
	for (Sample sample : sampleList) {
  		sample.update();
	}
}

public void keyPressed () {

	manakin.createLoopSequence(1,5,1,5);

}
class Sample {

	public AudioPlayer player;
	public int speed, endTime = 200000000;
	String status;

	Sample (String filename, int loopStart, int loopEnd) {
		player = m.loadFile(filename);
		player.setLoopPoints(loopStart,loopEnd);

		status = "ready";

		sampleList.add(this);
	}

	public void play(){
		player.play();
	}

	public void playLoop(int n){
		player.loop(n);
	}

	// void playRandomLoop(int min, int max) {
	// 	if (!player.isPlaying()) {

	// 		int r = int(random(min,max));
	// 		endTime = millis() + (player.length() * (r + 1));

	// 		player.loop(r);

	// 	}
	// }

	public void createLoopSequence(int loopMin, int loopMax, int spaceMin, int spaceMax){
		int iterations = PApplet.parseInt(random(loopMin,loopMax));
		int spaceBetween = PApplet.parseInt(random(spaceMin,spaceMax) * 1000);
		endTime = millis() + (player.length() * (iterations + 1));
		endTime = endTime + spaceBetween;

		playLoop(iterations);
	}

	public void update(){
		if (millis()>endTime){
			println("done!");
		}
	}
}
  public void settings() { 	size(600, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "soundTest" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
