import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import gab.opencv.*; 
import java.awt.Rectangle; 
import processing.video.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class faceTrack extends PApplet {





OpenCV opencv;
Rectangle[] faces;
Capture video;

public void setup() {
  
  video = new Capture(this, width, height, 30);
  opencv = new OpenCV(this, width, height);

  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  // CASCADE_CLOCK
  // CASCADE_NOSE
  // CASCADE_MOUTH
  // CASCADE_UPPERBODY
  // CASCADE_PROFILEFACE
  // CASCADE_EYE
  // CASCADE_PEDESTRIANS
  // ...
  
  video.start();
}

public void draw() {
  if (video.available()) {
    video.read();
  }
  
  image(video, 0, 0);  
  opencv.loadImage(video); 
  faces = opencv.detect();

  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);

  for (int i = 0; i < faces.length; i++) {
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  }
}
  public void settings() {  size(640, 480); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "faceTrack" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
