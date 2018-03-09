import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import gab.opencv.*; 
import processing.video.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class regionInterest extends PApplet {




OpenCV opencv;
Capture video;

int roiWidth = 630;
int roiHeight = 470;

boolean useROI = true;

public void setup() {
  
  video = new Capture(this, width, height, 30);
  opencv = new OpenCV(this, width, height);
  
  video.start(); 
}

public void draw() {
  if (video.available()) {
    video.read();
  }
  
  // image(video, 0, 0); 
  opencv.loadImage(video);
  
  opencv.setROI(mouseX, mouseY, roiWidth, roiHeight);
  
  opencv.findCannyEdges(20,75);
  image(opencv.getOutput(), 0, 0);
}
  public void settings() {  size(640, 480); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "regionInterest" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
