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

public class flowerhead extends PApplet {





OpenCV opencv;
Rectangle[] faces;
Capture video;
PImage myImage;

boolean flower = false;

public void setup() {
    // fullScreen();
     
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
    // ...\u2021

    video.start();
    myImage = loadImage("flower.png");
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

    if (flower) {
        for (int i = 0; i < faces.length; i++) {

            float w = faces[i].width * 2,
                  h = faces[i].height * 2,
                  x = faces[i].x - w / 4,
                  y = faces[i].y - h / 4;

            image(myImage, x, y, w, h);
        }
    }

}

public void keyPressed() {
    if (keyCode == ENTER) {
        if (flower) {
            flower = false;
        } else {
            flower = true;
        }
    }
}
  public void settings() {  size(640, 480); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "flowerhead" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
