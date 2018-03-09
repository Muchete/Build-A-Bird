import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.video.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class colorTracking extends PApplet {


Capture video;
PImage myImage;

int trackColor; 


public void setup() {
  
  
  video = new Capture(this, width, height, 15);
  video.start();

  trackColor = color(255, 0, 0);
  

  myImage = loadImage("glasses.png");

}

public void draw() {
  if (video.available()) {
    video.read();
  }

  video.loadPixels();
  image(video, 0, 0);

  float worldRecord = 500; 

  int closestX = 0;
  int closestY = 0;
  
  PVector closestPoint = new PVector();
  
  for (int x=0; x < video.width; x++) {
    for (int y=0; y < video.height; y++) {
      int loc = x + y * video.width;
      int currentColor = video.pixels[loc];
      
      PVector currColorVec = new PVector(red(currentColor), green(currentColor), blue(currentColor));
      PVector trackColorVec = new PVector(red(trackColor), green(trackColor), blue(trackColor));
      float diff = currColorVec.dist(trackColorVec);
      
      if (diff < worldRecord) {
        worldRecord = diff;
        closestPoint.x = x;
        closestPoint.y = y;
      }
    }
  }

  if (worldRecord < 10) { 
    // fill(trackColor);
    // strokeWeight(4.0);
    // stroke(0);
    // ellipse(closestPoint.x, closestPoint.y, 50, 50);

    image(myImage, closestPoint.x-75, closestPoint.y-40, 150, 80);

  }
}

public void mousePressed() {
  int loc = mouseX + mouseY * video.width;
  trackColor = video.pixels[loc];
}
  public void settings() {  size(640, 480);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "colorTracking" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
