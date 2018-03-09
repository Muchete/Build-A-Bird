import gab.opencv.*;
import java.awt.Rectangle;
import processing.video.*;

OpenCV opencv;
Rectangle[] faces;
Capture video;

void setup() {
  size(640, 480);
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

void draw() {
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